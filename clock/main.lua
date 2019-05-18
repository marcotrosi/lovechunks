function calcPositions() -- <<<

   Width, Height = love.graphics.getDimensions()

   CenterX   = Width/2
   CenterY   = Height/2
   Radius    = math.min(CenterX, CenterY) * 0.9
   SecDia    = Radius * 0.90
   MinDia    = Radius * 0.90
   HourDia   = Radius * 0.50
   SecWidth  = Radius * 0.007
   MinWidth  = Radius * 0.02
   HourWidth = Radius * 0.035
   SDot      = Radius * 0.02
   BDot      = Radius * 0.035

   -- clean table
   for i,_ in ipairs(Dots) do Dots[i]=nil end

   for i=1,12 do

      local Size

      if (i%3) == 0 then
         Size = BDot
      else
         Size = SDot
      end

      table.insert(Dots,
      {
         X    = CenterX + (math.sin(Step12*i)*Radius),
         Y    = CenterY + (math.cos(Step12*i)*Radius),
         Size = Size
      })
   end

end -- >>>


function love.load() -- <<<

   Dots = {}

   BackColor = {42/255, 51/255, 65/255}
   DotColor  = {216/255, 218/255, 220/255}
   HrMnColor = {216/255, 218/255, 220/255}
   SecColor  = {217/255, 43/255, 43/255}

   love.graphics.setLineStyle("smooth")

   Step12 = (2*math.pi)/12
   Step60 = (2*math.pi)/60

   calcPositions()
end -- >>>

function love.resize(w,h) -- <<<
   calcPositions()
end -- >>>

function love.keypressed(key, sc, isrepeat) -- <<<
   if key == "q" then
      love.event.quit()
   end
   if key == "f" then
      love.window.setFullscreen(not (love.window.getFullscreen()))
      calcPositions()
   end
end -- >>>

function love.update(dt) -- <<<
   time = os.date('*t')

   SecX = SecDia * math.sin(Step60*time.sec)
   SecY = SecDia * math.cos(Step60*time.sec)

   MinX = MinDia * math.sin(Step60*time.min)
   MinY = MinDia * math.cos(Step60*time.min)

   HourX = HourDia * math.sin(Step12*time.hour)
   HourY = HourDia * math.cos(Step12*time.hour)
end -- >>>

function love.draw() -- <<<
   local g = love.graphics

   g.setBackgroundColor(BackColor)

   g.setColor(HrMnColor)

   g.setLineWidth(HourWidth)
   g.line(CenterX, CenterY, CenterX+HourX, CenterY-HourY)

   g.setLineWidth(MinWidth)
   g.line(CenterX, CenterY, CenterX+MinX, CenterY-MinY)

   g.setColor(SecColor)
   g.setLineWidth(SecWidth)
   g.line(CenterX, CenterY, CenterX+SecX, CenterY-SecY)

   g.setColor(DotColor)

   for _,v in ipairs(Dots) do
      g.circle('fill', v.X, v.Y, v.Size)
   end
end -- >>>


-- vim: fmr=<<<,>>> fdm=marker
