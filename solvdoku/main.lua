--[[
press q to quit
press r to toggle reminder flags visibility
press a to toggle auto-fill mode
press f to to run auto-fill ones
press c to clear the board (not implemented yet)
press h,j,k,l or the arrow keys to move the selection
press 1-9 to put values in the boxes
press 0 or spacebar to clear a box

TODO
   - mouse support
   - fit reminder flags to box
   - try to reduce CPU usage
   - c to clear all fields
   - fix black screen issue after startup
--]]

local sd = require "solvdoku"


function getBoxPosX(i) -- <<<
   return OffsetX+( ((i-1)%9) * Size)
end -- >>>

function getBoxPosY(i) -- <<<
   return OffsetY+( math.floor((i-1)/9) * Size)
end -- >>>

function updateData(GuiData, GameData) -- <<<

   Width, Height = love.graphics.getDimensions()
   BoardSize     = math.min(Width, Height) * 0.8
   OffsetX       = (Width  - BoardSize)/2
   OffsetY       = (Height - BoardSize)/2
   Size          = BoardSize/9
   FontHeight    = math.floor(Size*0.4)
   Font          = love.graphics.newFont("GeosansLight.ttf", FontHeight)

   XA = OffsetX+(3*Size)
   XB = OffsetX+(6*Size)
   XC = OffsetX+(9*Size)
   YA = OffsetY+(3*Size)
   YB = OffsetY+(6*Size)
   YC = OffsetY+(9*Size)

   ReminderFontHeight = math.floor(Size/9)
   ReminderFont       = love.graphics.newFont("GeosansLight.ttf", ReminderFontHeight)

   for i,v in ipairs(GameData) do
      GuiData[i].x = getBoxPosX(i)
      GuiData[i].y = getBoxPosY(i)
      GuiData[i].nx= getBoxPosX(i) + Size/2 - Font:getWidth('0')/2
      GuiData[i].ny= getBoxPosY(i) + Size/2 - FontHeight/2
   end

   collectgarbage()
end -- >>>

function updateSelected() -- <<<
   SelectedX = getBoxPosX(Selected)
   SelectedY = getBoxPosY(Selected)
end -- >>>

function drawBox(t) -- <<<
   local g = love.graphics

   g.rectangle("line", t.x, t.y, Size, Size)
   g.setFont(Font)
   g.print(t.d.value_s, t.nx, t.ny)

   if ShowReminder then
      -- TODO fit to box
      g.setFont(ReminderFont)
      for i,v in ipairs(t.d) do
         if v then
            g.print(tostring(i), t.x+(i*ReminderFontHeight)-1, t.y+Size-ReminderFontHeight-3)
         end
      end
   end
end -- >>>


function love.load() -- <<<

   love.graphics.setLineStyle("smooth")
   love.keyboard.setKeyRepeat(true)

   Data = -- <<<
   {
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[1] , },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[2] , },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[3] , },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[4] , },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[5] , },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[6] , },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[7] , },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[8] , },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[9] , },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[10], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[11], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[12], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[13], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[14], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[15], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[16], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[17], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[18], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[19], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[20], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[21], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[22], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[23], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[24], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[25], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[26], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[27], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[28], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[29], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[30], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[31], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[32], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[33], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[34], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[35], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[36], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[37], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[38], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[39], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[40], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[41], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[42], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[43], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[44], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[45], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[46], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[47], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[48], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[49], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[50], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[51], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[52], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[53], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[54], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[55], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[56], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[57], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[58], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[59], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[60], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[61], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[62], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[63], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[64], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[65], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[66], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[67], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[68], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[69], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[70], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[71], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[72], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[73], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[74], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[75], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[76], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[77], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[78], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[79], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[80], },
      { x = 0, y = 0, nx= 0, ny= 0, d=sd.GameData[81], },
   } -- >>>

   Selected      = 1
   ShowReminder  = true
   IsComplete    = false
   AutoFill      = false

   updateData(Data, sd.GameData)
   updateSelected()

   DrawIt = true

end -- >>>

function love.keypressed(key, sc, isrepeat) -- <<<
   DrawIt = true

   if not IsComplete then

      if (key == "left") or (key == "h") then
         if Selected == 1 then
            return
         end
         Selected = Selected - 1
         updateSelected()
         return
      end

      if (key == "right") or (key == "l")  then
         if Selected == 81 then
            return
         end
         Selected = Selected + 1
         updateSelected()
      end

      if (key == "up") or (key == "k")  then
         if (Selected >= 1) and (Selected <= 9) then
            return
         end
         Selected = Selected - 9
         updateSelected()
         return
      end

      if (key == "down") or (key == "j")  then
         if (Selected >= 73) and (Selected <= 81) then
            return
         end
         Selected = Selected + 9
         updateSelected()
         return
      end
   end

   if not isrepeat then

      if key == "q" then
         love.event.quit()
      end

      if not IsComplete then

         if key == "r" then
            ShowReminder = not ShowReminder
         end

         if key == "a" then
            AutoFill = not AutoFill
            if AutoFill then
               while sd.autoFill() do end
               IsComplete = sd.isComplete()
            end
         end

         if key == "f" then
            while sd.autoFill() do end
            IsComplete = sd.isComplete()
         end

         if (key == "1") or (key == "2") or (key == "3") or (key == "4") or (key == "5") or (key == "6") 
         or (key == "7") or (key == "8") or (key == "9")  or (key == "0")  or (key == "space") then
            if sd.setValue(Selected, tonumber(key) or 0) then
               if AutoFill then
                  while sd.autoFill() do end
               end
               IsComplete = sd.isComplete()
            end
         end
      end
   end

end -- >>>

-- function love.mousepressed(x, y, button, istouch) -- <<<
-- end -- >>>

-- function love.mousereleased(x, y, button, istouch) -- <<<
-- end -- >>>

function love.resize(w, h) -- <<<
   DrawIt = true
   updateData(Data, sd.GameData)
   updateSelected()
end -- >>>

function love.run(dt) -- <<<
   DrawIt=true
   if love.load then love.load(love.arg.parseGameArguments(arg), arg) end

   -- We don't want the first frame's dt to include time taken by love.load.
   if love.timer then love.timer.step() end

   local dt = 0

   -- Main loop time.
   return function()
      -- Process events.
      if love.event then
         love.event.pump()
         for name, a,b,c,d,e,f in love.event.poll() do
            if name == "quit" then
               if not love.quit or not love.quit() then
                  return a or 0
               end
            end
            love.handlers[name](a,b,c,d,e,f)
         end
      end

      -- Update dt, as we'll be passing it to update
      if love.timer then dt = love.timer.step() end

      -- Call update and draw
      if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled

      if DrawIt then
         if love.graphics and love.graphics.isActive() then
            love.graphics.origin()
            love.graphics.clear(love.graphics.getBackgroundColor())

            if love.draw then love.draw() end

            love.graphics.present()
         end
         DrawIt = false
      end

      if love.timer then love.timer.sleep(0.08) end
   end
end -- >>>

--function love.errhand(msg) -- <<<
   --love.window.showMessageBox( "internal error", msg, "error", true )
--end -- >>>

function love.draw() -- <<<

   local g = love.graphics

   if AutoFill then
      g.setBackgroundColor(1, 0.8, 0.8)
   else
      g.setBackgroundColor(1, 1, 1)
   end

   g.setLineWidth(1)
   g.setColor(0,0,0)
   for _,v in ipairs(Data) do
      drawBox(v)
   end

   if not IsComplete then
      g.setColor(0,0,0)
   else
      g.setColor(0,0,1)
   end
   g.setLineWidth(3)
   g.rectangle("line", OffsetX, OffsetY, BoardSize, BoardSize)
   g.line( XA      , OffsetY , XA , YC)
   g.line( XB      , OffsetY , XB , YC)
   g.line( OffsetX , YA      , XC , YA)
   g.line( OffsetX , YB      , XC , YB)

   if not IsComplete then
      g.setColor(1,0,0)
      g.rectangle("line", SelectedX, SelectedY, Size, Size)
   end
   -- DrawIt=false
end -- >>>

-- vim: fmr=<<<,>>> fdm=marker
