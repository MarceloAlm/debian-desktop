#!/bin/sh

#IMAGE=~/Bat.jpg sh gdm-background.sh

IMAGE=$HOME/Projetos/gnome/theme/desktop-login-background-white.png
WORKDIR=$HOME/Projetos/gnome/theme/tmp/
#GST=/usr/share/gnome-shell/gnome-shell-theme.gresource
GST=$HOME/Projetos/gnome/theme/gnome-shell-theme.gresource
GSTRES=$(basename $GST)
GSTFILE="$WORKDIR/$GSTRES.xml"

mkdir -p $WORKDIR/theme/

for r in `gresource list $GST`; do
  gresource extract $GST $r > $WORKDIR$(echo $r | sed -e 's/^\/org\/gnome\/shell\//\//g')
done

cp "$IMAGE" $WORKDIR/theme/

echo "
#lockDialogGroup {
  background: #2e3436 url(resource:///org/gnome/shell/theme/$(basename $IMAGE));
  background-size: cover;
  background-repeat: no-repeat;
}" >> $WORKDIR/theme/gnome-shell.css

echo '<?xml version="1.0" encoding="UTF-8"?>
<gresources>
  <gresource prefix="/org/gnome/shell/theme">' > $GSTFILE
for r in `ls $WORKDIR/theme/`; do
  echo "    <file>$r</file>" >> $GSTFILE
done
echo '  </gresource>
</gresources>' >> $GSTFILE

cd $WORKDIR/theme
glib-compile-resources $GSTFILE

#sudo mv "/usr/share/gnome-shell/$GSTRES" "/usr/share/gnome-shell/${GSTRES}.backup"
#sudo mv "$GSTRES" /usr/share/gnome-shell/

#rm -r $WORKDIR

#if [ "$CREATED_TMP" = "1" ]; then
#  rm -r ~/tmp
#fi

