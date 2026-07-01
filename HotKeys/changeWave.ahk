#Requires AutoHotkey v2.0

class ChangeWave {

    static SetKeys() {
        Hotkey("~$Q", (*) => this.Activate())
    }

    static Activate() {

        t := 3000

        SendList(["^a", "{backspace}", "{enter}", "{F3}", "{F2}"])

    }

}
