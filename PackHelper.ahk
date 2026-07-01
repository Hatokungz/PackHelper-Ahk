#Requires AutoHotkey v2.0

#Include Lib\json.ahk
#Include Lib\math.ahk
#Include Lib\utils.ahk

#Include Features\barcodePicker.ahk
#Include Features\infoGui.ahk

#Include HotKeys\barcodeInsert.ahk

Main.start()

class Main {

    static start() {
        BarcodePicker.Load()
        BarcodeInserter.Setkeys()

        InfoGui.Update()
    }

}
