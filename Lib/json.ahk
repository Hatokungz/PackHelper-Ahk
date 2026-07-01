#Requires AutoHotkey v2.0

; This can read .json Object{}, List[], Strings"", Numbers0-9, Boolean, Null.

class JSON {

    static jsonText := ""
    static pos := 1

    static ParseFile(filePath) {
        this.jsonText := FileRead(filePath, "UTF-8")
        this.pos := 1

        _result := this.ReadValue()
        this.SkipWhiteSpace()

        if this.Peek() != ""
            throw Error("Unexpected character after JSON.")

        return _result

    }

    static ReadValue() {
        this.SkipWhiteSpace()

        char := this.Peek()

        switch char {
            case "{":
                return this.ReadObject()
            case '"':
                return this.ReadString()
            case "[":
                return this.ReadArray()
            case "-", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                return this.ReadNumber()
            case "t":
                return this.ReadTrue()
            case "f":
                return this.ReadFalse()
            case "n":
                return this.ReadNull()

            default:
                throw Error("Unexpected value '" char "' at position " this.pos ".")
        }
    }

    static ReadObject() {
        _obj := {}
        this.Expect("{")
        this.SkipWhiteSpace()

        ; Object is Empty
        if this.Peek() = "}" {
            this.Next()
            return _obj
        }

        loop {
            _key := this.ReadString()
            this.SkipWhiteSpace()

            this.Expect(":")
            this.SkipWhiteSpace()

            _value := this.ReadValue()
            this.SkipWhiteSpace()

            ; Store key = value
            _obj.%_key% := _value

            if this.Peek() = "}" {
                this.Next()
                break
            }

            this.Expect(",")
            this.SkipWhiteSpace()
        }

        return _obj
    }

    static ReadString() {
        _str := ""
        this.Expect('"')

        loop {
            _char := this.Next()

            if _char = '"'
                break

            if _char = "\" {
                _esc := this.Next()
                switch _esc {
                    case "n": _str .= "`n"
                    case "t": _str .= "`t"
                    case "r": _str .= "`r"
                    case '"': _str .= '"'
                    case "\": _str .= "\"
                    default: _str .= _esc
                }
            } else {
                _str .= _char
            }
        }

        return _str

    }

    static ReadArray() {
        _arr := []
        this.Expect("[")
        this.SkipWhiteSpace()

        ; Array is empty
        if this.Peek() = "]" {
            this.Next()
            return _arr
        }

        loop {
            _value := this.ReadValue()

            _arr.Push(_value)

            this.SkipWhiteSpace()

            if this.Peek() = "]" {
                this.Next()
                break
            }

            this.Expect(",")
            this.SkipWhiteSpace()
        }

        return _arr
    }

    static ReadNumber() {
        _num := ""

        if this.Peek() = "-"
            _num .= this.Next()

        while InStr("0123456789", this.Peek())
            _num .= this.Next()

        if this.Peek() = "." {
            _num .= this.Next()

            while InStr("0123456789", this.Peek())
                _num .= this.Next()
        }

        return _num + 0

    }

    static ReadTrue() {
        if SubStr(this.jsonText, this.pos, 4) != "true"
            throw Error("Invaild true.")

        this.pos += 4
        return true
    }

    static ReadFalse() {
        if SubStr(this.jsonText, this.pos, 5) != "false"
            throw Error("Invaild false.")

        this.pos += 5
        return false
    }

    static ReadNull() {
        if SubStr(this.jsonText, this.pos, 4) != "null"
            throw Error("Invaild null.")

        this.pos += 4
        return ""
    }

    ; Utilities Functions
    static Peek() {
        return this.pos > StrLen(this.jsonText) ? "" : SubStr(this.jsonText, this.pos, 1)
    }

    static Next() {
        return SubStr(this.jsonText, this.pos++, 1)
    }

    static Previous() {
        return SubStr(this.jsonText, --this.pos, 1)
    }

    static SkipWhiteSpace() {
        while (char := this.Peek()) && InStr(" `t `n `r", char)
            this.Next()
    }

    static Expect(char) {
        if this.Peek() != char
            throw Error("Expect '" char "' at position " this.pos ".")

        this.Next()
    }

}
