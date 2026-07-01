#Requires AutoHotkey v2.0

class Math {

    static Wrap(value, min, max) {

        _range := max - min
        return Mod(Mod(value - min, _range) + _range, _range) + min

    }

}
