#!/bin/sh

aclocal
libtoolize --copy
autoconf
automake --foreign --copy --ignore-deps --add-missing
