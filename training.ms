import "utils"
ensureImport "vector"
ensureImport "speechBubble"

Vec2 = vector.Vec2

AssistantFrame = {}
AssistantFrame.pos = Vec2.origin
AssistantFrame.make = function(pos, portrait, firstLine, secondLine, duration)
	retval = new AssistantFrame
	retval.pos = pos
	retval.portrait = portrait
	retval.firstLine = firstLine
	retval.secondLine = secondLine
	retval.duration = duration
	return retval
end function

AssistantAnimation = {}
AssistantAnimation.frames = []
AssistantAnimation.finished = false
AssistantAnimation._frameIndex = 0
AssistantAnimation._frameTime = 0
AssistantAnimation.make = function(frames)
	retval = new AssistantAnimation
	retval.frames = frames
	return retval
end function

AssistantAnimation.nextFrame = function
	if self._frameIndex < (self.frames.len - 1) then
		self._setFrame self._frameIndex + 1
	else
		self.finished = true
	end if
end function

AssistantAnimation._setFrame = function(index)
	self.finished = false
	self._frameIndex = index
	self._frameTime = 0
end function

AssistantAnimation.currFrame = function
	return self.frames[self._frameIndex]
end function

AssistantAnimation.tick = function(delta)
	self._frameTime = self._frameTime + delta
	if self._frameTime > self.currFrame.duration then self.nextFrame
end function

intro = AssistantAnimation.make([
	AssistantFrame.make(Vec2.make(0, 0), "wide", "Welcome!", "", 3.0),
	AssistantFrame.make(Vec2.make(0, 0), "talk", "My name is Marvis Bacon.", "I'll be your training assistant for today!", 5.0),
])

Mavis = {}
Mavis.portrait = {}

Mavis.init = function(tileDisplayLayer, pixelDisplayLayer, portraitPrefix = "character_femaleAdventurer")
	self.td = tileDisplayLayer
	self.pd = pixelDisplayLayer
	
	self.currAnim = intro

	for verb in ["idle", "talk", "think", "wide"]
		self.portrait[verb] = file.loadImage("assets/characters/" + portraitPrefix + "_" + verb + ".png")
	end for
	self.portrait_pos = Vec2.make(20, 30)

	self.speechBubble = new speechBubble.SpeechBubble
	self.speechBubble.init(self.td, self.pd, 13, 3)
	self.speechBubble_pos = self.portrait_pos.plus(Vec2.make(60, -20))
end function

Mavis.updateAnimation = function(delta)
	self.currAnim.tick(delta)
end function

Mavis.update = function(delta)
	self.updateAnimation(delta)
end function

Mavis.draw = function
	self.td.clear
	self.pd.clear

	frame = self.currAnim.currFrame
	portrait_pos = self.portrait_pos.plus(frame.pos)
	portrait = self.portrait[frame.portrait]
	self.pd.drawImage portrait, portrait_pos.x, portrait_pos.y, portrait.width, portrait.height
	self.speechBubble.draw(self.speechBubble_pos, frame.firstLine, frame.secondLine)
end function