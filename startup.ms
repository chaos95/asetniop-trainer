import "utils"
ensureImport "typewriter"
ensureImport "chording"
ensureImport "game"
ensureImport "training"
ensureImport "vector"

normalTextColor = text.color

asetniop = chording.makeAsetniopKeyboard("qweruiopvn")

typewriter = new typewriter.Typewriter

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
