
function love.load()

   Offset      = 20
   FontHeight  = 200
   Font        = love.graphics.newFont("OpenSans-Regular.ttf", FontHeight)
   love.graphics.setFont(Font)
   Text        = love.graphics.newText(Font, "Éy")
   Text2       = love.graphics.newText(Font, "x")
   Ascent      = Font:getAscent()
   Baseline    = Font:getBaseline()
   Descent     = Font:getDescent()
   Height      = Font:getHeight()

   print("Font:getAscent()    ", Ascent       )
   print("Font:getBaseline()  ", Baseline     )
   print("Font:getDescent()   ", Descent      )

   print("Font:getHeight()    ", Height       )
   print("Font:getWidth('Éy') ", Font:getWidth("Éy"))
   print("Font:getWidth('x')  ", Font:getWidth("x"))

   print("Text:getHeight()    ", Text:getHeight())
   print("Text2:getHeight()   ", Text2:getHeight())

   print("Text:getWidth()     ", Text:getWidth())
   print("Text2:getWidth()    ", Text2:getWidth())
end

function love.draw()
   love.graphics.setColor(1.0,1.0,1.0)
   love.graphics.draw(Text, Offset+0, Offset+0)
   love.graphics.setColor(0,1.0,0)
   love.graphics.line(Offset+0, Offset+Baseline-FontHeight, Offset+200, Offset+Baseline-FontHeight)
   love.graphics.setColor(0,1.0,1.0)
   love.graphics.line(Offset+0, Offset+Baseline, Offset+200, Offset+Baseline)
   love.graphics.setColor(1.0,0,0)
   love.graphics.line(Offset+0, Offset+Baseline-Ascent, Offset+200, Offset+Baseline-Ascent)
   love.graphics.setColor(0,0,1.0)
   love.graphics.line(Offset+0, Offset+Baseline-Descent, Offset+200, Offset+Baseline-Descent)
end

