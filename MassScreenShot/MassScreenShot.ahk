#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; maybe make a way for the continuous ss to b turned off
; just in case u dont wanna b locked in those for a while

; debug works MsgBox % "xtemp is" . xTemp . ", ytmp is" . yTemp

; make sure to initialize variables with the 
; correct data type to keep things in order

; open instructions png
Run, Possible Instructions.png



; Debugging window
; #KeyHistory 40
; KeyHistory



CoordMode, Mouse, Screen
SetDefaultMouseSpeed, 6
; sets sendevent keydelay with pressduration inbetween each keypress
; you could adjust/comment this out to make it faster but some screenshots may be skipped
SetKeyDelay, 80, 40  

; points
xP1 := 0
yP1 := 0
xP2 := 0
yP2 := 0


; array of coordinates to convert to p1 ONLY in a batch SS
; the p2 coords will be moved with the new p1's later
; arrays start at 1 normally.
coordsX := []
coordsY := []

; insert with the InsertAt method, or Push
; RemoveAt or Pop


q & Tab::
	Suspend, Toggle
return


1:: ; store a mouse coordinate in the thing 
	; max 10
	MouseGetPos, xTemp, yTemp
	coordsX.Push(xTemp)
	coordsY.Push(yTemp)
	if(coordsX.Length() > 10){
		coordsX.Pop(xTemp)
		coordsY.Pop(yTemp)
}

; Tests()
return


-:: ; set the start position
	MouseGetPos, xP1, yP1 ; %var% to call
return


=:: ; set the end position
	MouseGetPos, xP2, yP2
return









9:: ; shift both points based on pt 1 and the current mouse position
MouseGetPos, tempx, tempy
MoveCoordi(tempx, tempy)
return

MoveCoordi(tempX, tempY){ 
	; using the temp x/y coords move the ss area
	
	global xP1, yP1, xP2, yP2
	diffX := xP1 - tempx
	diffY := yP1 - tempy

	xP1 := tempx
	yP1 := tempy

	xP2 -= diffX
	yP2 -= diffY
	; Tests()
}






0:: 
	; take the shot of screen regularly
	OneSS()
return

4:: ; SS all the coords
	; loop. array goes from 1 to 10. Loop var should go from 10 to 1 & end at 0
	; for , in tho
	for i, element in coordsX {
		MoveCoordi(coordsX[i], coordsY[i])
		OneSS()
		Sleep 256 ; in
	}
return


OneSS(){ ; take the ss with global P1 and P2 at a certain speed 
	; pretty much reformat of the old hotkey 0 but useable everywhere
	;	Send <3+s 
	; <3 is win, + is shift
	
	global
	
	SendEvent, {LWin Down}{LShift Down}s{LWin Up}{LShift Up}
	
	; SendEvent does the smooth drags
	Sleep 650
	SendEvent {Click %xP1% %yP1% Down}

	; Sleep 250
	SendEvent {Click %xP2% %yP2% Up} ; to drag

	; Sleep 50
	; SendEvent {Click %xP1% %yP1% 0} ; go back to origin
}







2:: ; empty array
	ArrayEmpty()
return

ArrayEmpty(){ ; clears arrays
	global
	coordsX.RemoveAt(1, coordsX.length())
	coordsY.RemoveAt(1, coordsY.length())
}







AddDot(){ ; add a dot where all current coordinates are
	; should be undone whenever array's empty or when you're about to SS
	
}


























; debugging things
Tests(){ 


	global
	; https://www.autohotkey.com/docs/Functions.htm#Global 


	local streng := "this is a test"
	local i := coordsX.Length()
	
	; MsgBox % "coords length before test is... " . coordsX.Length() . "`nnya" 
	. streng . "`n" 
	. i . "=i" ; debug
	; above works
	
	
	while i > 0 { 	
		
		a := coordsX[i]
		b := coordsY[i]
		streng = %streng%`ncoord(also i) in the loop: %i%`n x: %a%`n y: %b%
		; streng += "`ncoord(also i) in the loop: " i "`n x:" coordsX[i] "`n y:" coordsX[i]
		; top works, may need that format for a string 
		
		; MsgBox % streng . " nya" ; debug
		i -= 1
	}
	streng = ALL COORDS`n%streng%`ncurrent coords`n%xP1% %yP1% %xP2% %yP2%
	; not this formatt   streng += "current coords =" xP1 "" yP1 "" xP2 "" yP2 ""
	
	MsgBox % "after test Nya`n" . streng 
	. ".`ni = " . i ; debug
}