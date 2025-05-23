; === fade.ahk ===

TargetWindowTitle := "PTCGPB Bot Setup [Non-Commercial 4.0 International License]"
WinGetPos, x, y, w, h, % TargetWindowTitle

stopSignalFile := A_ScriptDir "\stop.signal"
goSignalFile := A_ScriptDir "\go.signal"

Gui, Mask:New
Gui, Mask:+ToolWindow -Caption +AlwaysOnTop +E0x80000 +LastFound
Gui, Mask:Color, 2d2d2d
WinSet, Transparent, 0
WinSet, ExStyle, +0x20
Gui, Mask:Show, w380 h705 x%x% y%y% NoActivate 
FileDelete, %goSignalFile%   ; delete signal

; ===== Fade In =====
Loop 17 {
    if FileExist(stopSignalFile)
        goto CleanupAndExit
    t := A_Index * 15
    WinSet, Transparent, %t%, ahk_class AutoHotkeyGUI
    Sleep, 1
}

FileAppend,, %A_ScriptDir%\finish.signal
Sleep, 30
FileDelete, %A_ScriptDir%\finish.signal
; ======= wait signal =======
Loop {
    if FileExist(stopSignalFile)
        goto CleanupAndExit
    if FileExist(goSignalFile)
        break
    Sleep, 10
}
FileDelete, %goSignalFile%   ; delete signal

; ===== Fade Out =====
Loop 17 {
    if FileExist(stopSignalFile)
        goto CleanupAndExit
    t := 255 - A_Index * 15
    WinSet, Transparent, %t%, ahk_class AutoHotkeyGUI
    Sleep, 2
}

Gui, Mask:Destroy
ExitApp

CleanupAndExit:
Gui, Mask:Destroy
ExitApp
