#!/bin/sh

echo "Installing FreeCAD..."

arch() {
    # opencamlib and openscad are optional deps that light up the CAM and
    # OpenSCAD workbenches.
    yay_install \
        freecad \
        opencamlib \
        openscad
}
