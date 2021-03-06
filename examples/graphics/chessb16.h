/* 
   Mid size chessboard (16x16)
   Converted from ZX to BMP and then from BMP to sprites
   with the Daniel McKinnon's z88dk Sprite Editor
   
   This one is another fancy replacement for "chessboard.h"
*/

#include <graphics.h>
#include <games.h>

#define P_BLACK 1
#define P_WHITE 0

#define P_PAWN 0
#define P_ROOK 3
#define P_KNIGHT 2
#define P_BISHOP 1
#define P_QUEEN 4
#define P_KING 5

char pieces[] = { 
16, 16, 0x00 , 0x00 , 0x00 , 0x00 , 0x01 , 0x80 , 0x03 , 0xC0 , 0x02 , 0x40 , 0x02 
, 0x40 , 0x01 , 0x80 , 0x03 , 0xC0 , 0x06 , 0x60 , 0x04 , 0x20 , 0x06 , 0x60 
, 0x02 , 0x40 , 0x0E , 0x70 , 0x08 , 0x10 , 0x1F , 0xF8 , 0x00 , 0x00 ,

16, 16, 0x00 , 0x00 , 0x00 , 0x00 , 0x01 , 0x80 , 0x03 , 0xC0 , 0x03 , 0xC0 , 0x03 
, 0xC0 , 0x01 , 0x80 , 0x03 , 0xC0 , 0x07 , 0xE0 , 0x07 , 0xE0 , 0x07 , 0xE0 
, 0x03 , 0xC0 , 0x0F , 0xF0 , 0x0F , 0xF0 , 0x1F , 0xF8 , 0x00 , 0x00 ,

16, 16, 0x00 , 0x00 , 0x03 , 0xC0 , 0x07 , 0xE0 , 0x07 , 0xE0 , 0x07 , 0xE0 , 0x07 
, 0xE0 , 0x07 , 0xE0 , 0x0F , 0xF0 , 0x0F , 0xF0 , 0x0F , 0xF0 , 0x0F , 0xF0 
, 0x1F , 0xF8 , 0x1F , 0xF8 , 0x3F , 0xFC , 0x3F , 0xFC , 0x00 , 0x00 ,

16, 16, 0x00 , 0x00 , 0x06 , 0x60 , 0x06 , 0x60 , 0x0F , 0x70 , 0x09 , 0x90 , 0x18 
, 0xD8 , 0x12 , 0x48 , 0x17 , 0x68 , 0x12 , 0x28 , 0x12 , 0x38 , 0x18 , 0x18 
, 0x08 , 0x10 , 0x0C , 0x30 , 0x04 , 0x20 , 0x3F , 0xFC , 0x7F , 0xFE ,

16, 16, 0x00 , 0x00 , 0x06 , 0x60 , 0x06 , 0x60 , 0x0F , 0x70 , 0x0F , 0xF0 , 0x1F 
, 0xB8 , 0x1D , 0xD8 , 0x18 , 0xD8 , 0x1D , 0xE8 , 0x1D , 0xE8 , 0x1F , 0xE8 
, 0x0F , 0xF0 , 0x0F , 0xF0 , 0x07 , 0xE0 , 0x3F , 0xFC , 0x7F , 0xFE ,

16, 16, 0x07 , 0xE0 , 0x0F , 0xF0 , 0x1F , 0xF8 , 0x1F , 0xFC , 0x3F , 0xFC , 0x3F 
, 0xFC , 0x3F , 0xFC , 0x3F , 0xFC , 0x3F , 0xFC , 0x3F , 0xFC , 0x3F , 0xFC 
, 0x3F , 0xFC , 0x1F , 0xF8 , 0x7F , 0xFE , 0xFF , 0xFF , 0xFF , 0xFF ,

16, 16, 0x00 , 0x00 , 0x03 , 0x60 , 0x07 , 0xE0 , 0x04 , 0x30 , 0x0C , 0x18 , 0x19 
, 0x88 , 0x33 , 0x0C , 0x60 , 0x04 , 0x40 , 0x26 , 0x40 , 0x66 , 0x47 , 0xC2 
, 0x7D , 0x82 , 0x03 , 0x02 , 0x06 , 0x02 , 0x04 , 0x02 , 0x07 , 0xFE ,

16, 16, 0x00 , 0x00 , 0x03 , 0x60 , 0x07 , 0xF0 , 0x07 , 0xF0 , 0x0F , 0xF8 , 0x1D 
, 0xF8 , 0x39 , 0xFC , 0x7F , 0xFC , 0x7F , 0xDE , 0x7F , 0xBE , 0x7F , 0x7E 
, 0x7C , 0xFE , 0x03 , 0xFE , 0x07 , 0xFE , 0x07 , 0xFE , 0x07 , 0xFE ,

16, 16, 0x07 , 0xF0 , 0x0F , 0xF0 , 0x0F , 0xF8 , 0x1F , 0xFC , 0x3F , 0xFC , 0x7F 
, 0xFE , 0xFF , 0xFE , 0xFF , 0xFF , 0xFF , 0xFF , 0xFF , 0xFF , 0xFF , 0xFF 
, 0xFF , 0xFF , 0xFF , 0xFF , 0x0F , 0xFF , 0x0F , 0xFF , 0x0F , 0xFF ,

16, 16, 0x00 , 0x00 , 0x3B , 0xDC , 0x2A , 0x54 , 0x2E , 0x74 , 0x20 , 0x04 , 0x30 
, 0x0C , 0x1F , 0xF8 , 0x08 , 0x10 , 0x08 , 0x10 , 0x08 , 0x10 , 0x08 , 0x10 
, 0x08 , 0x10 , 0x1F , 0xF8 , 0x30 , 0x0C , 0x20 , 0x04 , 0x7F , 0xFE ,

16, 16, 0x00 , 0x00 , 0x3B , 0xDC , 0x3B , 0xDC , 0x3F , 0xFC , 0x3F , 0xFC , 0x3F 
, 0xFC , 0x18 , 0x18 , 0x0F , 0xF0 , 0x0F , 0xF0 , 0x0F , 0xF0 , 0x0F , 0xF0 
, 0x0F , 0xF0 , 0x18 , 0x18 , 0x3F , 0xFC , 0x3F , 0xFC , 0x7F , 0xFE ,

16, 16, 0x7F , 0xFE , 0x7F , 0xFE , 0x7F , 0xFE , 0x7F , 0xFE , 0x7F , 0xFE , 0x7F 
, 0xFE , 0x7F , 0xFE , 0x3F , 0xFC , 0x1F , 0xF8 , 0x1F , 0xF8 , 0x1F , 0xF8 
, 0x3F , 0xFC , 0x7F , 0xFE , 0x7F , 0xFE , 0xFF , 0xFF , 0xFF , 0xFF ,

16, 16, 0x00 , 0x00 , 0x1C , 0x38 , 0x14 , 0x28 , 0x1C , 0x38 , 0x0C , 0x30 , 0x7E 
, 0x7E , 0x5A , 0x5A , 0x73 , 0xCE , 0x3D , 0xBC , 0x29 , 0x94 , 0x39 , 0x9C 
, 0x1F , 0xF8 , 0x10 , 0x08 , 0x15 , 0xA8 , 0x10 , 0x08 , 0x1F , 0xF8 ,

16, 16, 0x00 , 0x00 , 0x1C , 0x38 , 0x14 , 0x28 , 0x1C , 0x38 , 0x0C , 0x30 , 0x7E 
, 0x7E , 0x5A , 0x5A , 0x7E , 0x7E , 0x37 , 0xEC , 0x3F , 0xFC , 0x3F , 0xFC 
, 0x1F , 0xF8 , 0x10 , 0x08 , 0x1F , 0xF8 , 0x15 , 0xA8 , 0x1F , 0xF8 ,

16, 16, 0x3E , 0x7C , 0x3E , 0x7C , 0x3E , 0x7C , 0x3F , 0xFC , 0xFF , 0xFF , 0xFF 
, 0xFF , 0xFF , 0xFF , 0xFF , 0xFF , 0xFF , 0xFF , 0x7F , 0xFE , 0x7F , 0xFE 
, 0x7F , 0xFE , 0x3F , 0xFC , 0x3F , 0xFC , 0x3F , 0xFC , 0x3F , 0xFC ,

16, 16, 0x00 , 0x00 , 0x01 , 0x80 , 0x19 , 0x98 , 0x37 , 0xEC , 0x67 , 0xE6 , 0x41 
, 0x82 , 0x45 , 0xA2 , 0x48 , 0x12 , 0x68 , 0x16 , 0x38 , 0x1C , 0x14 , 0x28 
, 0x10 , 0x08 , 0x1F , 0xF8 , 0x15 , 0xA8 , 0x15 , 0xA8 , 0x1F , 0xF8 ,

16, 16, 0x00 , 0x00 , 0x01 , 0x80 , 0x19 , 0x98 , 0x37 , 0xEC , 0x77 , 0xEE , 0x79 
, 0x9E , 0x7D , 0xBE , 0x7A , 0x5E , 0x77 , 0xEE , 0x37 , 0xEC , 0x1B , 0xD8 
, 0x1F , 0xF8 , 0x10 , 0x08 , 0x1F , 0xF8 , 0x15 , 0xA8 , 0x1F , 0xF8 ,

16, 16, 0x03 , 0xC0 , 0x1F , 0xF8 , 0x3F , 0xFC , 0x7F , 0xFE , 0xFF , 0xFF , 0xFF 
, 0xFF , 0xFF , 0xFF , 0xFF , 0xFF , 0xFF , 0xFF , 0x7F , 0xFE , 0x3F , 0xFC 
, 0x3F , 0xFC , 0x3F , 0xFC , 0x3F , 0xFC , 0x3F , 0xFC , 0x3F , 0xFC
};


PutPiece (int x, int y, int piece,int b_w)
{
  putsprite(spr_and,6+16*x+7*y,7*y,pieces+68+piece*102);
  putsprite(spr_or,6+16*x+7*y,7*y,pieces+34*b_w+piece*102);
}


DrawBoard()
{

  int     x,y,z,a,b;

  clg();

  for (x=1 ; x!=59; x++)
  {
    draw(x,x+10,x+129,x+10);
  }

  for (x=0 ; x!=8; x++)
  {
    for (y=0 ; y!=8; y++)
    {
      if (!((x+y) & 1))
      {
	  for (z=0 ; z!=7; z++)
	  {
	    a=3+16*x+7*y+z;
	    b=12+7*y+z;

	    undraw(a,b,a+14,b);
	  }
      }
    }
  }
}


