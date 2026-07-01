#Requires AutoHotkey v2.0

class ChangeWave {

    static SetKeys() {
        Hotkey("~$Q", (*) => this.Activate())
    }

    static Activate() {

        t := 1500

        SendList(["^a", "{backspace}", "{enter}", "{F3}", "{F2}"], t*0.2)

    }

}
