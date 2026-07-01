#Requires AutoHotkey v2.0

class InfoGui {
    static x := 1780
    static y := 986
    static width := 128
    static height := 54
    static suffix_code := "Barcode: "
    static suffix_name := "Name: "

    static gui := Gui.Call("-Caption +AlwaysOnTop +ToolWindow")

    static code := this.gui.AddText("cBlack", this.suffix_code "===============")
    static name := this.gui.AddText("cBlack", this.suffix_name "===============")

    static SetWindow() {
        this.gui.Show("x" this.x "y" this.y "w" this.width "h" this.height "NoActivate")
    }

    static SetText() {
        item := BarcodePicker.Get()
        if !item
            return

        this.code.Text := this.suffix_code item.code
        this.name.Text := this.suffix_name item.name
    }

    static Update() {
        this.SetWindow()
        this.SetText()
    }
}
