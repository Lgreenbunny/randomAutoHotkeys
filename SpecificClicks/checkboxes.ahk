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


3::
Empti()
return


q & Tab::
Suspend, Toggle
return


; maybe make a function to handle arrays
; store coord (max 20) plus Lclick 
; top left key
`::
MouseGetPos, xTemp, yTemp
x.Push(xTemp)
y.Push(yTemp)
type.Push(1) ; # of click

if(x.Length() > 20){
	x.Pop()
	y.Pop()
	type.Pop()
}
return



; click all coord
1::

i := 1
while i < x.Length()+1 {
	; Debug1(x[i], y[i])
	Cleeck(x[i], y[i], type[i])
	i++
}
return


; functions

Cleeck(x, y, z){
	; Lclick coord x y and number of click
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

Debug1(x, y){
	MsgBox % "x is " . x . "`nand y is " . y
}