/*
 * Headerfile for ABC800 specific stuff
 *
 * $Id: abc800.h,v 1.1 2007/11/02 09:31:39 stefano Exp $
 */

#ifndef __ABC800_H__
#define __ABC800_H__

#include <sys/types.h>


///////////////////////////////
// ABC 800 CRTC 6845 FUNCTIONS
///////////////////////////////

// Set cursor shape
extern int  __LIB__ __FASTCALL__ abc_cursor(unsigned char shape);

// Set a parameter to CRTC control register (VDU)
extern int  __LIB__ __FASTCALL__ abc_vdu(unsigned char register, unsigned char value);

/*
	00 - Horiz. total characters
	01 - Horiz. displayed characters per line
	02 - Horiz. synch position
	03 - Horiz. synch width in characters
	04 - Vert. total lines
	05 - Vert. total adjust (scan lines)
	06 - Vert. displayed rows
	07 - Vert. synch position (character rows)
	08 - Interlace mode
	09 - Maximum scan line address
	0A - Cursor start (scan line)
	0B - Cursor end (scan line)
	0C - Start address (MSB)
	0D - Start address (LSB)
	0E - Cursor address (MSB) (read/write)
	0F - Cursor address (LSB) (read/write)
	10 - Light pen (MSB)   (read only)
	11 - Light pen (LSB)   (read only)
*/


#endif
