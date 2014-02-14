/*
 * Headerfile for ZX81 specific stuff
 *
 * $Id: zx81.h,v 1.9 2007/12/10 18:01:38 stefano Exp $
 */

#ifndef __ZX81_H__
#define __ZX81_H__

#include <sys/types.h>


/////////////
// CONSTANTS
/////////////

// Basic Tokens

#define TK_RND         64
#define TK_INKEYS      65
#define TK_PI          66

#define TK_DLBQUOTE    192	; Strange behaviour for '""'
#define TK_AT          193
#define TK_TAB         194

#define TK_CODE        196
#define TK_VAL         197
#define TK_LEN         198
#define TK_SIN         199
#define TK_COS         200
#define TK_TAN         201
#define TK_ASN         202
#define TK_ACS         203
#define TK_ATN         204
#define TK_LN          205
#define TK_EXP         206
#define TK_INT         207
#define TK_SQR         208
#define TK_SGN         209
#define TK_ABS         210
#define TK_PEEK        211
#define TK_USR         212
#define TK_STRS        213
#define TK_CHRS        214
#define TK_NOT         215
#define TK_STAR_STAR   216
#define TK_OR          217
#define TK_AND         218
#define TK_LEQ         219
#define TK_GEQ         220
#define TK_NEQ         221
#define TK_THEN        222
#define TK_TO          223
#define TK_STEP        224
#define TK_LPRINT      225
#define TK_LLIST       226
#define TK_STOP        227
#define TK_SLOW        228
#define TK_FAST        229
#define TK_NEW         230
#define TK_SCROLL      231
#define TK_CONTINUE    232
#define TK_CONT        232
#define TK_DIM         233
#define TK_REM         234
#define TK_FOR         235
#define TK_GO_TO       236
#define TK_GO_SUB      237
#define TK_INPUT       238
#define TK_LOAD        239
#define TK_LIST        240
#define TK_LET         241
#define TK_PAUSE       242
#define TK_NEXT        243
#define TK_POKE        244
#define TK_PRINT       245
#define TK_PLOT        246
#define TK_RUN         247
#define TK_SAVE        248
#define TK_RANDOMIZE   249
#define TK_RAND        249
#define TK_IF          250
#define TK_CLS         251
#define TK_UNPLOT      252
#define TK_CLEAR       253
#define TK_RETURN      254
#define TK_COPY        255


/////////////////////////////////
// HIGH RESOLUTION RELATED STUFF
/////////////////////////////////

// graphics page
extern int base_graphics;

// direct call for "clear graphics page"
extern void __LIB__ _clg_hr();

// Enable/disable High Resolution Graphics mode
extern void __LIB__ hrg_off();
extern void __LIB__ hrg_on();

// Copies text to HRG screen
extern void __LIB__ __FASTCALL__ copytxt(int ovmode);

// modes for copytxt
#define txt_and      47          // AND (HL)
#define txt_and_cpl  47+166*256  // AND (HL) - CPL
#define txt_or       182         // OR (HL)
#define txt_xor      174         // XOR (HL)
#define txt_or_r     31+182*256  // RRA - OR (HL)
#define txt_or_l     23+182*256  // RLA - OR (HL)
#define txt_and_r    31+47*256  // RRA - AND (HL)
#define txt_and_l    23+47*256  // RLA - AND (HL)


//////////////////
// MISC FUNCTIONS
//////////////////

// Invert screen in text mode
extern void __LIB__ invtxt();

// Mirror screen in text mode
extern void __LIB__ mirrortxt();

// Activates / Deactivates the ZX81 <-> ASCII converter,
// used in some output routine and interfacing to the BASIC strings
extern void __LIB__ __FASTCALL__ zx_asciimode();

// ZX81 <-> ASCII char conversion
extern char __LIB__ zx_ascii(char character);

// ASCII <-> ZX81 char conversion
extern char __LIB__ ascii_zx(char character);

// FAST / SLOW mode switching, available only if startup >= 2
extern void __LIB__ zx_fast();
extern void __LIB__ zx_slow();


///////////////////////////////////////////
// DIAGNOSTICS AND HARDWARE IDENTIFICATION
///////////////////////////////////////////

extern int  __LIB__ zx_basic_length(void);
extern int  __LIB__ zx_var_length(void);


///////////////////////////////
// INTERFACE FOR CALLING BASIC
///////////////////////////////

// extern int  __LIB__ __FASTCALL__ zx_goto(int line);	// calls the BASIC interpreter at a single line
extern int  __LIB__ __FASTCALL__ zx_line(int line);	// executes a single BASIC line

extern int  __LIB__              zx_getstr(char variable, char *value);
extern void __LIB__              zx_setstr(char variable, char *value);
// extern int  __LIB__ __FASTCALL__ zx_getint(char *variable);
// extern void __LIB__              zx_setint(char *variable, int value);

extern int  __LIB__ __CALLEE__   zx_getstr_callee(char variable, char *value);
extern void __LIB__ __CALLEE__   zx_setstr_callee(char variable, char *value);
// extern void __LIB__ __CALLEE__   zx_setint_callee(char *variable, int value);

#define zx_getstr(a,b)           zx_getstr_callee(a,b)
#define zx_setstr(a,b)           zx_setstr_callee(a,b)
// #define zx_setint(a,b)           zx_setint_callee(a,b)



#endif
