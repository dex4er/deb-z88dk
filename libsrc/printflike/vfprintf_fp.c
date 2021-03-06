/*
 *  printf2.c - generic _printf for floating point output
 *	            also, floating point conversion functions
 *
 *	Compile with -m option
 *
 *	R M Yorston 1987
 *
 */


#include <stdio.h>
#include <float.h>
extern __LIB__ utoi() ;


#define ERR -1


vfprintf_fp(fd, ctl, ap)
    FILE *fd;
    unsigned char *ctl;
    void *ap;
{
	int i, width, prec, preclen, len, pf_count=0 ;
	unsigned char c, right, str[128], pad;
	unsigned char *sptr,  *cx ;

	while ( c = *ctl++ ) {
		if (c != '%' ) {
			fputc(c, fd) ;
			++pf_count;
			continue ;
		}
		if ( *ctl == '%' ) {
			fputc(*ctl++, fd) ;
			++pf_count;
			continue ;
		}
		cx = ctl ;
		if ( *cx == '-' ) {
			right = 0 ;
			++cx ;
		}
		else
			right = 1 ;
		if ( *cx == '0' ) {
			pad = '0' ;
			++cx ;
		}
		else
			pad = ' ' ;
		if ( (i=utoi(cx, &width)) >= 0 )
			cx += i ;
		else
			continue  ;
		if (*cx == '.') {
			if ( (preclen=utoi(++cx, &prec)) >= 0 )
				cx += preclen ;
			else
				continue ;
		}
		else
			preclen = 0 ;
		sptr = str ;
		c = *cx++ ;
		i = *ap;
		ap -= sizeof(int);
		switch(c) {
		case 'l':
            c = *cx++;
            switch ( c ) {
            case 'd':
            case 'u':
            case 'x':
                ltoa_any(*(long *)ap,str,20,( c == 'x' ? 16 : 10 ),(c == 'd'));
                ap -= sizeof(int);
                break;
            default:
                continue;
            }
            break;

        case 'd' :
            ltoa_any(i,str,7,10,1);
            break ;
        case 'x' :
            ltoa_any((unsigned long)i,str,7,16,0);
            break ;
        case 'c' :
            str[0] = i ;
            str[1] = 0 ;
            break ;
        case 's' :
            sptr = (unsigned char *)i ;
            break ;
        case 'u' :
            ltoa_any((unsigned long)i,str,7,10,0);
            break ;
        default:
            if ( preclen == 0 )
                prec = 6 ;
            if ( c == 'f' ) {
                ap -= sizeof(double) - sizeof(int) - sizeof(int);
                ftoa( *(double *)ap, prec, str ) ;
                ap -= sizeof(int); 
            }
            else if ( c == 'e' ) {
                ap -= sizeof(double) - sizeof(int) - sizeof(int);
                ftoe( *(double *)ap, prec, str ) ;
                ap -= sizeof(int); 
            }
            else
                continue ;
		}
		ctl = cx ; /* accept conversion spec */
		if ( c != 's' )
			while ( *sptr == ' ' )
				++sptr ;
		len = -1 ;
		while ( sptr[++len] )
			; /* get length */
		if ( c == 's' && len>prec && preclen>0 )
			len = prec ;
		if (right)
			while ( ((width--)-len) > 0 ) {
				fputc(pad, fd) ;
				++pf_count;
			}
		while ( len ) {
			fputc(*sptr++, fd) ;
			++pf_count;
			--len ;
			--width ;
		}
		while ( ((width--)-len) > 0 ) {
			fputc(pad, fd) ;
			++pf_count;
		}
	}
	return(pf_count) ;
}

