#NoEnv
; #Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

#Include, <JSON>

;region Quick Commands





;endregion

;region Program

;region Environment

Gui, Margin, 8, 8
Gui, Font, s10, Arial
Gui, Font, s10, BlinkMacSystemFont
Gui, Font, s10, Segoe UI
Gui, Font, s10, Microsoft YaHei UI

;endregion

;region Main
settings := LoadSettings()
strings := LoadLanguages(settings.Language)

tabTitle := GetTabTitle(strings.tabs)
Gui, Add, Tab3,, %tabTitle%

GuiAddTabContext(strings.tabs)

Gui, Show,, Starsector Command Helper
Return

;endregion

GuiClose:
ExitApp

LanguageChange: 
    MsgBox, You Choosed %LanguageChoice%
Return

;region Initial
LoadSettings() {
    if !FileExist("settings.json") {
        ; TODO: 在无配置文件时添加默认配置文件
        code := GetLanguageCode()

        settingsString = {`r`n "Language": "%code%"`r`n}

        file := FileOpen("settings.json", "w")
        if !IsObject(file) {
            MsgBox Can't open settings.json!
            Exit, 1
        }
        file.Write(settingsString)
        file.Close()
    }

    file := FileOpen("settings.json", "r-d")
    if !IsObject(file) {
        MsgBox Can't open settings.json!
        Exit, 1
    }

    jsonString := file.Read()
    jsonParsed := JSON.Load(jsonString)
Return jsonParsed
}

LoadLanguages(languageName) {
    filePath := ".\Languages\" languageName ".json"
    file := FileOpen(filePath, "r")
    if !IsObject(file)
    {
        MsgBox Can't open language "%languageName%"!
        Exit, 1
    }

    jsonString := file.Read()
    jsonParsed := JSON.Load(jsonString)
Return jsonParsed
}

GetTabTitle(array) {
    result := ""
    for index, item in array {
        result := result item.name "|"
    }

    Return result
}

GuiAddTabContext(tabArray) {
    For index, item in tabArray{
        Gui, Tab, %index%
        If (item.type == "settings") {
            GuiAddSettingsTab(item.context)
            Continue
        }
        If (item.type == "about") {
            GuiAddAboutTab(item.context)
            Continue
        }
        
        AddContext(item.context)
    }
}

AddContext(commands) {
    For index, item in commands {
        Gui, Add, Text,, %item%
    }
}

GuiAddSettingsTab(settingsTab) {
    languageUIString := settingsTab.Language
    languageNameUIString := settingsTab.LanguageName
    Gui, Add, Text,, %languageUIString%
    Gui, Add, DropDownList,Choose1 gLanguageChange ,简体中文|English
}

GuiAddAboutTab(aboutTab) {
    programNameString := aboutTab.ProgramName
    Gui, Add, Text,, %programNameString%
    aboutText := aboutTab.AboutText "`n" aboutTab.Version "`n" aboutTab.Date
    Gui, Add, Text,, %aboutText%
    Gui, Add, Link,, GitHub: <a href="https://github.com/Kianakiferi/StarSector-AutoHotKey">StarSector-AutoHotKey</a>`nConsole Commands: <a href="https://fractalsoftworks.com/forum/index.php?topic=4106.0">Fractalsoftworks Forum</a>
}

GetLanguageCode() {
    Switch A_Language 
    {
    Case 0804:
    Return "zh_CN"
    ;Case 040c:
    ;   Return "fr"
    ;Case 0419:
    ;   Return "ru"
    ;Case 3801:
    ;   Return "ar_UAE"
    ;Case 040a:
    ;Case 0c0a:
    ;   Return "es"
    Default: 
    Return "en"
}
;endregion

;region Functions


;endregion

;endregion