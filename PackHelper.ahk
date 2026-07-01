#Requires AutoHotkey v2.0

#Include Lib\json.ahk
#Include Lib\math.ahk
#Include Lib\utils.ahk

#Include Features\barcodePicker.ahk
#Include Features\infoGui.ahk

#Include HotKeys\barcodeInsert.ahk
#Include HotKeys\changeWave.ahk

Main.start()

class Main {

    static start() {
        BarcodePicker.Load()
        BarcodeInserter.Setkeys()
        ChangeWave.SetKeys()

        InfoGui.Update()
    }

}
