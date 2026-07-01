#Requires AutoHotkey v2.0

class AutoSendPrinter {
    static SetKeys() {
        Hotkey("!$P", (*) => this.Activate())
    }

    static Activate() {

        t := 3000

        SendDelay("^P", t * 0.5)
        SendList(["{Tab}", "{Tab}", "{NumpadPgDn}", "{Enter}", "!{F4}"], t * 0.1)

    }
}
