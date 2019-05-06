; Blanksong - Fills memmory from $2000 to $3500 with
; $AA. This is the value associated with no note on
; the tablature for the C64 Robot Guitar program
; The data is actually 2 nibbles per bytes, i.e. 4
; bits per tab position, upper 4 bits first then
; lower. As $A is a blank, hence $AA for all locations
; SYS 7890

*=$1e73

SONG    =$fb

        lda #$00
        sta SONG
        lda #$2f
        sta SONG+1
        ldy #$ff
        lda #$aa
START   sta (SONG),y
        dey
        bne START
        lda #$20
        cmp SONG+1
        beq END
        lda #$aa
        dec SONG+1
        jmp START
END     rts