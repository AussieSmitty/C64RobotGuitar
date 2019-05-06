; Moveup copies the screen characters of a tablature
; from row 2 up to row 1
; it also moves row 3 to row 2
; use fillrow3 to populate (or clear) this last row

*=$1e9f ; sys7839 loads below memory where song data is & row3fill
        ldx     #35     ; 35 characters across the screen
Start   lda     1425,x  ; end of 2nd tablature row e String
        sta     1145,x  ; end of 1st tab row e String
        lda     1705,x  ; end of 3rd tab row e
        sta     1425,x  ; end of 2nd tab row e ...
        lda     1465,x 
        sta     1185,x
        lda     1745,x
        sta     1465,x
        lda     1505,x 
        sta     1225,x
        lda     1785,x
        sta     1505,x
        lda     1545,x 
        sta     1265,x
        lda     1825,x
        sta     1545,x
        lda     1585,x 
        sta     1305,x
        lda     1865,x
        sta     1585,x
        lda     1625,x 
        sta     1345,x
        lda     1905,x
        sta     1625,x
        dex             ; Decriment X register
        beq     End     ; Branch to End if reached 0
        jmp     Start   ; Back to Start if not yet 0
End     rts             ; Return from subroutine
