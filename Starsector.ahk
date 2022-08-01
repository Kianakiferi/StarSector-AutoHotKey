#NoEnv
#SingleInstance, Force
; #Warn
#Include, <csv>

SendMode Input
SetWorkingDir %A_ScriptDir%
SetKeyDelay, 35

;region Main
commandFileName := "quick_commands.csv"
if !FileExist(commandFileName) {
    ExitApp
    ; TODO: 写入默认热命令
}

CSV_Load(commandFileName,"commandsCSV")

global commandList := LoadCommands()

RegistCommands(commandList)

AddTrayMenu()
Return

;endregion

;region Functions

LoadCommands() {
    commandList := Array() 

    count := (CSV_TotalRows("commandsCSV"))
    ;count := 6

    index := 2
    While, (index < count) {
        ; First cell
        hotkeyCell := CSV_ReadCell("commandsCSV", index, 1)
        If(InStr(hotkeyCell, "#")) {
            index ++
            Continue
        }

        hotkeyCell := ConvertKeyNameToModifierSymbol(hotkeyCell)

        ;Second cell
        typeCell := CSV_ReadCell("commandsCSV", index, 2)

        ;Third cell
        commandsCell := CSV_ReadCell("commandsCSV", index, 3)
        If (InStr(commandsCell, ",")) {
            commandsCell := StrSplit(commandsCell, ",", " ")
        }

        command := New Command(hotkeyCell, typeCell, commandsCell)
        commandList.Insert(command)

        index ++
    }

    Return commandList
}

RegistCommands(commandList) {
    ;Hotkey, If
    Hotkey, IfWinActive, ahk_class LWJGL

    For index, item in commandList {
        keyName := item.Hotkeys
        Hotkey, %keyName%, ExecuteCallBack
    }
}

; UNUSED
DisableCommands(commandList) {
    ;Hotkey, If
    Hotkey, IfWinActive, ahk_class LWJGL

    For index, item in commandList {
        keyName := item.Hotkeys
        Hotkey, %keyName%, Off
    }
}

AddTrayMenu() {
    Menu, Tray, NoStandard
    Menu, Tray, Add, Open Commands.csv, OpenCommandsCSVHandler,
    Menu, Tray, Add, Reload Commands, ReloadCommandHandler,
    Menu, Tray, add ; Separator
    Menu, Tray, Standard
}

ConvertKeyNameToModifierSymbol(hotkeyName) {
    hotkeyName := StrReplace(hotkeyName, "+", "")

    hotkeyName := StrReplace(hotkeyName, "Win", "#")
    hotkeyName := StrReplace(hotkeyName, "Alt", "!")
    hotkeyName := StrReplace(hotkeyName, "Ctrl", "^")
    hotkeyName := StrReplace(hotkeyName, "Shift", "+")

    Return hotkeyName
}

ExecuteCallBack() {
    ; TODO: better callback, not "for", but passing a data or using FuncObject

    For index, item in commandList {
        If (A_ThisHotkey == item.Hotkeys) {
            Execute(item.ExecuteType, item.Commands)
            Break
        }
    }
}

;#IfWinActive ahk_class LWJGL

Execute(executeType, commands){
    Switch executeType 
    {
    Case "Send":
        SendCommand(commands)
    Return
Case "Run":
    If IsObject(commands) {
        RunCommandArray(commands)
        Return
    }
    RunCommand(commands)
Return
Default:
Return
}
}

SendCommand(text) {
    Send %text%
    Send {Space}
}

RunCommand(text) {
    Send %text%
    Sleep 100
    Send {Enter}
    Sleep 100
}

RunCommandArray(array) {
    for index, element in array
    {
        RunCommand(element)
    }
}

;#IfWinActive

OpenCommandsCSVHandler:
    Run quick_commands.csv
    Return

ReloadCommandHandler:
    commandList := ""
    Reload
    Return

;endregion

;region Models
class Command {
    Hotkeys {
        get {
            Return this.stored_Hotkeys
        }
        set {
            Return this.stored_Hotkeys := value
        }
    }
    ExecuteType {
        get {
            Return this.stored_ExecuteType
        }
        set {
            Return this.stored_ExecuteType := value
        }
    }
    Commands {
        get {
            Return this.stored_Commands
        }
        set {
            Return this.stored_Commands := value
        }
    }

    __New(hotkeys, executeType, commands) {
        this.Hotkeys := hotkeys
        this.ExecuteType := executeType
        this.Commands := commands

        Return, this
    }
}
;endregion
