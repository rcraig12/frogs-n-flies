// Main Program

BasicUpstart2(Start)

#importonce

#import "zp.asm"
#import "memory.asm"
#import "fnfgamescrn.asm"
#import "sprites.asm"

* = $0810 "Program Start"

Start:

        sei
        lda #$35
        sta 1       // roms off

        lda #<nmi   // trap CPU NMI-vector
        sta $fffa
        lda #>nmi
        sta $fffb
        lda #<irq   // and IRQ
        sta $fffe
        lda #>irq
        sta $ffff
        lda #$01    // clear/enable Raster IRQ as an IRQ source
        sta $d019
        sta $d01a
        lda #$7f    // no timers
        sta $dc0d
        lda #50     // rasterline for IRQ
        sta $d012
        lda #$1b
        sta $d011
        lda #$81
        sta $dc0e
        cli
        jsr DisplayGameScreen
forever:
        jmp *

irq:
        sta irqa+1
        stx irqx+1
        sty irqy+1
        lda #1
        sta $d019
        dec $d020
        
        ldx #50
        dex
        bne *-1
        inc $d020
        lda $dc0d   // acknowledge IRQ
irqy:    ldy #0
irqx:    ldx #0
irqa:    lda #0
nmi:     rti


    jsr DisplayGameScreen


    jmp *

DisplayGameScreen:

        ldy #$00
!:
        lda map_data, y
        sta $0400, y 
        tax
        lda charset_attrib_data,x 
        sta $d800, y 

        lda map_data + 256, y 
        sta $0500, y 
        tax
        lda charset_attrib_data, x 
        sta $d900, y
        
        lda map_data + 512, y 
        sta $0600, y 
        tax
        lda charset_attrib_data, x 
        sta $da00, y

        lda map_data + 768, y 
        sta $0700, y
        tax
        lda charset_attrib_data, x
        sta $db00, y

        iny
        bne !-

        // Screen Data
        lda $d018
        and #%11110001
        ora #%00001000
        sta $d018

        // Set Multi Color

        lda #%11011000
        sta $d016

        // Set Colors

        lda #BLACK
        sta $d020
        lda #COLR_SCREEN
        sta $d021
        lda #COLR_CHAR_DEF
        sta $d024
        lda #COLR_CHAR_MC1
        sta $d022
        lda #COLR_CHAR_MC2
        sta $d023
        rts
    

