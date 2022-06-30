#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; ` marks one (up to 20)9
; 1 clicks all
; 3 empties
; q tab suspends
; 9 closes

CoordMode, Mouse, Screen

; normally 3
SetDefaultMouseSpeed, 1
#SingleInstance force


; arrays start at 1 normally.
x := []
y := []
type := []

; hotkeys


9::
	ExitApp ;  plain Exit only kills the thread
return ; probably not needed but oh well


3:: ; empties array
	Empti()
return

; store coord (max 20) but doesn't click after 
; top left key on the querty keyboard under esc
`::
	MouseGetPos, xTemp, yTemp
	Pushy(xTemp, yTemp, 0)
return

; this one clicks, though.
1::
	MouseGetPos, xTemp, yTemp
	Pushy(xTemp, yTemp, 1)
return

~:: ; shifted-version of the top-left ` key
	Suspend, Toggle
return



; click all coord
5::
	i := 1
	while i < x.Length()+1 {
		; Debug1(x[i], y[i])
		Cleeck(x[i], y[i], type[i])
		i++
	}
return







; functions


; Lclick coord x y and number of click
Cleeck(x, y, z){
	SendEvent, {Click %x% %y% Left %z%} 
	Sleep 25
}


; empty coords
Empti(){
	global
	i := x.length()
	x.RemoveAt(1, i)
	y.RemoveAt(1, i)
	type.RemoveAt(1, i)
	
}

; pushes the parameters in to the arrays in order, but if
	; the limit is reached, it pops the oldest coordinates
Pushy(toX, toY, toType){
	global
	
	x.Push(toX)
	y.Push(toY)
	type.Push(toType) ; # of click

	if(x.Length() > 20){
		x.RemoveAt(1)
		y.RemoveAt(1)
		type.RemoveAt(1)
	}
}



Debug1(x, y){
	MsgBox % "x is " . x . "`nand y is " . y
}