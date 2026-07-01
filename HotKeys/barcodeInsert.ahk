#Requires AutoHotkey v2.0

class BarcodeInserter {

    static triggered := false
    static penddingEnter := false

    static Setkeys() {
        Hotkey("~$Space", (*) => this.Insert())

        Hotkey("~$Esc", (*) => this.Reset())
        Hotkey("~$F7", (*) => this.Reset())
        Hotkey("~$Enter", (*) => this.Reset())
        Hotkey("~$NumpadEnter", (*) => this.Reset())

        Hotkey("~$Right", (*) => this.Next())
        Hotkey("~$Left", (*) => this.Previous())
    }

    static Insert() {
        if this.triggered
            return

        t := 2000

        item := BarcodePicker.Get()
        if !item
            return

        SendList(["^a", "{backspace}", "{enter}"], t * 0.08)
        TypeTextDelay(item.code, t * 0.5)
        SendList(["{enter}", "{f6}"], t * 0.125)

        this.triggered := true
    }

    static Reset() {
        if this.penddingEnter
            this.penddingEnter := false

        if this.triggered {
            this.triggered := false
            this.penddingEnter := true
            SetTimer(() => this.SendEnter(), -6000)
        }
    }

    static Next() {
        BarcodePicker.Next()
        InfoGui.Update()
    }

    static Previous() {
        BarcodePicker.Previous()
        InfoGui.Update()
    }

    static SendEnter() {
        if !this.penddingEnter
            return

        Send("{Enter}")
    }

}
