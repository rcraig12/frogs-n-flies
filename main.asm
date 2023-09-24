
#importonce

.const SCREEN = $0400
.const BOTTOM_LINE = $07c0

BasicUpstart2(start)

* = $0810 "Program Start"

#import "lib/gamelib.asm"

start:

  :BasicAndKernelROMDisable()
  :ClearScreen(BLACK)

  :SetupSprite(Sprite0, 0)
  :SetupSprite(Sprite0, 1)
  :SetupSprite(Sprite0, 2)
  :SetupSprite(Sprite0, 3)
  :SetupSprite(Sprite0, 4)
  :SetupSprite(Sprite0, 5)
  :SetupSprite(Sprite0, 6)
  :SetupSprite(Sprite0, 7)
  
  :SpritePosition( $80, $00, $50, 0 )
  :SpritePosition( $80, $01, $62, 1 )
  :SpritePosition( $80, $00, $74, 2 )
  :SpritePosition( $80, $00, $86, 3 )
  :SpritePosition( $80, $00, $98, 4 )
  :SpritePosition( $80, $00, $aa, 5 )
  :SpritePosition( $80, $00, $bc, 6 )
  :SpritePosition( $80, $00, $ce, 7 )
 
  :EnableSprite(SPRITE0)
  :EnableSprite(SPRITE1)
  :EnableSprite(SPRITE2)
  :EnableSprite(SPRITE3)
  :EnableSprite(SPRITE4)
  :EnableSprite(SPRITE5)
  :EnableSprite(SPRITE6)
  :EnableSprite(SPRITE7)

  :DisableSprite(SPRITE2)
  :DisableSprite(SPRITE4)
  :DisableSprite(SPRITE6)
  
loop:

  clc
  lda SPRITE_X
  adc #$01
  sta SPRITE_X
  bcs toggle_high_bit_sprite0
  jmp !+

toggle_high_bit_sprite0:
  lda $d010
  eor #%00000001
  sta $d010
!:
  lda #$ff
  cmp $d012
  bne !-  
  jmp loop

*=$2000 "Sprites"
Sprite0:
	.byte   0,   0,   0
  .byte   0,   0,   0
  .byte   0, 254,   0
  .byte   3, 255, 128
  .byte   3, 255, 128
  .byte  15, 255, 224
  .byte  15, 255, 224
  .byte  14,  56, 224
  .byte  14,  56, 224
  .byte  15, 255, 224
  .byte  63, 255, 248
  .byte  63, 255, 248
  .byte  15, 255, 224
  .byte  14,   0, 224
  .byte  15, 255, 224
  .byte  15, 255, 224
  .byte  15, 255, 224
  .byte  15, 255, 224
  .byte   6, 108, 192
  .byte   0,   0,   0
  .byte   0,   0,   0

