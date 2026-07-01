#Requires AutoHotkey v2.0

SendDelay(key, time := 200) {
    Send(key)
    Sleep(time)
}

TypeText(text) {
    loop parse (text) {
        Send(a_loopField)
        Sleep(random(0, 12))
    }
}

TypeTextDelay(text, time := 200) {
    TypeText(text)
    Sleep(time)
}

SendList(list, time := 200) {
    for _, key in list {
        SendDelay(key, time)
    }
}
