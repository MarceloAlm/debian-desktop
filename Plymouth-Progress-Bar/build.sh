#!/bin/bash

build=./build
color_schemes=./color-schemes

if [ ! -d $build ]; then
    mkdir $build
fi

for i in $color_schemes/*;
do
    for f in $i/*;
    do
        if [ -d $f ]; then (
            name=$(basename $f)-$(basename $(dirname $f))
            
            if [ ! -d $build/$name ]; then
                mkdir $build/$name
            fi

            if [ ! -d $build/$name/screenshots ]; then
                mkdir $build/$name/screenshots
            fi

            cp $f/background.png $build/$name &&
            cp $f/box.png $build/$name &&
            cp $f/bullet.png $build/$name &&
            cp $f/entry.png $build/$name &&
            cp $f/lock.png $build/$name &&
            cp $f/logo.png $build/$name &&
            cp $f/progress-bar.png $build/$name &&
            cp $f/progress-box.png $build/$name &&

            sed "s/::NAME::/$name/g" plymouth > $build/$name/$name.plymouth &&
            cat script.sh > $build/$name/$name.script

            # creates/updates readme screenshots
            python3 -B ./create-screenshots.py --path=$build/$name &&
            cp $build/$name/screenshots/1920x1080.png ./screenshots/$name.png &&
            cp $build/$name/screenshots/1920x1080-encrypted.png ./screenshots/$name-encrypted.png
            ) || exit 1
        fi
    done;
done;

#cp -r ./build/debian-white-branded/ /usr/share/plymouth/themes/

echo "Done!"
