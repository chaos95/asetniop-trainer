import "utils"
ensureImport "textUtils"
ensureImport "vector"

Game = {}
Game.init = function(chordEngine, typewriter, assistant)
    self.done = false
    self.assistant = assistant
    self.chordEngine = chordEngine
    self.typewriter = typewriter

    backspaceWrapper = function
        typewriter.backspace
    end function
    
    self.chordEngine.addHandler "backspace", @backspaceWrapper
    self.chordEngine.addHandler "newLine", @typewriter.newLine

    write = function(stroke)
        for char in stroke
           typewriter.typeChar char 
        end for
    end function
    self.chordEngine.addHandler "write", @write 
end function

Game.drawKeyboard = function(pos)
	c = text.color
    for keyDC in self.chordEngine.keyDisplay
        if self.chordEngine.isDown(keyDC.key) then
            text.color = color.yellow
        else
            text.color = color.olive
        end if
        text.printAt pos.plus(keyDC.pos), keyDC.key
    end for
	text.color = c
end function

Game.update = function(delta)
    self.chordEngine.checkInput
    self.assistant.update delta
end function

Game.draw = function
    text.clear
    self.drawKeyboard Vec2.make(26, 9)
    self.assistant.draw
    self.typewriter.printRow
end function