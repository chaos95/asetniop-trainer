import "utils"
ensureImport "delegate"

ChordedKeyboard = {}
ChordedKeyboard._hooks = {
	"backspace": delegate.Delegate.make("backspace", 0),
	"write": delegate.Delegate.make("write", 1),
	"newLine": delegate.Delegate.make("newLine", 0),
}
ChordedKeyboard.init = function(inputKeys, systemKeys, dictionary)
	self.chord = {}
	self.keyMap = {}
	for i in range(0,systemKeys.len - 1)
		self.keyMap[inputKeys[i]] = systemKeys[i]
	end for
	self.dictionary = dictionary
	self.chordDown = 0
	self.startKey = ""
	self.clear
end function

ChordedKeyboard.clear = function
	for kv in self.keyMap
		self.chord[kv.value] = 0
	end for
	self.startkey = null
	self.chordDown = false
end function

ChordedKeyboard.stringify = function
	chordString = ""
	for kv in self.chord
		if kv.value == 1 then
			chordString = chordString + kv.key
		end if
	end for
	return chordString
end function

ChordedKeyboard.calculateOutput = function(stroke, startKey)
	returnVal = ""
	if self.dictionary.hasIndex(stroke) then
		returnVal = self.dictionary[stroke]
	end if
	return returnVal
end function

ChordedKeyboard.finishStroke = function
	stroke = self.stringify
	startKey = self.startKey
	self.clear
	return self.calculateOutput(stroke, startKey)
end function

ChordedKeyboard.inputKeys = function
	return self.keyMap.indexes
end function

ChordedKeyboard.systemKeys = function
	return self.keyMap.values
end function

ChordedKeyboard.addHandler = function(hookName, handler)
	self._hooks[hookName].add(@handler)
end function

ChordedKeyboard.add = function(inputKey)
	systemKey = self.keyMap[inputKey]
	if self.chord.values.sum == 0 then
		self.chordDown = true
		self.startkey = systemKey
	end if
	self.chord[systemKey] = 1
end function

ChordedKeyboard.isDown = function(systemKey)
	return self.chord[systemKey]
end function

ChordedKeyboard.checkInput = function
	chordUp = true
    for inputKey in self.inputKeys
        if key.pressed(inputKey) then
            self.add inputKey 
            chordUp = false
        end if
    end for
	if self.chordDown and chordUp then
		stroke = self.finishStroke
        if stroke == "<BACKSPACE>" then
            self._hooks.backspace.call []
		else if stroke == "<NEWLINE>" then
			self._hooks.newLine.call []
        else
			self._hooks.write.call [stroke]
        end if
	end if
end function

asetniopDictionary = {
"a": "a",
"s": "s",
"as": "w",
"e": "e",
"ae": "x",
"se": "d",
"t": "t",
"at": "f",
"st": "c",
"et": "r",
"n": "n",
"an": "q",
"sn": "j",
"en": "y",
"tn": "b",
"i": "i",
"ai": "z",
"si": "k",
"ei": ",",
"ti": "v",
"ni": "h",
"o": "o",
"ao": "(",
"so": ".",
"eo": "-",
"to": "g",
"no": "u",
"io": "l",
"p": "p",
"ap": "?",
"sp": ")",
"ep": " ",
"tp": "<BACKSPACE>",
"np": "m",
"ip": "!",
"op": ";",
"niop": "<NEWLINE>",
}

makeAsetniopKeyboard = function(inputKeys)
	retval = new ChordedKeyboard
	retval.init inputKeys, "asetniop", asetniopDictionary
	return retval
end function