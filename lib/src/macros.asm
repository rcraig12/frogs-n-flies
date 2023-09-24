
#importonce 
#import "constants.asm"

// General macros

.macro SetVarA ( memLoc, byteVal ){
  lda byteVal
  sta memLoc
}

.macro SetVarX ( memLoc, byteVal ){
  ldx byteVal
  stx memLoc
}

.macro SetVarY ( memLoc, byteVal ){
  ldy byteVal
  sty memLoc
}

// ROM macros

.macro BasicAndKernelROMDisable(){
  lda #$35
  sta $0001 
}

.macro BasicROMDisable() {
  lda #$36
  sta $0001 
}

.macro ROMEnable() {
  lda #$37
  sta $0001 
}

// Screen memory macros

.macro SetBorder(color) {
  lda #color
  sta $d020
}

.macro SetBackground(color) {
  lda #color
  sta $d021
}

.macro ClearScreen(color) {
  :SetBorder( color )
  :SetBackground( color )
  lda #$20
  ldx #$ff
!loop:
  sta $0400,x
  sta $0500,x
  sta $0600,x
  sta $0700,x
  dex
  bne !loop-
}

// Kernal ROM macros

//SID macros

.macro SetupSid4Noise() {
  lda #$ff
  sta SID_VOICE3_LB
  sta SID_VOICE3_LB + 1
  lda #SID_VOICE3_CTRL
  sta SID_VOICE3_CTRL
}