<!-- https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#headings --># keys but auto
Files that can be used with the Auto Hotkey program.



# SpecificClicks/checkboxes.ahk
This can be used to make a series of click patterns that can be edited at any time. Just move your mouse to a location, press a hotkey and it'll save that spot to click later on.
There's a few settings at the top of the script that can be changed: 
- `SetDefaultMouseSpeed` (0 to 100, instant to slow).
- `#SingleInstance Force` can be removed or commented out (type "; " before the #) if you want a warning before restarting the script through the file directly.
- `CoordMode, Mouse, Screen`can be changed, but it may have odd effects if you switch windows and run the pattern again. If you want more information about this, [here's the CoordMode documentation](https://www.autohotkey.com/docs/commands/CoordMode.htm).


## Default mode
- At the moment, you can use these keys to fill up the pattern: 
    - `\`` (top left of keyboard) just moves the mouse
    - `1` left clicks
    - `4` to insert a pause 
- To clear the whole pattern of clicks, you can press `Shift + 3` or `#`.
    - To only delete the most recent key press entered, press `3`
- To start clicking the pattern later, you can use `5`  
    - to unpause the script, press `6` 
- Finally, press `Shift + `\` or `~` to suspend the script and press `Shift + 9` or `(` to close it completely.

## Relative mode
This mostly the same compared to the default mode but the click pattern starts at your mouse's current position instead of a set position. To use this mode, change the 0 in `rel := 0` near the top of the code to a 1. 
- **Before making your click pattern and each time you fully clear the pattern,** press ` or 1 to set the position of the mouse. This gives the pattern an anchor point that follows your mouse cursor later on.


# MassScreenShot.ahk
Using a series of hotkeys, you can screenshot the screen easily using the Win+Shift+S windows shortcut in special ways. You can:
- set an area to screenshot
- screenshot that area (press the key again to screenshot the exact spot as much as you want)
- move that one area and screenshot again.
- mark new spots for that current selected area to be screenshotted with in a queue then screenshot them all at once.

When the code runs, it opens the instruction image with the default hotkeys and graphical examples (graphic). After the code screenshots for you, you can access them using `Win + V` or with a different clipboard program. 


If you need any help with some of the programs or you want new features, let me know.

## Instruction graphic
![Instructions](/MassScreenShot/Possible%20Instructions.png)