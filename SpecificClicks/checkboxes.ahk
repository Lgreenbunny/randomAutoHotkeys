#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; shift+`(~) suspends
; ` marks a non-click movement 
; 1 adds a click to the queue
; 2 removes the last coordinate put in
; Shift+3 (#) empties
; 4 adds a pause to the queue
; 5 clicks all saved clicks (up to 20)
; 6 unpauses a paused sequence
; 9 closes

CoordMode, Mouse, Screen

; normally 3
SetDefaultMouseSpeed, 5
#SingleInstance Force

; relative click mode on is 1
rel := 1
firstRel := 0

; arrays start at 1 normally.
x := []
y := []
type := []

; stores the last raw mouse coordinates
lastX := 0 
lastY := 0







; hotkeys


9::
	ExitApp ;  plain Exit only kills the thread
return ; probably not needed but oh well


2::	; removes the last added entry in the queue
; if there's nothing in the queue nothing is done though
	Popp()
return


#:: ; empties entire queue array
	Empti()
return


4:: ; makes pause command for queue
		Pushy(0, 0, 4)
return

6:: ; unpause the thread that was paused within the queue IF there's a paused thread
	; can't unpause thread from the same hotkey that you started the pause with
	Pause, Off ; toggle pause
return

; store coord (max 20) but doesn't click after 
; top left key on the querty keyboard under esc
`::
	MouseGetPos, xTemp, yTemp
	Pushy(xTemp, yTemp, 0)
return

; this one makes a click in the queue
1::
	MouseGetPos, xTemp, yTemp
	Pushy(xTemp, yTemp, 1)
return

~:: ; shifted-version of the top-left ` key
	Suspend, Toggle
return



; click all coord
5:: ; start running the loop
	i := 1
	while i < x.Length()+1 {
		; Debug1(x[i], y[i])
		Cleeck(x[i], y[i], type[i])
		i++
	}
return












; functions


; Lclick coord x y and number of click
Cleeck(xP, yP, zP){
	
	global
	if(zP = 4){ ; pause if the queue has a 4
		Pause, On
	}
	else if(rel = 1){
		SendEvent, {Click %xP% %yP% Left %zP%, , Rel} 
	}
	else{ ; click normally
		SendEvent, {Click %xP% %yP% Left %zP%} 
	}
	Sleep 25
}


; empty coords
Empti(){
	global
	i := x.length()
	x.RemoveAt(1, i)
	y.RemoveAt(1, i)
	type.RemoveAt(1, i)
	
	firstRel := 0 ; first coordinate neds to be set again for relative mode
}

; pushes the parameters in to the arrays in order, but if
	; the limit is reached, it pops the oldest coordinates
Pushy(toX, toY, toType){
	global
	
	if(rel = 1){ ; relative mode on
		if(firstRel = 1){ ; if the first coordinate was sent for relative mode
			arrSize := x.Count()
			x.Push(toX-lastX)
			y.Push(toY-lastY)
		}
		else{ ; mark the first coordinate as sent
			firstRel := 1
		}
		; update latest raw coordinates
		lastX := toX
		lastY := toY
	}
	else{
		x.Push(toX)
		y.Push(toY)
	}
	type.Push(toType) ; # of click
	
	
	if(x.Length() > 20){ ; if over max amount
		x.RemoveAt(1)
		y.RemoveAt(1)
		type.RemoveAt(1)
	}
}

Popp(){
	global
	
	x.Pop()
	y.Pop()
	type.Pop()
	
	; if the count reaches 0 set relative to 0
	if(x.Count() = 0)
		firstRel := 0
}




Debug1(x, y){
	MsgBox % "x is " . x . "`nand y is " . y
}