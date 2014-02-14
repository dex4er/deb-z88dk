/* Ported to the Ti82/83/83+ (rest will follow) by Henk Poley
 * Extended with different sprite sizes and sound by Stefano Bodrato
 *
 *
 *  up,down,left,right - move ball/box
 *  [Enter]            - toggle ball/box
 *  7                  - Quit
 *  9                  - Restart level
 *  +,-                - CHEAT....
 *
 * 
 *
 * For the key usage on other platforms read the original docs:
 *
 *
 *      dstar.c
 *
 *		DStar Z88 - C Demo
 *		Original TI game By A Von Dollen
 *		Converted to Z88 By D Morris
 *		Keys: Q,A,O,P,SPACE,H,G
 *
 *      dstarz88 is a conversion of a TI86 game I found with
 *      source on www.ticalc.org.
 *
 *      The original program was written by Andrew Von Dollen who
 *      in turn based it on a HP game by Joe W.
 *
 *      The aim of the game is to collect all the clear bubbles by
 *      running over them. You control either the dark bubble or
 *      the solid box. The dark bubble is used to collect the clear
 *      bubbles, and the solid box is used as a sort of movable wall.
 *
 *      Both objects carry on moving until they hit something else
 *      (except for the dark bubble in the case of clear bubbles).
 *
 *      The keys are defined in #define statements, and default thus:
 *
 *      Up:     Q
 *      Down:   A
 *      Left:   O
 *      Right:  P
 *      Quit:   G
 *      Retry:  H
 *      Switch: [SPACE]
 *
 *      Switch changes between the dark bubble and the solid box.
 *
 *      This is the first game ever produced with the Small C compiler -
 *      it was written as a statement saying that it is possible to
 *      write something easily, quickly and efficiently using the
 *      compiler. Hopefully it will be an encouragement for others to
 *      do likewise!
 *
 *      Enough twaddle, enjoy the game and study the source!
 *
 *      d. <djm@jb.man.ac.uk> 1/12/98
 *
 * * * * * * *

   Compile examples:
   
   To get a TI82 version of the game (optionally you could add sound):
   zcc +ti82 -create-app dstar.c

   To get a TI85 version of the game (optionally you could add sound):
   zcc +ti85 -Dspritesize=7 -create-app dstar.c

   To get a Spectrum 16K version of the game:
   zcc +zx -Dspritesize=16 -DSOUND -create-app -zorg=24300 dstar.c

   To get an 80 pixel graphics version of the game (Mattel Aquarius, etc):
   zcc +aquarius -Dspritesize=5 -create-app dstar.c
 
 */

#include <stdio.h>
#include <games.h>
#include <stdlib.h>
#include <graphics.h>

#ifdef SOUND
#include <sound.h>
#endif

/* #define spritesize 5   -->  very low resolutions, 80x45 pixels  */
/* #define spritesize 6   -->  TI mode, 96x54  */
/* #define spritesize 8   -->  128x72 pixels   */
/* #define spritesize 16  -->  Big screen mode 256x144  */

#ifndef spritesize
#define spritesize 6
#endif

/* Single sprite memory usage, including bytes for its size */
#if (spritesize == 16)
  #define spritemem 34
#else
  #define spritemem (spritesize+2)
#endif


#include "dstar.h"

void main()
{
	Level = (STARTLEV-1);
	SetupLevel(); /* Display the first level */

	/* Loop keyhandler till you finished the game */
	while (CheckNotFinished())
	  Gamekeys();
}


void Gamekeys(void)
{
	char *charptr;

    /* Set up a pointer to the variable we want to change
     * (either the box or the ball) */
	charptr = PieceIsBall ? &BoxOffset : &BallOffset;

	switch(getk())
	{
		case K_DOWN:
		  MovePiece(charptr,0,+1);
		  break;
		case K_UP:
		  MovePiece(charptr,0,-1);
		  break;
		case K_RIGHT:
		  MovePiece(charptr,+1,0);
		  break;
		case K_LEFT:
		  MovePiece(charptr,-1,0);
		  break;
		case K_SWITCH:
		  PieceIsBall^=1;   /* Toggle ball/box */
		  #ifdef SOUND
		    bit_fx4 (5);
		  #endif
		  while (getk() != 0) {}
		  break;
		case K_EXIT:
		  exit(0);
		case K_NEXTLEV:    /* Okay this IS cheating... */
		  if(++Level==MAXLEVEL)
		  { --Level; break; }
		  SetupLevel();
		  break;
		case K_PREVLEV:
		  if(--Level==-1)
		  { ++Level; break; }
		  /* fall thrue */
		case K_CLEAR:
		  #ifdef SOUND
		    bit_fx4 (3);
		  #endif
		  SetupLevel();
	}
}


/* The level is stored 'compressed', taking up 38 bytes a time.
 *      byte 0 - position of ball
 *      byte 1 - position of box
 *      2-37   - Level data
 *
 * Level data is stored as two bits per block, so we have to shift our
 * picked up byte round to get it.
 */
void SetupLevel(void)
{
	int x;
	char *ptr,*ptr2;

	/* Fresh level, so start with the ball */
	PieceIsBall = FALSE;

	ptr2 = Board;                 /* We copy to the Board */
	ptr  = levels + (Level * 38); /*  from the Level data */

    /* First two bytes are the ball and the box position */
	BallOffset = *ptr++;
	BoxOffset  = *ptr++;

    /* Decompress Level into the Board */
	for (x=0; x!=36; x++)
	{
		*ptr2++=((*ptr)>>6)&3;
		*ptr2++=((*ptr)>>4)&3;
		*ptr2++=((*ptr)>>2)&3;
		*ptr2++=( *ptr)    &3;
		ptr++;
	}

    /* Put the ball and box into their Board position */
	*(Board+BallOffset) = BALL;
	*(Board+BoxOffset)  = BOX;

	DrawBoard(); /* Display the clean Board */

#ifdef SOUND
	bit_fx4 (1);
#endif
}


void DrawBoard(void)
{
	int x,y;
	char *ptr;

	ptr = Board;

	clg(); /* clear the screen */

	for (y=0 ; y!=9 ; y++)
	{
		for (x=0 ; x!=16 ; x++)
		{
			putsprite(spr_or,(x*spritesize),(y*spritesize),sprites + (spritemem * (*ptr++)));
		}
	}
}



/* Check if a Level is (not) finished:
 * There are 144 squares in each Level
 *
 * Note the use of != instead of < or <=
 *  - this is faster to execute on the Z80!
 */
char CheckNotFinished(void)
{
	char *ptr;
	int i;

	ptr = Board;
	for(i=1 ; i!=144 ; i++)
	{
		if(*ptr++ == BUBB) return(TRUE);   /* Are there any bubbles? */
	}
	if(++Level == MAXLEVEL) return(FALSE); /* All levels done?       */

	SetupLevel();                          /* If not => Next Level!  */
	return(TRUE);                          /* And keep scanning keys */
}


/* Check to see if we're running into anything:
 *  - The box stops for everything (exept empty space [= 0])
 *  - The ball stops for everything exept a bubble
 */
char TestNextPosIsStop(char nextpos)
{
	if(!PieceIsBall)
	  if (nextpos==BUBB) return(FALSE);
	return(nextpos);
}


void MovePiece(char *ptr, char plusx, char plusy)
{
	char *locn;
	char temp,temp2;
	int x,y;

	temp  = PieceIsBall + 3;
	temp2 = (plusx + (plusy * 16));

	while(1) /* loop */
	{

		locn = *(ptr) + Board;
		if(TestNextPosIsStop(*(locn+temp2))) return; /* till edge */

		y = (*(ptr) / 16);
		x = (*(ptr) - (y * 16)) * spritesize;
		y *= spritesize;
		
		if(*(locn+temp2)==BUBB)
		{
			putsprite(spr_xor,x+(plusx*spritesize),y+(plusy*spritesize),sprites + (spritemem * BUBB));

			#ifdef SOUND
			bit_fx2 (5);
			#endif
		}
		
		*(locn+temp2) = *locn;
		*locn = 0;

 		/* remove old */
		putsprite(spr_xor,x,y,sprites + (spritemem * temp));
		/* put new */
		putsprite(spr_xor,x+(plusx*spritesize),y+(plusy*spritesize),sprites + (spritemem * temp));
		
		#ifdef SOUND
		bit_fx2 (2);
		#endif

		(*ptr) += temp2;
	}
}
