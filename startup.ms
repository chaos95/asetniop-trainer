import "utils"
ensureImport "typewriter"
ensureImport "chording"
ensureImport "game"
ensureImport "training"

normalTextColor = text.color

asetniop = chording.makeAsetniopKeyboard("arstneio")

typewriter = new typewriter.Typewriter
typewriter.init(12)

clear
display(6).mode = displayMode.tile
tileDisplayLayer = display(6)

display(5).mode = displayMode.pixel
pixelDisplayLayer = display(5)

assistant = new training.Mavis
assistant.init(tileDisplayLayer, pixelDisplayLayer, "character_robot")

main = new game.Game
main.init(asetniop, typewriter, assistant)
prevTime = 0
// Main loop:
while not main.done
    currTime = time()
    delta = currTime - prevTime
    frameRate = 1.0 / delta
    main.update delta
    main.draw
    text.printAt 64, 20, frameRate
    prevTime = currTime
    yield
end while

clear
wait 1
print
exit
