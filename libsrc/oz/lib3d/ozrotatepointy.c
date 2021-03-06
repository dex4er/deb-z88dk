/*
lib3d.c

Standard Wizard 3d and 4d math functions

Copyrightę 2002, Mark Hamilton

*/

#include "lib3d.h"

ozrotatepointy(Vector_t *_v, int rot)
{
    static long x, z;
    register Vector_t *v=_v;
	x = v->x;
	z = v->z;
    v->x = div16384(x * icos(rot) - z * isin(rot));
    v->z = div16384(x * isin(rot) + z * icos(rot));
}
