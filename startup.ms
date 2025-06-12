import "utils"
ensureImport "typewriter"
ensureImport "chording"
ensureImport "game"
ensureImport "training"
ensureImport "vector"

normalTextColor = text.color

keyboard = chording.makeAsetniopKeyboard("qweruiopvn")
// keyboard = chording.makeTaipoKeyboard("qwerasdfcv")

clear
display(5).mode = displayMode.text
typewriterTextDisplayLayer = display(5)
typewriter = new typewriter.Typewriter
typewriter.init(typewriterTextDisplayLayer, Vec2.make(34, 12))

display(2).mode = displayMode.tile
assistantTileDisplayLayer = display(2)

display(1).mode = displayMode.pixel
assistantPixelDisplayLayer = display(1)

characters = [
    "character_femaleAdventurer",
    "character_femalePerson",
    "character_maleAdventurer",
    "character_malePerson",
    "character_robot",
    "character_zombie",
]
characters.shuffle

firstNames = [
    "Mavis",
    "Davis",
    "Elvis",
    "Marvis",
    "Maeve",
    "Marvin",
    "Martin",
    "Mollusc",
    "Bavis",
]
firstNames.shuffle

lastNames = [
    "Bacon",
    "Breaking-Bad",
    "Freakin",
    "Broken",
    "Gherkin",
    "Björgsen",
    "Meacon",
    "Becòn",
]
lastNames.shuffle

assistantName = firstNames.pop + " " + lastNames.pop

assistant = new training.Mavis
assistant.init(assistantTileDisplayLayer, assistantPixelDisplayLayer, characters.pop, assistantName)

main = new game.Game
main.init(keyboard, typewriter, assistant)
prevTime = 0
frameRates = [0] * 10
frameCount = 0
avgFrameRate = 0
// Main loop:
while not main.done
	currTime = time()
	delta = currTime - prevTime
	main.update delta
	main.draw
	frameRates[frameCount] = 1.0 / delta
	frameCount = frameCount + 1
	if frameCount == 10 then // Update framerate every 10 frames
		avgFrameRate = frameRates.sum / 10
		frameCount = 0
	end if
	text.printAt Vec2.make(64, 25), str(avgFrameRate)[:4]
	prevTime = currTime
	yield
end while

clear
wait 1
print
exit
