#Requires AutoHotkey v2.0

class BarcodePicker {

    static index := 1
    static barcodes := []

    static Load() {
        this.barcodes := JSON.ParseFile("Data\barcodes.json")
    }

    static Next() {
        this.index := Math.Wrap(this.index + 1, 1, this.barcodes.Length + 1)
    }

    static Previous() {
        this.index := Math.Wrap(this.index - 1, 1, this.barcodes.Length + 1)
    }

    static Get() {
        return this.barcodes[this.index]
    }
}
