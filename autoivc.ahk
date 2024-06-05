﻿; Read settings from settings.ini
IniRead, UserID, settings.ini, Settings, UserID
IniRead, url, settings.ini, Settings, url
IniRead, discordID, settings.ini, Settings, discordID
IniRead, sleepDuration, settings.ini, Settings, sleepDuration

CoordMode, Pixel, Screen

nightColor := 0x000000
loadingColor := 0x2257A8
webhook_color := 13684834

DragScroll() {
    MouseClickDrag, middle, 300, 302, 300, 300
}

CheckForNight(colorToCheck) {
    PixelGetColor, color, 458, 151
    return color = colorToCheck
}

DetectLoading(colorToCheck) {
    PixelGetColor, color, 458, 151
    return color = colorToCheck
}

postdata=
(
{
  "content": "<@%discordID%> VICIOUS BEE DETECTED!!!",
  "embeds": [
    {
      "title": "Vicious bee detected!!",
      "description": "roblox://userID=%UserID%&joinAttemptOrigin=JoinUser \n https://www.roblox.com/users/%UserID%/profile",
      "color": 8280002
    }
  ]
}
) 

; Create a GUI to update UserID, URL, Discord ID, and Sleep Duration
Gui, Add, Text, x10 y10 w80 h20, Roblox UserID:
Gui, Add, Edit, vUserIDEdit x100 y10 w300 h20, %UserID%
Gui, Add, Text, x10 y40 w80 h20, Webhook URL:
Gui, Add, Edit, vURLEdit x100 y40 w300 h20, %url%
Gui, Add, Text, x10 y70 w80 h20, Discord ID:
Gui, Add, Edit, vDiscordIDEdit x100 y70 w300 h20, %discordID%
Gui, Add, Text, x10 y100 w80 h20, Sleep Duration:
Gui, Add, Edit, vSleepDurationEdit x100 y100 w300 h20, %sleepDuration%
Gui, Add, Button, gSaveSettings x100 y130 w100 h30, Save
Gui, Show, w420 h180, Settings
return

SaveSettings:
    Gui, Submit, NoHide
    IniWrite, %UserIDEdit%, settings.ini, Settings, UserID
    IniWrite, %URLEdit%, settings.ini, Settings, url
    IniWrite, %DiscordIDEdit%, settings.ini, Settings, discordID
    IniWrite, %SleepDurationEdit%, settings.ini, Settings, sleepDuration
    UserID := UserIDEdit
    url := URLEdit
    discordID := DiscordIDEdit
    sleepDuration := SleepDurationEdit
    MsgBox, Settings saved!
return

F1::
    loop {
        DragScroll()
        if CheckForNight(nightColor) {
            WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
            WebRequest.Open("POST", url, false)
            WebRequest.SetRequestHeader("Content-Type", "application/json")
            WebRequest.Send(postdata)
            MsgBox, 4, Continue?, Vicious bee detected! Do you want to continue?
            IfMsgBox, No
            {
                ExitApp
            }
        } else {
            RunWait, taskkill /F /IM RobloxPlayerBeta.exe, , Hide
            Run, node "index.js"
        }

        Sleep, %sleepDuration% ; Roblox Player is waiting for the grey screen to go away the "hehehee... screen"
    }
return
