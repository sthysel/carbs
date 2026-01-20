set unstable := true
set dotenv-load := true
set positional-arguments := true
set script-interpreter := ['bash', '-euo', 'pipefail']


[private]
help:
    @just --list

[doc("Check if {{cmd}}'s exists on the path")]
[private]
[script]
have *cmd:
    for c in {{ cmd }}
    do
        echo -n "Checking for $c"
        command -v $c >/dev/null 2>&1 || { echo >&2 "....Required $c not found. Aborting."; exit 1; }
        echo "....found"
    done

[doc('install pre-commit hooks')]
qa-install-hooks: (have ('uv pre-commit'))
    uv run pre-commit install

[doc('run pre-commit QA pipeline on all files')]
qa-all:
    uv run pre-commit run --all-files

[doc('Deploy CARBS')]
[script]
deploy limit="localhost" tags="all" playbook="desktop":
    echo "Limiting deployment to {{limit}}"
    uv run ansible-playbook -v \
    --user $USER \
    --ask-become-pass \
    --inventory ansible/inventory/ \
    --limit {{limit}} \
    --tags {{tags}} \
    ansible/{{playbook}}.yml

[doc('Deploy to local WSL')]
deploy-wsl tags="all":
    just deploy localhost {{tags}} wsl

[doc('link in the dotfiles')]
dotfiles:
    caifs add -d targets '*'
