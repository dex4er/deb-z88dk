/*
 *      Tape save routine
 *
 *
 *      djm 16/10/2001
 */

#include <stdlib.h>
#include <string.h>
#include <spectrum.h>

int tape_save(char *name, size_t loadstart,void *start, size_t len)
{
        struct  zxtapehdr hdr;
	int	l,i;

	l = strlen(name);
	if ( l > 10 )
		l = 10;
	for (i=0 ; i < l ; i++ )
		hdr.name[i] = name[i];
	for ( ; i < 10 ; i++ )
		hdr.name[i] = 32;

        hdr.type    = 3;
        hdr.length  = len;
        hdr.address = loadstart;
        hdr.offset  = len;

        if ( tape_save_block(&hdr,17,0) )
                return -1;

        if ( tape_save_block(start,len,255) )
                return -1;
        return 0;
}
