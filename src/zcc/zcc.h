/* 
 * Some standard defines which are the same for all machines - hopefully!
 *
 * rcs messing up..hohum! (twiddle, keep adding here till I sort it!)
 *
 * $Id: zcc.h,v 1.22 2006/06/18 18:12:05 dom Exp $
 */

/* Very contrived, if not a Windows target then include the config file */
#if !defined(__MSDOS__) && !defined(__TURBOC__)
#ifndef _WIN32
#include "../config.h"
#endif
#endif

/* Some machine specific definitions (paths etc!) */

char *version = "v2.56 (C) 18.7.2006 D.J.Morris\n";

#ifdef AMIGA
char *amiver="$VER: zcc v2.56 (15.4.2006)";
#endif

#if defined(__MSDOS__) && defined(__TURBOC__)
/* Both predefined by Borland's Turbo C/C++ and Borland C/C++ */
#define PREFIX "c:\\z88dk"
#include <stdarg.h>
int snprintf(char * buffer, size_t bufsize, const char * format, ...);
#endif

#ifdef _WIN32
/* Predefined in 32-bit MS Visual C/C++ and Borland Builder C/C++ */
#define PREFIX "c:/z88dk"
#endif

#if _MSC_VER >= 1200
/* Predefined by Microsoft Visual C++ 6.0 */
#define snprintf _snprintf
#endif

/* hpux 9 has a slightly odd FILENAME_MAX defined */
#ifdef hpux
#undef FILENAME_MAX
#define FILENAME_MAX 1024
#endif



/* 
 *      Now some fun stuff - all this moved out of zcc.c to clean
 *      things up a little bit!
 */

#define CFILE   1
#define PFILE   2
#define AFILE   3
#define OFILE   4

#define NO      0
#define YES     1

#define Z88MATH 1
#define GENMATH 2

#define LINEMAX 1024      /* Max number of chars to read from config file*/

/*
 *      Sorry, this is hard coded, hopefully won't cause too many
 *      problems - needed to ensure math libs are linked in correctly!
 */

#define DEFFILE "zcc_opt.def"


struct args {
    char  *name;
    char   more;
    void (*setfunc)(char *);
    
};

struct confs {
        char *name;
        void (*setfunc)(char *,int);
        char *def;
};

enum iostyle { outimplied=0, outspecified, filter };

enum conf { OPTIONS, Z80EXE, CPP, LINKER, COMPILER, COPTEXE, COPYCMD, INCPATH, COPTRULES1, COPTRULES2, COPTRULES3, CRT0, LIBPATH,  LINKOPTS, ASMOPTS, APPMAKE, Z88MATHLIB,  Z88MATHFLG, STARTUPLIB, GENMATHLIB, CPPSTYLE, MPMEXE  };

