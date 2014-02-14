#!/bin/sh

# Some script hackery to allow global installs


destdir=$1
default=$2


rm -f lib/config/*.cfg
for file in `ls lib/config/*.lnx`; do
   dest=`echo $file | sed 's/\.lnx/\.cfg/g'`
   sed "s?DESTDIR\/?$destdir?g" < $file > $dest
done

if [ x$default != x ]; then
   cp lib/config/${default}.cfg lib/config/zcc.cfg
fi
