#!/usr/bin/env bash

TMP="${TMPDIR}"
if [ "x$TMP" = "x" ]; then
  TMP="/tmp/"
fi
TMP="${TMP}maple-diffusion.$$"
rm -rf "$TMP" || true
mkdir "$TMP"
if [ $? -ne 0 ]; then
  echo "failed to mkdir $TMP" >&2
  exit 1
fi

cd $TMP

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  . /etc/lsb-release
  if [ "$DISTRIB_ID" != "Ubuntu" ]; then
    echo "Only ubuntu supported"
    exit 1
  fi
  if [ "$DISTRIB_CODENAME" != "focal" ]; then
    echo "Only ubuntu focal supported"
    exit 1
  fi
  if [ -z "$(which swift)" ]; then
    archiveName=maple-diffusion-x86_64-static-ubuntu-$DISTRIB_CODENAME.zip
  else
    archiveName=maple-diffusion-X86_64-dynamic_swift_5.7-ubuntu-$DISTRIB_CODENAME.zip
  fi
elif [[ "$OSTYPE" == "darwin"* ]]; then  # Mac OSX
  archiveName=maple-diffusion.zip
else
  echo "Unknown os type $OSTYPE, macOS or ubuntu"
  exit 1
fi

archive=$TMP/$archiveName
curl -sL https://github.com/phimage/maple-diffusion-cli/releases/latest/download/$archiveName -o $archive

if [[ "$OSTYPE" == "darwin"* ]]; then  # Mac OSX
  unzip -q $archive -d $TMP/
else
  unzip -q $archive -d $TMP/
fi

binary=$TMP/maple-diffusion

dst="/usr/local/bin"
echo "Install into $dst/maple-diffusion"
sudo rm -f $dst/maple-diffusion
sudo cp $binary $dst/

rm -rf "$TMP"
