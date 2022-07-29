#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#IfWinActive ahk_class LWJGL
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetKeyDelay, 35

;region Combat

!1:: ; InfiniteAmmo
{
    SendToConsoleWithEnter("InfiniteAmmo")
    Return
}

!q:: ; InfiniteAmmo, Flux, NoCoolDown
{
    array :=["InfiniteFlux", "InfiniteAmmo", "NoCoolDown"]

    SendArrayToConsole(array)
    Return
}


;endregion

;region Ship

!2:: ; AddShip
{
    SendToConsoleWithEnter(AddShip)
    Return
}

!w:: ; AddOrdnancePoints 150
{
    SendToConsoleWithEnter("AddOrdnancePoints 150")
    Return
}

;endregion

;region Weapon

!3:: ; AddWeapon
{
    SendToConsoleWithEnter("AddWeapon")
    Return
}

; TODO: 快速添加一些武器

;endregion

;region Item

!4:: ; AddSupplies Fuel
{
    array :=["AddItem Supplies 2000", "AddItem Fuel 1500"]

    SendArrayToConsole(array)
    Return
}

!r:: ; AddSupplies, Crew, Fuel
{
    array :=["AddSupplies","AddCrew", "AddFuel"]

    SendArrayToConsole(array)
    Return
}
 
!f:: ; TODO: Add something
{
    Return
}

!v:: ; AddItem to build a space station
{
    array :=["AddItem metal 1000", "AddItem supplies 300", "AddItem rare_metal 200", "AddItem heavry_machinery 150"]

    SendArrayToConsole(array)
    Return
}

;endregion

;region Items about colony

!5:: ; AddItem Marines, Weapons
{
    array :=["AddItem marines 1000", "AddItem hand_Weapons 500"]

    SendArrayToConsole(array)
    Return
}

!t:: ; AddItem Alpha core
{
    array :=["AddItem alpha_core 10"]

    SendArrayToConsole(array)
    Return
}


!g:: ; AddItem 
{
    array :=["AddItem Supplies 5000", "AddItem heavry_machinery 2000", "AddItem food 5000", "AddItem domestic_goods 2000", "AddItem organic 1000", "AddItem luxury_goods 1000", "AddItem drugs 500"]

    SendArrayToConsole(array)
    Return
}

;endregion

;region Faction

!6:: ; SetRelation Hegemony
{
    array :=["SetRelation hegemony 20", "SetRelation hegemony tritachyon 0"]
    
    SendArrayToConsole(array)
    Return
}

!y:: ; SetRelation
{
    array :=["SetRelation hegemony 50", "SetRelation hegemony tritachyon 0"]
    
    SendArrayToConsole(array)
    Return
}

;endregion

;region Plant

!7:: ; AddCondition 
{
    array :=["AddCondition farmland_bountful", "AddCondition organics_abundant", "AddCondition mild_climate", "AddCondition ore_ultrarich", "AddCondition rare_ore_urichltra"]
    SendArrayToConsole(array)
    Return
}

!u:: ; RemoveCondition 
{
    array :=["RemoveCondition nex_bellion_condition", "RemoveCondition pollution", "RemoveCondition recent_unrest"]
    SendArrayToConsole(array)
    Return
}

;endregion

;region BluePrint

!8:: ; BluePrints 
{
    array :=["AddSpecial ship_bp odyssey", "AddSpecial ship_bp paragon", "AddSpecial ship_bp astral", "AddSpecial ship_bp fury", "AddSpecial ship_bp revenant", "AddSpecial ship_bp doom", "AddSpecial ship_bp apogee", "AddSpecial ship_bp shrike", "AddSpecial ship_bp harbinger","AddSpecial ship_bp aurora", "AddSpecial ship_bp medusa", "AddSpecial ship_bp phantom",  "AddSpecial ship_bp scarab", "AddSpecial ship_bp shade", "AddSpecial ship_bp afflictor", "AddSpecial ship_bp tempest", "AddSpecial ship_bp tempest", "AddSpecial ship_bp omen", "AddSpecial ship_bp hyperion", "AddSpecial ship_bp buffalo_pirate", "AddSpecial ship_bp atlas", "AddSpecial ship_bp valkyrie", "AddSpecial ship_bp prometheus","AddSpecial ship_bp ox","AddSpecial ship_bp phaeton"]
    Return
}

;endregion

;region Functions

SendToConsoleWithSpace(text)
{
    Send %text%
    Send {Space}
}

SendToConsoleWithEnter(text)
{
    Send %text%
    Sleep 100
    Send {Enter}
    Sleep 100
}

SendArrayToConsole(array)
{
    for index, element in array
    {
        Send %element%
        Sleep 150
        Send {Enter}
        Sleep 150
    }
}

;endregion

#IfWinActive
