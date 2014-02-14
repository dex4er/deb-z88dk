/*
 * Headerfile for MSX specific stuff
 *
 * $Id: msx.h,v 1.4 2007/12/18 13:17:41 stefano Exp $
 */

#ifndef __MSX_H__
#define __MSX_H__

#include <sys/types.h>


// PSG register, sound, ...

// Init the PSG (reset sound etc..)
extern void __LIB__ msx_initpsg();

// Play a sound by PSG
extern void __LIB__ msx_sound(int reg, int val);

// Reat the PSG register
extern int __LIB__ __FASTCALL__ msx_readpsg(int regno);


// Video related functions

// Set the screen mode
extern void __LIB__ __FASTCALL__ msx_screen(int mode);

// Get the screen mode
extern int __LIB__ msx_screenmode();

// VRAM read
extern int __LIB__ __FASTCALL__ msx_vpeek(int address);

// VRAM write
extern void __LIB__ msx_vpoke(int address, int value);

// Switch to text mode
extern void __LIB__ msx_text();

// Disable screen
extern void __LIB__ msx_blank();

// Enable screen
extern void __LIB__ msx_noblank();

// Change the MSX color attributes
extern int __LIB__ msx_color(int foreground, int background, int border);

#define TRANSPARENT    0x00
#define BLACK          0x01
#define MEDIUM_GREEN   0x02
#define LIGHT_GREEN    0x03
#define DARK_BLUE      0x04
#define LIGHT_BLUE     0x05
#define DARK_RED       0x06
#define CYAN           0x07
#define MEDIUM_RED     0x08
#define LIGHT_RED      0x09
#define DARK_YELLOW    0x0A
#define LIGHT_YELLOW   0x0B
#define DARK_GREEN     0x0C
#define MAGENTA        0x0D
#define GRAY           0x0E
#define WHITE          0x0F


// Misc functions

// Check if MSX 1 or MSX 2
extern int __LIB__ msx_type();

// Detect the VRAM size (in KB)
extern int __LIB__ msx_vram();

// Check if the line printer is ready (1=ready, 0 if not)
extern int __LIB__ msx_lpt();

// Check if Ctrl-STOP is being pressed (1=if pressed, 0 if not)
extern int __LIB__ msx_break();

// Clear the keyboard buffer
extern void __LIB__ msx_clearkey();

// Disable the CTRL-STOP effect (when a BASIC routine is being called)
extern void __LIB__ msx_breakoff();

// Restore the CTRL-STOP break command
extern void __LIB__ msx_breakon();

#endif
