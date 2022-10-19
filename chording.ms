
ChordedKeyboard = {}
ChordedKeyboard.init = function(inputKeys, systemKeys, dictionary)
	self.chord = {}
	self.keyMap = {}
	for i in range(0,systemKeys.len - 1)
		self.keyMap[inputKeys[i]] = systemKeys[i]
	end for
	self.dictionary = dictionary
	self.clear
end function

ChordedKeyboard.clear = function
	for kv in self.keyMap
		self.chord[kv.value] = 0
	end for
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

ChordedKeyboard.finishStroke = function
	stroke = self.stringify
	self.clear
	if self.dictionary.hasIndex(stroke) then
		// TODO: Process backspace/enter/space/esc
		return self.dictionary[stroke]
	end if
	return ""
end function

ChordedKeyboard.inputKeys = function
	return self.keyMap.indexes
end function

ChordedKeyboard.systemKeys = function
	return self.keyMap.values
end function

ChordedKeyboard.add = function(inputKey)
	outputKey = self.keyMap[inputKey]
	self.chord[outputKey] = 1
end function

asetniopDictionary = {
"a": "a",
"s": "s",
"e": "e",
"t": "t",
"n": "n",
"i": "i",
"o": "o",
"p": "p",
"as": "w",
"ae": "x",
"se": "d",
"ase": "we",
"at": "f",
}

AsetniopKeyboard = new ChordedKeyboard
AsetniopKeyboard.init = function(inputKeys)
    super.init(inputKeys, "asetniop", asetniopDictionary)
end function