;  FillRow3 - This MC routine is for my Robot Guitar project
;  It takes 2 values - SongPos (as address in RAM, LSB/MSB) at $fb 251
;  and the number of notes to write onto the screen at Row3 tablature
;  at address $fD 253. $FD should be $20 (32) for a full line, or less

*= $1ef0  ; sys7920

row3le = 1706
row3B = 1746
row3G = 1786
row3D = 1826
row3A = 1866
row3E = 1906

        ldy #$00
start   tya
        cmp $fd         ; Contents of $fd = notes (3 bytes) per note
        beq eol
        lda ($fb),y
        tax
        and #$0f
        jsr scncode
        sta row3B,y
        txa
        ldx #$04
loop1   lsr
        dex
        bne loop1
        jsr scncode
        sta row3le,y
        iny             ; Y = Y + 1
        lda ($fb),y
        dey             ; bring Y back to Y = Y            
        tax
        and #$0f
        jsr scncode
        sta row3D,y
        txa
        ldx #$04
loop2   lsr
        dex
        bne loop2
        jsr scncode
        sta row3G,y
        iny
        iny             ; Y = Y + 2
        lda ($fb),y
        dey
        dey             ; bring Y back to Y = Y
        tax
        and #$0f
        jsr scncode
        sta row3E,y
        txa
        ldx #$04
loop3   lsr
        dex
        bne loop3
        jsr scncode
        sta row3A,y
        lda #2
        clc
        adc $fb
        sta $fb
        bcc un256
        inc $fc
un256   iny             ; Y = Y + 1
        cpy #8
        beq overln
        cpy #16
        beq overln
        cpy #24
        beq overln
        jmp start
overln  inc $1f00
        inc $1f0d
        inc $1f1a
        inc $1f27
        inc $1f36
        inc $1f43
        jmp start
eol     tya
        cmp #32         ; Are we at end of line?
        beq end         ; Yes we are, goto end routine
        lda #64         ; blank lines as we're past last note
        cpy #8
        beq overln2
        cpy #16
        beq overln2
        cpy #24
        beq overln2
        jmp blankln
overln2 inc $1f9e
        inc $1fa1
        inc $1fa4
        inc $1fa7
        inc $1faa
        inc $1fad
blankln sta row3le,y
        sta row3b,y
        sta row3g,y
        sta row3d,y
        sta row3a,y
        sta row3e,y
        iny
        jmp eol
scncode cmp #$0a
        bcc zero29
        lda #64         ;64 is screen code for '-'
        rts
zero29  adc #48         ;48 is screen code for '0'
        rts
end     lda #$d2        ; return all initial screen store addresses
        sta $1f00 
        lda #$aa
        sta $1f0d
        lda #$22
        sta $1f1a
        lda #$fa
        sta $1f27
        lda #$72
        sta $1f36
        lda #$4a
        sta $1f43
        lda #$aa        
        sta $1f9e 
        lda #$d2
        sta $1fa1
        lda #$fa
        sta $1fa4
        lda #$22
        sta $1fa7
        lda #$4a
        sta $1faa
        lda #$72
        sta $1fad
        rts

