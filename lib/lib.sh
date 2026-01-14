# shellcheck shell=sh
# shellcheck source=/dev/null

# $1 - line to conditionally add
# $2 - file path to add
add_line_to_file() {
    mkdir -p "$(dirname "$2")"
    touch "$2"
    if ! grep -q "${1}" "${2}"; then
        echo "${1}" >> "${2}"
        echo "Added ${1} to ${2}"
    else
        echo "$1 already exists in ${2}....skipping"
    fi
}

# $1 name or path to executable
has() {
    if command -v "$1" >/dev/null 2>&1; then
        echo "$1 exists and is executable."
    else
        echo "$1 does not exist or is not executable"
        echo "you might need to run 'tuckr set $1' to install it"
        exit 1
    fi
}

# Checks if a given function $1 exists and executes
# with remaining parameters
check_and_exec_function() {
    func_name=$1
    if type "$func_name" > /dev/null 2>&1; then
        shift 1
        "$func_name" "$@"
    fi
}

# This helper function can be used for installing tools via uv
# If a corresponding env var of the form $<PACKAGE NAME>_VERSION exists, then this is assumed to be
# a version number required for the package. It will be appended to the uv install command via the == syntax
# $1 name of the tool to install via uv
uv_install() {

    has uv
    PACKAGE=$1
    shift 1
    PACKAGE_UPPERCASE=$(echo "$PACKAGE" | tr '[:lower:]' '[:upper:]' | tr '-' '_')
    PACKAGE_VERSION_VARNAME="${PACKAGE_UPPERCASE}_VERSION"
    PACKAGE_VERSION=$(eval echo "\$$PACKAGE_VERSION_VARNAME")

    if [ -n "$PACKAGE_VERSION" ]; then
        PACKAGE="$PACKAGE==$PACKAGE_VERSION"
    fi
    uv tool install --upgrade "$PACKAGE" "$@"
}

# Removes a package via a uv tool install
uv_uninstall() {
    uv tool uninstall "$@"
}

# Install a package via npm.
# You should ensure that the nodejs hook has been run previously, otherwise packages will be
# installed to non-shell aware locations
# $1 name of the package
npm_install() {
    has npm
    PACKAGE=$1
    shift 1
    PACKAGE_UPPERCASE=$(echo "$PACKAGE" | tr '[:lower:]' '[:upper:]' | tr '-' '_')
    PACKAGE_VERSION_VARNAME="${PACKAGE_UPPERCASE}_VERSION"
    PACKAGE_VERSION=$(eval echo "\$$PACKAGE_VERSION_VARNAME")

    if [ -n "$PACKAGE_VERSION" ]; then
        PACKAGE="${PACKAGE}@${PACKAGE_VERSION}"
    fi
    npm install --global "$PACKAGE" "$@"
}

# Removes a managed package via npm
npm_uninstall() {
    npm uninstall --global "$@"
}

# Gets the latest github tag from a given repo
# Note: this function removes any optional v prefix of the tag, which seems to be a github convention
# $1 repo path
github_latest_tag() {
    curl -sL "https://api.github.com/repos/${1}/releases/latest" | jq -r | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/'
}

# Gets the latest tag for a given gitlab repository
# Note: this function removes any optional v prefix of the tag, which seems to be a github convention
# $1 project name or id
gitlab_latest_tag() {
    curl -sL "https://gitlab.com/api/v4/projects/${1}/releases?per_page=1" | jq -r | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/'
}


# A wrapper function for elevating to sudo if required.
# This function helps during container builds, as usually the container runs as root and sudo isn't installed.
# This negates the need to add sudo, but must be run as root now
rootdo() {
    # If this is not run as an elevated user, then attempt to run the entire script again as sudo
    if [ "$(id -u)" -ne 0 ]; then
        sudo "$@"
    else
        "$@"
    fi
}


# Generic install script for installing per OS_ID based on the above global
# variables that determine cross platform OS infomation
#
# *_install functions are considered hooks, and should be developed per pre.sh or post.sh script as
# required
run() {

    echo "Running $SCRIPT_ACTION hook for $SCRIPT_GROUP on ${OS_TYPE}/${OS_ID}($OS_ARCH)"

    TMP_DIR=$(mktemp -d)
    cd "${TMP_DIR}" || exit
    case "$OS_TYPE" in
        Linux)
            # Run the specific OS installers before the general purpose linux one
            check_and_exec_function "${OS_ID}"

            check_and_exec_function linux
            ;;
        Darwin)
            check_and_exec_function macos
            ;;
        *)
            echo "Not a supported OS"
            exit 1
            ;;
    esac

    # perhaps there's a generic install for all operating systems. Eg uv
    check_and_exec_function generic

    # clean up the tempdir
    rm -rf "${TMP_DIR}"
}

# Get the script name
SCRIPT_ACTION=$(basename "$0" ".sh")
SCRIPT_GROUP=$(basename "$(dirname "$0")")

# Some global variables tha will be useful for performing actions based on specific flavours of linux / osx
OS_TYPE=$(uname -s)
OS_ID=""
OS_ARCH=$(uname -m)

if [ "${OS_TYPE}" = "Linux" ]; then
    . /etc/os-release
    OS_ID=${ID}

elif [ "${OS_TYPE}" = "Darwin" ]; then
    OS_ID=$(sw_vers -productName)
fi

trap run EXIT
