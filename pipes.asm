;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; FuSoYa's SMB3 Screen-Scrolling Pipes (v1.5.0)
;; Original code by FuSoYa
;; ASM build and release by SWR
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

HEADER
LOROM

;;;;;;;;;;;;;;;;;;;;
;;
;; Definitions of stuff
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

!DataLocation	= $148000				;Loaction of the data (fills 0x1000 bytes)
!Map16Page		= $04					;Map16 Page you want to use.

!CodeLength		= CodeEnd-CodeStart		;The length of the code for a RATS tag and byte fill ($FF)

!P				= (!Map16Page*$0100)	;A shorthand value.
!Speed			= $0004   				;Not recommended to change unless you know what you're doing
!DSpeed			= $0002					;Used once
!HSpeed			= $0002					;Used once

!Status1		= $7FFFE6				;Determines which actions mario will take
!Image			= $7FFFE8				;#$0042 makes him disappear and #$0043 is a peace sign
!Travel			= $7FFFEA				;#$01 means vertical and #$00 means horizontal
!Vertical		= $7FFFEC				;#$01 goes up and #$00 goes down
!Horizontal		= $7FFFEE				;#$01 goes right and #$00 goes left
!PowerupHold	= $7FFFF0				;A holder of Player's current powerup
!InPipe			= $7FFFF2				;#$0042 if Player is in a pipe and #$0000 if he isn't
!PlayerXPos		= $7FFFF4				;Player's X position in a pipe
!PlayerYPos		= $7FFFF6				;Player's Y position in a pipe

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Jump Routines to the custom block code
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ORG $00CD8B
	JSL MovementCode		;A few tweaks to fix what couldn't be done in Map16 coding
ORG $00ED20
	JSL PageCode1			;Modifies the page for the SMB3 Pipes. No other custom blocks
ORG $00ED37
	JSL PageCode2			;Updates player movement for pipe scrolling. Affects the entire Map16 page being used.

ORG $06F698
	JSL BTSD				;"Touched the bottom" code
ORG $06F6A8
	JSL BTSD				;"Touched the top" code
ORG $06F6B8
	JSL BTSD				;"Touched the sides" code
ORG $06F6D8
	JSL BTSD				;"Touched the center" code

;;;;;;;;;;;;;;;;;;;;
;;
;; Starting ASM hack data
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ORG !DataLocation
CodeStart:
	db "STAR"
	dw !CodeLength-$09
	dw !CodeLength-$09^$FFFF
	incbin info.bin
	
HighBytes:
db T>>8,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,N>>8
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,AVUV>>8,WVUV>>8
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVUV>>8,RVUV>>8
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVCV>>8,RVCV>>8
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVDV>>8,RVDV>>8
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,AVDV>>8,WVDV>>8
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,AVRU>>8,WVRU>>8
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVXU>>8,RVXU>>8
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVCU>>8,RVCU>>8
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVEU>>8,RVEU>>8
db SVUV>>8,SVED>>8,SVXU>>8,TD>>8,TU>>8,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVED>>8,RVED>>8
db SVCV>>8,SVCD>>8,SVCE>>8,BD>>8,BU>>8,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVCD>>8,RVCD>>8
db SVDV>>8,SVXD>>8,SVEU>>8,LB>>8,RB>>8,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVXD>>8,RVXD>>8
db SHLH>>8,SHCH>>8,SHRH>>8,LF>>8,RF>>8,$00,$00,$00,$00,$00,$00,$00,$00,$00,AVRD>>8,WVRD>>8
db SHXL>>8,SHCL>>8,SHEL>>8,WHLH>>8,THLH>>8,THCH>>8,THRH>>8,WHRH>>8,WHRL>>8,THXL>>8,THCL>>8,THEL>>8,THER>>8,THCR>>8,THXR>>8,WHRR>>8
db SHER>>8,SHCR>>8,SHXR>>8,AHLH>>8,BHLH>>8,BHCH>>8,BHRH>>8,AHRH>>8,AHRL>>8,BHXL>>8,BHCL>>8,BHEL>>8,BHER>>8,BHCR>>8,BHXR>>8,AHRR>>8

LowBytes:
db T,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,N
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,AVUV,WVUV
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVUV,RVUV
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVCV,RVCV
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVDV,RVDV
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,AVDV,WVDV
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,AVRU,WVRU
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVXU,RVXU
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVCU,RVCU
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVEU,RVEU
db SVUV,SVED,SVXU,TD,TU,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVED,RVED
db SVCV,SVCD,SVCE,BD,BU,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVCD,RVCD
db SVDV,SVXD,SVEU,LB,RB,$00,$00,$00,$00,$00,$00,$00,$00,$00,LVXD,RVXD
db SHLH,SHCH,SHRH,LF,RF,$00,$00,$00,$00,$00,$00,$00,$00,$00,AVRD,WVRD
db SHXL,SHCL,SHEL,WHLH,THLH,THCH,THRH,WHRH,WHRL,THXL,THCL,THEL,THER,THCR,THXR,WHRR
db SHER,SHCR,SHXR,AHLH,BHLH,BHCH,BHRH,AHRH,AHRL,BHXL,BHCL,BHEL,BHER,BHCR,BHXR,AHRR

BTSD:
	PHP
	REP #$10
	PHX
	PHA
	LDA $04
	CMP #!Map16Page
	BNE +
	LDX $03					;current block number
	LDA HighBytes-!P,x		;high byte for block address
	BNE ++
+
	PLA
	PLX
	PLP
	RTL
++
	STA $01
	LDA LowBytes-!P,x		;low byte for block address
	STA $00
	PLA
	CMP #$18
	BNE +
	LDA #$09
+
	REP #$20
	AND #$00FF
	CLC
	ADC $00
	STA $00
	LDA #$0000
	STA $7EBD05
	JSR BlockCode
	REP #$10
	PLX
	PLP
	RTL
BlockCode:
	JMP ($0000)

;;;;;;;;;;;;;;
;;
;; Block routines
;;
;;;;;;;;;;;;;;;;;;;;;;
BHER:
	JMP EnterRight
	RTS : NOP : NOP
	JMP RightEnterPress
	RTS : NOP : NOP
BHCR:
	JMP StandardRight
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
BHXR:
	JMP ExitRight
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
THER:
	JMP EnterRight
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
THCR:
	JMP ActiveRight
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
THXR:
	JMP ExitRight
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
AHRR:
	JMP RightExitTile
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
WHRR:
	JMP RightExitTile
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
BHEL:
	JMP EnterLeft
	RTS : NOP : NOP
	JMP LeftEnterPress
	RTS : NOP : NOP
BHCL:
	JMP StandardLeft
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
BHXL:
	JMP ExitLeft
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
THEL:
	JMP EnterLeft
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
THCL:
	JMP ActiveLeft
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
THXL:
	JMP ExitLeft
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
AHRL:
	JMP LeftExitTile
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
WHRL:
	JMP LeftExitTile
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
BHLH:
	JMP LeftHBlue
	RTS : NOP : NOP
	JMP RightEnterPress
	RTS : NOP : NOP
BHCH:
	JMP StandardHBlue
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
BHRH:
	JMP RightHBlue
	RTS : NOP : NOP
	JMP LeftEnterPress
	RTS : NOP : NOP
THLH:
	JMP LeftHBlue
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
THCH:
	JMP ActiveHBlue
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
THRH:
	JMP RightHBlue
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
AHRH:
	JMP BlueRHExitTile
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
WHRH:
	JMP BlueRHExitTile
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
AHLH:
	JMP BlueLHExitTile
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
WHLH:
	JMP BlueLHExitTile
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
SHER:
	JMP EnterRight
	RTS : NOP : NOP
	JMP  SmallLeftEnterPress
	RTS : NOP : NOP
SHCR:
	JMP StandardRight
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
SHXR:
	JMP ExitRight
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
SHXL:
	JMP ExitLeft
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
SHCL:
	JMP StandardLeft
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
SHEL:
	JMP EnterLeft
	RTS : NOP : NOP
	JMP SmallRightEnterPress
	RTS : NOP : NOP
SHLH:
	JMP LeftHBlue
	RTS : NOP : NOP
	JMP SmallLeftEnterPress
	RTS : NOP : NOP
SHCH:
	JMP StandardHBlue
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
SHRH:
	JMP RightHBlue
	RTS : NOP : NOP
	JMP SmallRightEnterPress
	RTS : NOP : NOP
RVEU:
	JMP RightEnterUp
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
RVCU:
	JMP StandardUp
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
RVXU:
	JMP StandardUp
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
WVRU:
	JMP TopExitTile
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
LVEU:
	JMP LeftEnterUp
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
LVCU:
	JMP StandardUp
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
LVXU:
	JMP StandardUp
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
AVRU:
	JMP TopExitTile
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
WVRD:
	JMP BottomExitTile
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
RVXD:
	JMP StandardDown
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
RVCD:
	JMP StandardDown
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
RVED:
	JMP StandardDown
	JMP RightDownEnterPress
	RTS : NOP : NOP
	RTS : NOP : NOP
AVRD:
	JMP BottomExitTile
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
LVXD:
	JMP StandardDown
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
LVCD:
	JMP StandardDown
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
LVED:
	JMP StandardDown
	JMP LeftDownEnterPress
	RTS : NOP : NOP
	RTS : NOP : NOP
WVDV:
	JMP BlueBVExitTile
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
RVDV:
	JMP RightBVBlue
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
RVCV:
	JMP StandardVBlue
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
RVUV:
	JMP StandardVBlue
	JMP RightBluePressDown
	RTS : NOP : NOP
	RTS : NOP : NOP
WVUV:
	JMP BlueTVExitTile
	RTS : NOP : NOP
	RTS : NOP : NOP
	JMP BlueTVExitTile
AVDV:
	JMP BlueBVExitTile
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
LVDV:
	JMP LeftBVBlue
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
LVCV:
	JMP StandardVBlue
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
LVUV:
	JMP StandardVBlue
	JMP LeftBluePressDown
	RTS : NOP : NOP
	RTS : NOP : NOP
AVUV:
	JMP BlueTVExitTile
	RTS : NOP : NOP
	RTS : NOP : NOP
	JMP BlueTVExitTile
SVEU:
	JMP SmallEnterUp
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
SVCE:
	JMP StandardUp
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
SVXU:
	JMP StandardUp
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
SVXD:
	JMP StandardDown
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
SVCD:
	JMP StandardDown
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
SVED:
	JMP StandardDown
	JMP SmallDownEnterPress
	RTS : NOP : NOP
	RTS : NOP : NOP
SVDV:
	JMP SmallBVBlue
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
SVCV:
	JMP StandardVBlue
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
SVUV:
	JMP StandardVBlue
	JMP SmallBluePressDown
	RTS : NOP : NOP
	RTS : NOP : NOP
BU:
	JMP SHBlueUp
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
TU:
	JMP AHBlueUp
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
BD:
	JMP SHBlueDown
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
TD:
	JMP AHBlueDown
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
LF:
	JMP SVBlueRight
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
RF:
	JMP SVBlueRight
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
LB:
	JMP SVBlueLeft
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
RB:
	JMP SVBlueLeft
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
N:
	JMP NoDirectionChange
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP
T:
	JMP InvariantBlueCorner
	RTS : NOP : NOP
	RTS : NOP : NOP
	RTS : NOP : NOP

;;;;;;;;;;;;;;;;;;
;;
;; Status-related code
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PipeSound:
	PHP
	SEP #$20
	LDA #$04                ;Pipe noise
	STA $1DF9               ;SPC700 I/O
	PLP
	RTS

Cement:
	PHP
	REP #$20
	LDA #$0130              ;Cement Block
	STA $03                 ;Block # from LM Map16 Editor
	PLP
	RTS

NoYoshiSound:
	PHP
	SEP #$20
	LDA #$20                ;Yoshi spit out an object
	STA $1DF9               ;SPC700 I/O
	PLP
	RTS

Entered:
	PHP
	REP #$20
	LDA #$0042              ;Give him the peace sign as he enters the pipe
	STA !Image
	SEP #$20
	LDA $19                 ;Powerup
	BEQ +
	STA !PowerupHold
	STZ $19
+
	PLP
	RTS

SavePowerup:
	PHP
	SEP #$20
	LDA $19
	STA !PowerupHold
	PLP
	RTS

Exited:
	PHP
	REP #$20
	LDA #$0000             ;Resets his "entrance" flag
	STA !Image
	STA !Status1
	SEP #$20
	LDA !PowerupHold
	STA $19
	PLP
	RTS

BehindStuff:
	PHP
	SEP #$20
	LDA #$02
	STA $13F9               ;"Player goes behind stuff" flag
	STA $1419               ;"Sprites go behind stuff" flag
	REP #$20
	LDA #$0042
	STA !InPipe
	PLP
	RTS

NotBehind:
	PHP
	SEP #$20
	LDA #$00
	STA $13F9
	STA $1419
	REP #$20
	LDA #$0000
	STA !InPipe
	PLP
	RTS



;;;;;;;;;;;;;;;;;;
;;
;; Directional codes
;;
;;;;;;;;;;;;;;;;;;;;;;;
GoUp:
	LDA #$0001
	STA !Vertical
	RTS

GoDown:
	LDA #$0000
	STA !Vertical
	RTS

GoRight:
	LDA #$0001
	STA !Horizontal
	RTS

GoLeft:
	LDA #$0000
	STA !Horizontal
	RTS



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Change (or no change) movement pipes
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SHBlueUp:
	JSR GoUp
	JMP StandardHBlue

AHBlueUp:
	JSR GoUp
	JMP ActiveHBlue

SHBlueDown:
	JSR GoDown
	JMP StandardHBlue

AHBlueDown:
	JSR GoDown
	JMP ActiveHBlue

SVBlueRight:
	JSR GoRight
	JMP StandardVBlue

SVBlueLeft:
	JSR GoLeft
	JMP StandardVBlue

NoDirectionChange:
	LDA !Travel
	BEQ +
	JMP StandardHBlue
+
	JMP StandardVBlue

InvariantBlueCorner:
	LDA !Travel
	BEQ +
	JSR StandardVBlue
	JMP SetHorizontal
+
	JSR StandardHBlue
	JMP SetVertical

;;;;;;;;;;;;;;;;;;;;;;;
;;
;; More status-related code
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ModY:
	LDA $03
	CMP #!P+$FD			;All the pieces it checks for are bottom horizontal pipe pieces
	BEQ +
	CMP #!P+$FA
	BEQ +
	CMP #!P+$F5
	BEQ +
	RTS
+
	LDA !PlayerYPos
	AND #$000F
	CMP #$0008
	BEQ +
	RTS
+
	LDA !PlayerYPos
	AND #$FFF7
	STA !PlayerYPos
	RTS

AddY:
	LDA $03
	CMP #!P+$E2
	BEQ +
	CMP #!P+$E0
	BEQ +
	CMP #!P+$21
	BEQ +
	CMP #!P+$20
	BEQ +
	RTS
+
	LDA !PlayerYPos
	AND #$000F
	CMP #$000C
	BEQ +
	RTS
+
	LDA !PlayerYPos
	CLC
	ADC #$0006
	STA !PlayerYPos
	RTS

FaceLeft:
	LDA #$0000
	BEQ FaceRight_br
FaceRight:
	LDA #$0001
.br
	SEP #$20
	STA $76                      ;Player's left or right status
	REP #$20
	RTS

LockControls:
	LDA $15                      ;Controller Data 1
	AND #$4040                   ;Only saves the Y/X button status
	STA $15
	STZ $17                      ;Controller Data 2
	RTS

SetStatus1:
	LDA #$0042
	STA !Status1
	RTS

SetStatus2:
	LDA #$0043                   ;Makes Player invisible
	STA !Image
	RTS

SetVertical:
	LDA #$0000
	STA !Travel
	RTS

SetHorizontal:
	LDA #$0001
	STA !Travel
	RTS

;;;;;;;;;;;;;;;;;;;
;;
;; Full code of blocks
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
StandardRight:
	LDA !InPipe
	CMP #$0042
	BEQ ActiveRight
	JSR Cement
	RTS
ActiveRight:
	JSR Entered
MoveRight:
	LDA !PlayerXPos
	CLC
	ADC #!Speed
	STA !PlayerXPos
	STA $94
	JSR ModY
	LDA !PlayerYPos
	STA $96
	JSR SetHorizontal
	JSR GoRight
	JSR LockControls
	RTS

EnterRight:
	JSR MoveRight
	JSR BehindStuff
	JSR SavePowerup
	JSR PipeSound
	RTS

ExitRight:
	JSR AddY
	JSR ActiveRight
	JSR Exited
	JSR FaceRight
	JSR PipeSound
	RTS

RightExitTile:
	LDA !InPipe
	CMP #$0042
	BNE +
	JSR MoveRight
	JSR NotBehind
+
	RTS

StandardLeft:
	LDA !InPipe
	CMP #$0042
	BEQ ActiveLeft
	JSR Cement
	RTS
ActiveLeft:
	JSR Entered
MoveLeft:
	LDA !PlayerXPos
	SEC
	SBC #!Speed
	STA !PlayerXPos
	STA $94
	JSR ModY
	LDA !PlayerYPos
	STA $96
	JSR SetHorizontal
	JSR GoLeft
	JSR LockControls
	RTS

EnterLeft:
	JSR MoveLeft
	JSR BehindStuff
	JSR SavePowerup
	JSR PipeSound
	RTS

ExitLeft:
	JSR AddY
	JSR MoveLeft
	JSR Exited
	JSR FaceLeft
	JSR PipeSound
	RTS

LeftExitTile:
	LDA !InPipe
	CMP #$0042
	BNE +
	JSR NotBehind
+
	RTS

StandardHBlue:
	LDA !Horizontal
	BNE +
	JMP StandardLeft
+
	JMP StandardRight

ActiveHBlue:
	LDA !Horizontal
	BNE +
	JMP ActiveLeft
+
	JMP ActiveRight

LeftHBlue:
	LDA !Horizontal
	BNE +
	JMP ExitLeft
+
	JMP EnterRight

RightHBlue:
	LDA !Horizontal
	BNE +
	JMP EnterLeft
+
	JMP ExitRight

BlueLHExitTile:
	LDA !Horizontal
	BNE +
	JMP LeftExitTile
+
	RTS

BlueRHExitTile:
	LDA !Horizontal
	BEQ +
	JMP RightExitTile
+
	RTS

LeftBVBlue:
	LDA !InPipe
	CMP #$0042
	BEQ +
	JMP LeftEnterUp
+
	JMP DecideVertical

RightBVBlue:
	LDA !InPipe
	CMP #$0042
	BEQ +
	JMP RightEnterUp
+
	JMP DecideVertical

LeftBluePressDown:
	LDA !InPipe
	CMP #$0042
	BEQ +
	JMP LeftDownEnterPress
+
	RTS

RightBluePressDown:
	LDA !InPipe
	CMP #$0042
	BEQ +
	JMP RightDownEnterPress
+
	RTS

SmallBVBlue:
	LDA !InPipe
	CMP #$0042
	BEQ +
	JMP SmallEnterUp
+
	JMP DecideVertical

SmallBluePressDown:
	LDA !InPipe
	CMP #$0042
	BEQ +
	JMP SmallDownEnterPress
+
	RTS

StandardVBlue:
	LDA !Vertical
	BNE +
	JMP StandardDown
+
	JMP StandardUp

BlueTVExitTile:
	LDA !Vertical
	BNE +
	JMP TVExitDisable
+
	JMP TopExitTile

DecideVertical:
	LDA !Vertical
	BNE +
	JMP StandardDown
+
	JMP StandardUp_move

BlueBVExitTile:
	LDA !Vertical
	BNE +
	JMP BottomExitTile
+
	JMP BVEnterConfirm

LeftEnterUp:
	LDA !Status1
	CMP #$0042
	BEQ EnterUp_stop
	LDA !InPipe
	CMP #$0042
	BNE +
	JMP StandardUp_move
+
	LDA $15
	AND #$0008           ;Pressing Up
	BEQ EnterUp_stop
	LDA $187A            ;Riding Yoshi flag
	BNE EnterUp_noyoshi
	LDA $94
	AND #$000F
	CMP #$0008
	BCS EnterUp_stop

EnterUp:
	LDA $94
	AND #$FFF0
	ORA #$0008
	STA !PlayerXPos
.go
	LDA $96
	SEC
	SBC #!Speed
	STA $96
	AND #$FFFC
	STA !PlayerYPos
	JSR GoUp
	JSR GoRight
	JSR BehindStuff
	JSR SavePowerup
	JSR SetStatus2
	JSR PipeSound
	RTS
.noyoshi
	JSR NoYoshiSound
.stop
	JSR Cement
	RTS

RightEnterUp:
	LDA !Status1
	CMP #$0042
	BEQ EnterUp_stop
	LDA !InPipe
	CMP #$0042
	BEQ StandardUp
	LDA $15
	AND #$0008
	BEQ EnterUp_stop
	LDA $187A
	BNE EnterUp_noyoshi
	LDA $94
	AND #$000F
	CMP #$0008
	BCC EnterUp_stop
	JMP EnterUp

StandardUp:
	LDA !InPipe
	CMP #$0042
	BEQ +
	JSR Cement
	RTS
+
	JSR Entered
.move
	LDA !PlayerYPos
	SEC
	SBC #!Speed
	STA !PlayerYPos
	STA $96
	LDA !PlayerXPos
	STA $94
	JSR SetVertical
	JSR GoUp
	JSR LockControls
	RTS

BVEnterConfirm:
	LDA !Status1
	CMP #$0042
	BEQ EnterUp_stop
	LDA !InPipe
	CMP #$0042
	BEQ StandardUp_move
	RTS

TopExitTile:
	LDA !InPipe
	CMP #$0042
	BNE +
	JSR StandardUp_move
	LDA !PlayerYPos
	AND #$FFF0
	STA $96
	JSR NotBehind
	JSR Exited
	JSR PipeSound
+
	RTS

SmallEnterUp:
	LDA $19
	AND #$00FF
	BNE ++
	LDA !Status1
	CMP #$0042
	BEQ ++
	LDA !InPipe
	CMP #$0042
	BEQ StandardUp_move
	LDA $15
	AND #$0008
	BEQ ++
	LDA $187A
	BNE +
	LDA $94
	AND #$000F
	CMP #$0008
	BCS ++
	LDA $94
	AND #$FFF0
	STA !PlayerXPos
	JMP EnterUp_go
+
	JSR NoYoshiSound
++
	JSR Cement
	RTS

TVExitDisable:
	LDA !InPipe
	CMP #$0042
	BEQ StandardDown_move
	RTS

BottomExitTile:
	LDA !InPipe
	CMP #$0042
	BNE +
	JSR StandardDown_move
	JSR NotBehind
	JSR Exited
	JSR PipeSound
+
	RTS

StandardDown:
	LDA !InPipe
	CMP #$0042
	BEQ +
	JSR Cement
	RTS
+
	JSR Entered
.move
	LDA !PlayerYPos
	CLC
	ADC #!Speed
	STA !PlayerYPos
	STA $96
	LDA !PlayerXPos
	STA $94
	JSR SetVertical
	JSR GoDown
	JSR LockControls
	RTS

LeftDownEnterPress:
	LDA !InPipe
	CMP #$0042
	BEQ StandardDown_move
	LDA $15
	AND #$0004
	BEQ .stop
	LDA $187A
	BNE .noyoshi
	LDA $94
	AND #$000F
	CMP #$0008
	BCS .stop
.offset
	LDA $94
	AND #$FFF0
	ORA #$0008
	STA !PlayerXPos
.go
	LDA $96
	CLC
	ADC #!Speed
	STA $96
	AND #$FFFC
	STA !PlayerYPos
	JSR GoDown
	JSR GoLeft
	JSR BehindStuff
	JSR SavePowerup
	JSR SetStatus1
	JSR SetStatus2
	JSR PipeSound
	RTS
.noyoshi
	JSR NoYoshiSound
.stop
	JSR Cement
	RTS

RightDownEnterPress:
	LDA !InPipe
	CMP #$0042
	BEQ StandardDown_move
	LDA $15
	AND #$0004
	BEQ LeftDownEnterPress_stop
	LDA $187A
	BNE LeftDownEnterPress_noyoshi
	LDA $94
	AND #$000F
	CMP #$0008
	BCC LeftDownEnterPress_stop
	JMP LeftDownEnterPress_offset

SmallDownEnterPress:
	LDA $19
	AND #$00FF
	BNE +++
	LDA !InPipe
	CMP #$0042
	BEQ +
	LDA $15
	AND #$0004
	BEQ +++
	LDA $187A
	BNE ++
	LDA $94
	INC A
	AND #$000F
	CMP #$0008
	BCS +++
	LDA $94
	INC A
	AND #$FFF0
	STA !PlayerXPos
	JMP LeftDownEnterPress_go
+
	JMP StandardDown_move
++
	JSR NoYoshiSound
+++
	JSR Cement
	RTS

RightEnterPress:
	LDA $15
	AND #$0001
	BEQ +
	LDA $187A
	BNE .noyoshi
	LDA $96
	AND #$000F
	BNE +
	LDA $96
	STA !PlayerYPos
	LDA $94
	AND #$FFFC
	CLC
	ADC #!Speed
	STA !PlayerXPos
	CLC
	ADC #!HSpeed 
	STA $94
	JSR GoRight
	JSR GoUp
+
	RTS
.noyoshi
	JSR NoYoshiSound
	RTS

LeftEnterPress:
	LDA $15
	AND #$0002
	BEQ .end
	LDA $187A
	BNE RightEnterPress_noyoshi
	LDA $96
	AND #$000F
	BNE .end
	LDA $96
	STA !PlayerYPos
	LDA $94
	AND #$FFFC
	SEC
	SBC #!Speed
	STA !PlayerXPos
	SEC
	SBC #!HSpeed
	STA $94
	JSR GoLeft
	JSR GoUp
.end
	RTS

SmallLeftEnterPress:
	LDA $19
	AND #$00FF
	BNE LeftEnterPress_end
	JMP RightEnterPress

SmallRightEnterPress:
	LDA $19
	AND #$00FF
	BNE LeftEnterPress_end
	JMP LeftEnterPress

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Minor ASM Hack to make SMB3 Pipes actually work
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MovementCode:
	JSL $00CEB1
	PHP
	REP #$30
	LDA !Image
	CMP #$0043
	BEQ ++
	CMP #$0042
	BNE +
	SEP #$20
	LDA #$40                ;Not visible
-
	STA $13E0               ;Player Image
+
	PLP
	RTL
++
	SEP #$20
	LDA #$26                ;Peace sign
	BRA -

PageCode1:
	STA $77
	LDA $04
	CMP #!Map16Page
	BEQ +
	LDA $77
	ORA #$09
	STA $77
+
	RTL

PageCode2:
	LDA $04
	CMP #!Map16Page
	BEQ +
	LDA #$08
	TSB $77
	RTL
+
	LDA #$04
	STA $77
	PHP
	REP #$20
	LDA !PlayerXPos
	STA $94                 ;Player's X position (level, next frame)
	LDA !PlayerYPos
	STA $96                 ;Player's Y position (level, next frame)
	PLP
	RTL

CodeEnd:	;This marks the end of the code (used for getting size of all the data).