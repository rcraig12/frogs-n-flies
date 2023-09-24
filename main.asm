
#importonce

.const SCREEN = $0400
.const BOTTOM_LINE = $07c0

BasicUpstart2(start)

* = $0810 "Program Start"

#import "constants.asm"
#import "macros.asm"
#import "sprite.asm"

start:

  :BasicROMDisable()
  :ClearScreen(BLACK)
  :SetupSid4Noise()

  //lda #( Sprite0 / $40)
  //sta SPRITE0_PTR
  :SetupSprite(Sprite0, 0)
  
  // Set xy pos for sprite 0
  lda #$80
  sta SPRITE0_X
  sta SPRITE0_Y

  //enable sprite

  lda #%0000001
  sta $d015


loop:

  jsr printMazeLine
  jsr shiftUp
  clc
  lda SPRITE0_X
  adc #$01
  sta SPRITE0_X
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

  getMazeChar:
    lda SID_OSC3_R0
    and #$01
    beq !+
    lda #206
    jmp !++
  !:
    lda #205
  !:
    rts
  
printMazeLine:
  ldx #$00
  newChar:
    jsr getMazeChar
    sta BOTTOM_LINE,x
    inx
    cpx #41
    bne newChar
    rts

shiftUp:
  ldx #$00
!:
.for(var line = 1; line<25; line++ ){
  lda SCREEN + (line * 40),x
  sta SCREEN + (line * 40) - 40,x
}
  inx
  cpx #40
  beq !+
  jmp !-
!:
  rts



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

