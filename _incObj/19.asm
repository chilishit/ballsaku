; ---------------------------------------------------------------------------
; Object 19 - GHZ Boulder
; For SONIC DEBUT
; ---------------------------------------------------------------------------

obj19:
                moveq   #0,d0
                move.b  $24(a0),d0
                move.w  obj19_Index(pc,d0.w),d1
                jmp     obj19_Index(pc,d1.w)
; ---------------------------------------------------------------------------
obj19_Index:dc.w obj19_Init-*
                dc.w obj19_Main-obj19_Index
                dc.w loc_5D86-obj19_Index
                dc.w obj19_Delete-obj19_Index
                dc.w sub_5CEE-obj19_Index
; ---------------------------------------------------------------------------

obj19_Init:
                move.b  #$18,$16(a0)
                move.b  #$C,$17(a0)
                bsr.w   ObjectFall
                jsr     (ObjFloorDist).l
                tst.w   d1
                bpl.s   obj19_Return
                add.w   d1,$C(a0)
                move.w  #0,$12(a0)
                move.b  #8,$24(a0)
                move.l  #Map_GBall,4(a0)
                move.w  #$43AA,2(a0)
                move.b  #4,1(a0)
                move.b  #3,$19(a0)
                move.b  #$18,$18(a0)
                move.b  #1,$1F(a0)
                bsr.w   sub_5DC8

obj19_Return:
                rts

; =============== S U B R O U T I N E =======================================


sub_5CEE:

; FUNCTION CHUNK AT 00005E2A SIZE 00000020 BYTES

                move.w  #$23,d1 ; '#'
                move.w  #$18,d2
                move.w  #$18,d3
                move.w  8(a0),d4
                bsr.w   SolidObject
                btst    #5,$22(a0)
                bne.s   loc_5D14
                move.w  ($FFFFD008).w,d0
                sub.w   8(a0),d0
                bcs.s   loc_5D20

loc_5D14:
                move.b  #2,$24(a0)
                move.w  #$80,$14(a0)

loc_5D20:
                bsr.w   sub_5DC8
                bsr.w   DisplaySprite
                bra.w   loc_5E2A
; End of function sub_5CEE

; ---------------------------------------------------------------------------

obj19_Main:
                btst    #1,$22(a0)
                bne.w   loc_5D86
                bsr.w   sub_5DC8
                bsr.w   sub_5E50
                bsr.w   SpeedToPos
                move.w  #$23,d1 ; '#'
                move.w  #$18,d2
                move.w  #$18,d3
                move.w  8(a0),d4
                bsr.w   SolidObject
                jsr     (Sonic_AnglePos).l
                cmpi.w  #$20,8(a0) ; ' '
                bcc.s   loc_5D70
                move.w  #$20,8(a0) ; ' '
                move.w  #$400,$14(a0)

loc_5D70:
                btst    #1,$22(a0)
                beq.s   loc_5D7E
                move.w  #$FC00,$12(a0)

loc_5D7E:
                bsr.w   DisplaySprite
                bra.w   loc_5E2A
; ---------------------------------------------------------------------------

loc_5D86:
                bsr.w   sub_5DC8
                bsr.w   SpeedToPos
                move.w  #$23,d1 ; '#'
                move.w  #$18,d2
                move.w  #$18,d3
                move.w  8(a0),d4
                bsr.w   SolidObject
                jsr     (Sonic_Floor).l
                btst    #1,$22(a0)
                beq.s   loc_5DBE
                move.w  $12(a0),d0
                addi.w  #$28,d0 ; '('
                move.w  d0,$12(a0)
                bra.s   loc_5DC0
; ---------------------------------------------------------------------------

loc_5DBE:
                nop

loc_5DC0:
                bsr.w   DisplaySprite
                bra.w   loc_5E2A

; =============== S U B R O U T I N E =======================================


sub_5DC8:
                tst.b   $1A(a0)
                beq.s   loc_5DD6
                move.b  #0,$1A(a0)
                rts
; ---------------------------------------------------------------------------

loc_5DD6:
                move.b  $14(a0),d0
                beq.s   loc_5E02
                bmi.s   loc_5E0A
                subq.b  #1,$1E(a0)
                bpl.s   loc_5E02
                neg.b   d0
                addq.b  #8,d0
                bcs.s   loc_5DEC
                moveq   #0,d0

loc_5DEC:
                move.b  d0,$1E(a0)
                move.b  $1F(a0),d0
                addq.b  #1,d0
                cmpi.b  #4,d0
                bne.s   loc_5DFE
                moveq   #1,d0

loc_5DFE:
                move.b  d0,$1F(a0)

loc_5E02:
                move.b  $1F(a0),$1A(a0)
                rts
; ---------------------------------------------------------------------------

loc_5E0A:
                subq.b  #1,$1E(a0)
                bpl.s   loc_5E02
                addq.b  #8,d0
                bcs.s   loc_5E16
                moveq   #0,d0

loc_5E16:
                move.b  d0,$1E(a0)
                move.b  $1F(a0),d0
                subq.b  #1,d0
                bne.s   loc_5E24
                moveq   #3,d0

loc_5E24:
                move.b  d0,$1F(a0)
                bra.s   loc_5E02
; End of function sub_5DC8

; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR sub_5CEE

loc_5E2A:
                move.w  8(a0),d0
                andi.w  #$FF80,d0
                move.w  ($FFFFF700).w,d1
                subi.w  #$80,d1
                andi.w  #$FF80,d1
                sub.w   d1,d0
                cmpi.w  #$280,d0
                bhi.w   DeleteObject
                rts
; END OF FUNCTION CHUNK FOR sub_5CEE
; ---------------------------------------------------------------------------

obj19_Delete:
                bsr.w   DeleteObject
                rts

; =============== S U B R O U T I N E =======================================


sub_5E50:
                move.b  $26(a0),d0
                bsr.w   CalcSine
                move.w  d0,d2
                muls.w  #$38,d2 ; '8'
                asr.l   #8,d2
                add.w   d2,$14(a0)
                muls.w  $14(a0),d1
                asr.l   #8,d1
                move.w  d1,$10(a0)
                muls.w  $14(a0),d0
                asr.l   #8,d0
                move.w  d0,$12(a0)
                rts
; End of function sub_5E50


; ---------------------------------------------------------------------------
