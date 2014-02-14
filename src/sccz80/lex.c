/*
 *      Small C+ Compiler
 *
 *      Lexical routines - string matching etc
 *
 *      $Id: lex.c,v 1.2 2004/03/26 22:06:09 denniz Exp $
 */

#include "ccdefs.h"

extern char line[];

int streq(char str1[], char str2[])
{
        int k;
        k=0;
        while (*str2) {
                if ((*str1++)!=(*str2++)) return 0;
                ++k;
        }
        return k;
}


/*
 * compare strings
 * match only if we reach end of both strings or if, at end of one of the
 * strings, the other one has reached a non-alphanumeric character
 * (so that, for example, astreq("if", "ifline") is not a match)
 */
int astreq(char *str1, char *str2)
{
        int k;

        k=0;
        while ( *str1 && *str2 ) {
                if ( *str1 != *str2 ) break ;
                ++str1 ;
                ++str2 ;
                ++k ;
        }
        if ( an(*str1) || an(*str2) ) return 0;
        return k;
}

int match(char *lit)
{
        int k;

        blanks();
        if ( (k=streq(line+lptr,lit)) ) {
                lptr += k;
                return 1;
        }
        return 0;
}

int cmatch(char lit)
{
        blanks() ;
        if (eof) error(E_EOF);
        if ( line[lptr] == lit ) {
                ++lptr ;
                return 1 ;
        }
        return 0 ;
}


/*
 * djm get symbol name into string...and check for typedef
 */

int CheckTypDef(void)
{
	char	sname[NAMEMAX];
	char	*ptr;
	SYMBOL	*sym;
	int	i=0;

	blanks();	/* Skip white space */
	ptr=line+lptr;	/* Where label starts */

	while (an(*ptr) && i<NAMEMAX ) 
		sname[i++]=*ptr++;
	sname[i]=0;
	sym=findglb(sname);
	if (sym && sym->storage == TYPDEF ) return 1;
	return 0;
}
	



	


/* djm, reversible match thing, used to scan for ascii fn defs.. 
 * this doesn't affect the line permanently! 
 */


int rmatch(char *lit)
{
        int k;
        blanks();
        if ( (k=astreq(line+lptr,lit)) ) return 1;
        return 0;
}

/*
 * djm, reversible character match, used to scan for local statics
 */

int rcmatch(char lit)
{
        blanks() ;
        if (eof) error(E_EOF);
        if ( line[lptr] == lit ) {
                return 1 ;
        }
        return 0 ;
}


int amatch(char *lit)
{
        int k;

        blanks();
        if ( (k=astreq(line+lptr,lit)) ) {
                lptr += k;
                return 1;
        }
        return 0;
}

/*
 *      Consume unecessary identifiers (if present)
 */


int swallow(char *lit)
{
        return (amatch(lit));
}
