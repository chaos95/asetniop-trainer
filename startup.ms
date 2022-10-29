import "utils"
ensureImport "typewriter"
ensureImport "chording"
ensureImport "game"

normalTextColor = text.color
clear

asetniop = new chording.AsetniopKeyboard
asetniop.init "qweruiop" 

typewriter = new typewriter.Typewriter
typewriter.init(12)

main = new game.Game
main.init(asetniop, typewriter)
main.run

text.row = 5
text.color = normalTextColor
wait 1
print
exit