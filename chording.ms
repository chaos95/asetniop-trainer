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
"ase": "we",
"t": "t",
"at": "f",
"st": "c",
"ast": "fact",
"et": "r",
"aet": "are",
"set": "set",
"aset": "were",
"n": "n",
"an": "q",
"sn": "j",
"asn": "san",
"en": "y",
"aen": "any",
"sen": ["eyes", "need"],
"asen": "and",
"tn": "b",
"atn": "fan",
"stn": "",
"astn": "can",
"etn": "be",
"aetn": ["ran", "next"],
"setn": "best",
"asetn": ["went", "years"],
"i": "i",
"ai": "z",
"si": "k",
"asi": "ask",
"ei": ",",
"aei": "",
"sei": "did",
"asei": "said",
"ti": "v",
"ati": "if",
"sti": "its",
"asti": "wait",
"eti": "ever",
"aeti": "five",
"seti": "tried",
"aseti": "first",
"ni": "h",
"ani": ["ah", "han"],
"sni": "his",
"asni": "has",
"eni": "he",
"aeni": "yeah",
"seni": "she",
"aseni": ["when", "had"],
"tni": ["bit", "hit"],
"atni": "that",
"stni": "this",
"astni": "with",
"etni": "the",
"aetni": "have",
"setni": "these",
"asetni": ["where", "heard"],
"o": "o",
"ao": "(",
"so": ".",
"aso": "",
"eo": "-",
"aeo": "",
"seo": "do",
"aseo": "wood",
"to": "g",
"ato": "of",
"sto": "cost",
"asto": "two",
"eto": ["get", "or"],
"aeto": "for",
"seto": ["good", "order"],
"aseto": ["words", "offered"],
"no": "u",
"ano": "",
"sno": ["soon", "us"],
"asno": "now",
"eno": "you",
"aeno": "anyone",
"seno": ["done", "use"],
"aseno": "down",
"tno": ["but", "not"],
"atno": "about",
"stno": "just",
"astno": "town",
"etno": "your",
"aetno": ["before", "often"],
"setno": ["course", "once"],
"asetno": "because",
"io": "l",
"aio": "all",
"sio": "look",
"asio": "will",
"eio": "lie",
"aeio": "",
"seio": "like",
"aseio": "well",
"tio": ["till", "lot"],
"atio": "fall",
"stio": ["still", "lost"],
"astio": ["call", "last"],
"etio": ["tell", "over"],
"aetio": ["felt", "life"],
"setio": ["told", "lives"],
"asetio": ["work", "least"],
"nio": "oh",
"anio": "hall",
"snio": ["soul", "john"],
"asnio": ["who", "how"],
"enio": "only",
"aenio": ["alone", "lay"],
"senio": ["should", "house"],
"asenio": "would",
"tnio": ["thought", "into"],
"atnio": ["again", "having"],
"stnio": ["such", "looking"],
"astnio": "without",
"etnio": ["through", "other"],
"aetnio": "another",
"setnio": "could",
"asetnio": ["already", "however"],
"p": "p",
"ap": "?",
"sp": ")",
"asp": "pass",
"ep": " ",
"aep": "",
"sep": "deep",
"asep": ["we'd", "passed"],
"tp": "<BACKSPACE>",
"atp": "pat",
"stp": "",
"astp": "past",
"etp": "per",
"aetp": "part",
"setp": ["step", "press"],
"asetp": ["we're", "perfect"],
"np": "m",
"anp": ["am", "man"],
"snp": "ms",
"asnp": "mass",
"enp": "my",
"aenp": "many",
"senp": "seemed",
"asenp": ["same", "made"],
"tnp": "",
"atnp": "",
"stnp": "",
"astnp": ["camp", "pants"],
"etnp": ["remember", "mr"],
"aetnp": ["army", "matter"],
"setnp": ["spent", "mrs"],
"asetnp": ["came", "parents"],
"ip": "!",
"aip": "",
"sip": "",
"asip": "",
"eip": "I",
"aeip": "",
"seip": "keep",
"aseip": ["speak", "paid"],
"tip": "tip",
"atip": "",
"stip": "pick",
"astip": "pack",
"etip": ["trip", "I've"],
"aetip": "private",
"setip": "it's",
"asetip": ["we've", "Paris"],
"nip": "him",
"anip": "pain",
"snip": ["ship", "miss"],
"asnip": "Spanish",
"enip": "I'm",
"aenip": "happy",
"senip": ["she'd", "mind"],
"asenip": "make",
"tnip": "",
"atnip": "path",
"stnip": "smith",
"astnip": ["captain", "match"],
"etnip": "them",
"aetnip": ["remain", "haven't"],
"setnip": "didn't",
"asetnip": ["that's", "perhaps"],
"op": ";",
"aop": "",
"sop": "",
"asop": "",
"eop": "pope",
"aeop": "",
"seop": "possessed",
"aseop": "exposed",
"top": "top",
"atop": "gap",
"stop": ["stop", "post"],
"astop": "",
"etop": ["report", "poor"],
"aetop": "page",
"setop": ["stopped", "process"],
"asetop": "power",
"nop": "up",
"anop": "",
"snop": ["sum", "jump"],
"asnop": "woman",
"enop": "money",
"aenop": "",
"senop": "some",
"asenop": "women",
"tnop": "put",
"atnop": "among",
"stnop": "most",
"astnop": ["famous", "Moscow"],
"etnop": "more",
"aetnop": "from",
"setnop": ["don't", "person"],
"asetnop": ["company", "major"],
"iop": "pool",
"aiop": "lap",
"siop": ["slip", "lips"],
"asiop": "",
"eiop": "people",
"aeiop": ["apple", "pale"],
"seiop": ["spoke", "people's"],
"aseiop": ["we'll", "please"],
"tiop": "pilot",
"atiop": "",
"stiop": ["split", "politics"],
"astiop": ["capital", "political"],
"etiop": "prove",
"aetiop": ["April", "plate"],
"setiop": ["replied", "police"],
"asetiop": "place",
"niop": "million",
"aniop": "human",
"sniop": ["shop", "mission"],
"asniop": "small",
"eniop": "home",
"aeniop": ["example", "play"],
"seniop": ["simply", "pulled"],
"aseniop": ["explained", "played"],
"tniop": "might",
"atniop": ["film", "imagination"],
"stniop": "much",
"astniop": ["almost", "making"],
"etniop": ["government", "mother"],
"aetniop": ["family", "important"],
"setniop": ["something", "possible"],
"asetniop": ["especially", "himself"],
}

makeAsetniopKeyboard = function(inputKeys)
	retval = new ChordedKeyboard
	retval.init inputKeys, "asetniop", asetniopDictionary
	return retval
end function