/*
 *        Quick 'n' dirty mym to tap converter
 *
 *        Usage: bin2tap [binfile] [tapfile]
 *
 *        Dominic Morris  - 08/02/2000 - tapmaker
 *        Stefano Bodrato - 03/12/2000 - bin2tap
 *        Stefano Bodrato - 29/05/2001 - ORG parameter added
 *        Dominic Morris  - 10/03/2003 - integrated into appmake & options
 *        Stefano Bodrato - 19/07/2007 - BASIC block 'merge' feature
 *
 *        Creates a new TAP file (overwriting if necessary) just ready to run.
 *        Use tapmaker to customize your work.
 *
 *        $Id: zx.c,v 1.2 2007/06/19 09:20:50 stefano Exp $
 */

#include "appmake.h"



static char             *binname      = NULL;
static char             *crtfile      = NULL;
static char             *outfile      = NULL;
static char             *blockname    = NULL;
static char             *merge        = NULL;
static int               origin       = -1;
static char              help         = 0;
static unsigned char     parity;


/* Options that are available for this module */
option_t zx_options[] = {
    { 'h', "help",     "Display this help",          OPT_BOOL,  &help},
    { 'b', "binfile",  "Linked binary file",         OPT_STR,   &binname },
    { 'c', "crt0file", "crt0 file used in linking",  OPT_STR,   &crtfile },
    { 'o', "output",   "Name of output file",        OPT_STR,   &outfile },
    {  0 , "merge",    "Merge an external TAPE block",        OPT_STR,   &merge },
    {  0 , "org",      "Origin of the binary",       OPT_INT,   &origin },
    {  0 , "blockname", "Name of the code block in tap file", OPT_STR, &blockname},
    {  0 ,  NULL,       NULL,                        OPT_NONE,  NULL }
};


int zx_exec(char *target)
{
    char    filename[FILENAME_MAX+1];
    char    name[11];
    char    mybuf[20];
    FILE    *fpin, *fpout, *fpmerge;
    long    pos;
    int     c;
    int     i;
    int     len, mlen;

    if ( help )
        return -1;

    if ( binname == NULL || ( crtfile == NULL && origin == -1 ) ) {
        return -1;
    }

    if ( outfile == NULL ) {
        strcpy(filename,binname);
        suffix_change(filename,".tap");
    } else {
        strcpy(filename,outfile);
    }

    if ( blockname == NULL )
        blockname = binname;
        


    if ( origin != -1 ) {
        pos = origin;
    } else {
        if ( ( pos = parameter_search(crtfile,".sym","MYZORG") ) == -1 ) {
            myexit("Could not find parameter ZORG (not z88dk compiled?)\n",1);
        }
    }


    if ( (fpin=fopen(binname,"rb") ) == NULL ) {
        fprintf(stderr,"Can't open input file %s\n",binname);
        myexit(NULL,1);
    }

 
/*
 *        Now we try to determine the size of the file
 *        to be converted
 */
    if ( fseek(fpin,0,SEEK_END) ) {
        fprintf(stderr,"Couldn't determine size of file\n");
        fclose(fpin);
        myexit(NULL,1);
    }

    len=ftell(fpin);

    fseek(fpin,0L,SEEK_SET);

    if ( (fpout=fopen(filename,"wb") ) == NULL ) {
        fclose(fpin);
        myexit("Can't open output file\n",1);
    }

/* Open and check the optional "merge file" */
    mlen=0;
    if ( merge != NULL ) {
        if ( (fpmerge=fopen(merge,"rb") ) == NULL ) {
            printf("File for 'merge' not found: %s\n",merge);
            fclose(fpin);
            fclose(fpout);
            myexit(NULL,1);
        }
        /* check the header type (first block must be BASIC) */
        fseek(fpmerge,3,SEEK_SET);
        c=getc(fpmerge);
        if ( c != 0 ) {
            fprintf(stderr,"BASIC block not found in file %s\n",merge);
            fclose(fpin);
            fclose(fpout);
            myexit(NULL,1);
        }
        fseek(fpmerge,21,SEEK_SET);
        mlen=getc(fpmerge)+256*getc(fpmerge);  /* get block length */
        getc(fpmerge);                         /* skip block type */
    }

/* BASIC loader */

/* Write out the BASIC header file */
    writeword_p(19,fpout,&parity);         /* Header len */
    writebyte_p(0,fpout,&parity);          /* Header is a type 0 block */

    parity=0;
    writebyte_p(0,fpout,&parity);             /* Filetype (Basic) */
    writestring_p("Loader    ",fpout,&parity);
    writeword_p(0x1e + mlen,fpout,&parity);   /* length */
    writeword_p(10,fpout,&parity);            /* line for auto-start */
    writeword_p(0x1e + mlen,fpout,&parity);   /* length (?) */
    writebyte_p(parity,fpout,&parity);


/* Write out the BASIC loader program */
    writeword_p(32 + mlen,fpout,&parity);         /* block lenght: works if ORG is between 10001 and 65536 (4 digit numbers) */
    parity=0;
    writebyte_p(255,fpout,&parity);        /* Data has a block type of 255 */
    writebyte_p(0,fpout,&parity);          /* MSB of BASIC line number */
    writebyte_p(10,fpout,&parity);         /* LSB... */
    writeword_p(26,fpout,&parity);         /* BASIC line length */
    writebyte_p(0xfd,fpout,&parity);       /* CLEAR */
    writebyte_p(0xb0,fpout,&parity);       /* VAL */
    sprintf(mybuf,"\"%i\":",pos-1);        /* location for CLEAR */
    writestring_p(mybuf,fpout,&parity);
    writebyte_p(0xef,fpout,&parity);       /* LOAD */
    writebyte_p('"',fpout,&parity);
    writebyte_p('"',fpout,&parity);
    writebyte_p(0xaf,fpout,&parity);       /* CODE */
    writebyte_p(':',fpout,&parity);
    writebyte_p(0xf9,fpout,&parity);       /* RANDOMIZE */
    writebyte_p(0xc0,fpout,&parity);       /* USR */
    writebyte_p(0xb0,fpout,&parity);       /* VAL */
    sprintf(mybuf,"\"%i\"",pos);           /* Location for USR */
    writestring_p(mybuf,fpout,&parity);
    writebyte_p(0x0d,fpout,&parity);       /* ENTER (end of BASIC line) */

/* Optionally merge a BASIC block from a TAP file */

    if ( merge != NULL ) {
      for (i=0; i<mlen;i++) {
        c=getc(fpmerge);
        writebyte_p(c,fpout,&parity);
      }
      fclose (fpmerge);
    }

/* Common tail for the BASIC block */
    writebyte_p(parity,fpout,&parity);


/* M/C program */

/* Write out the code header file */
    writeword_p(19,fpout,&parity);         /* Header len */
    writebyte_p(0,fpout,&parity);          /* Header is a type 0 block */
    parity=0;
    writebyte_p(3,fpout,&parity);          /* Filetype (Code) */
/* Deal with the filename */
    if (strlen(blockname) >= 10 ) {
        strncpy(name,blockname,10);
    } else {
        strcpy(name,blockname);
        strncat(name,"          ",10-strlen(blockname));
    }
    for        (i=0;i<=9;i++)
        writebyte_p(name[i],fpout,&parity);
    writeword_p(len,fpout,&parity);
    writeword_p(pos,fpout,&parity);        /* load address */
    writeword_p(0,fpout,&parity);          /* offset */
    writebyte_p(parity,fpout,&parity);

/* Now onto the data bit */
    writeword_p(len+2,fpout,&parity);      /* Length of next block */
        
    parity=0;
    writebyte_p(255,fpout,&parity);        /* Data has a block type of 255 */
    for (i=0; i<len;i++) {
        c=getc(fpin);
        writebyte_p(c,fpout,&parity);
    }
    writebyte_p(parity,fpout,&parity);
    fclose(fpin);
    fclose(fpout);
}





