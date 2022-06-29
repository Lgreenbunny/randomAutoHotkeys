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
SetDefaultMouseSpeed, 3
#SingleInstance force


; arrays start at 1 normally.
x := []
y := []


9::
ExitApp ;  plain Exit only kills the thread
return ; probably not needed but oh well

3::
Empti()
return

q & Tab::
Suspend, Toggle
return




; store coord (max 20)
; top left key
`::
MouseGetPos, xTemp, yTemp
x.Push(xTemp)
y.Push(yTemp)
if(x.Length() > 20){
	x.Pop()
	y.Pop()
}
return






; click all coord
1::

i := 1
while i < x.Length()+1 {
	; Debug1(x[i], y[i])
	Cleeck(x[i], y[i])
	i++
}
return

Cleeck(x, y){
	SendEvent, {Click %x% %y%}
	Sleep 25
}




; empty coords
Empti(){
	global
	x.RemoveAt(1,x.length())
	y.RemoveAt(1,y.length())
	
}

Debug1(x, y){
	MsgBox % "x is " . x . "`nand y is " . y
}