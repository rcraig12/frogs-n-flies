#importonce

.const SPRITE_PTR = $07f8
.const SPRITE_X = $d000
.const SPRITE_X_UPPER = $d010
.const SPRITE_Y = $d001
.const SPRITE_ENABLE = $d015

.const SPRITE0_PTR = $07f8
.const SPRITE0_X = $d000
.const SPRITE0_Y = $d001

.const SPRITE1_PTR = $07f9
.const SPRITE1_X = $d002
.const SPRITE1_Y = $d003

.const SPRITE2_PTR = $07fa
.const SPRITE2_X = $d004
.const SPRITE2_Y = $d005

.const SPRITE3_PTR = $07fb
.const SPRITE3_X = $d006
.const SPRITE3_Y = $d007

.const SPRITE4_PTR = $07fc
.const SPRITE4_X = $d008
.const SPRITE4_Y = $d009

.const SPRITE5_PTR = $07fd
.const SPRITE5_X = $d00a
.const SPRITE5_Y = $d00b

.const SPRITE6_PTR = $07fe
.const SPRITE6_X = $d00c
.const SPRITE6_Y = $d00d

.const SPRITE7_PTR = $07ff
.const SPRITE7_X = $d00e
.const SPRITE7_Y = $d00f

.const SPRITE0 = 1
.const SPRITE1 = 2
.const SPRITE2 = 4
.const SPRITE3 = 8
.const SPRITE4 = 16
.const SPRITE5 = 32
.const SPRITE6 = 64
.const SPRITE7 = 128


.macro SetupSprite( memLoc, spriteNum ){
  lda #( memLoc / $40 )
  sta SPRITE_PTR + spriteNum
}

.macro SpritePosition( xLo, xHi , y, spriteNum ) {
  lda #xLo
  sta SPRITE_X + (spriteNum * 2)
  //lda SPRITE_X_HI + (spriteNum * 2)
  lda #y
  sta SPRITE_Y + (spriteNum * 2)
}

.macro EnableSprite( spriteNum ){
  lda #spriteNum  
  ora SPRITE_ENABLE
  sta SPRITE_ENABLE
}

.macro DisableSprite( spriteNum ){
  lda #spriteNum 
  eor #$ff
  and SPRITE_ENABLE
  sta SPRITE_ENABLE
}

.namespace Sprite {

  SpriteSlot1: {

    lda #00
    sta $0420
    rts

  }

  SpriteSlot2: {

    lda #00
    sta $0422
    rts

  }
  
}
