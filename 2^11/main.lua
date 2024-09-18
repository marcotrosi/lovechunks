
function addField() -- <<<
   local EmptyFields = {}
   for row=1,4 do
      for col=1,4 do
         if Data[row][col] == 0 then
            table.insert(EmptyFields, {row=row, col=col})
         end
      end
   end
   if #EmptyFields == 0 then
      return false
   end

   local Field = EmptyFields[ math.random(1,#EmptyFields) ]
   Data[Field.row][Field.col] = 1
   return true
end -- >>>

function removeGaps() -- <<<
   for row=1,4 do
      local ShiftCnt = 0
      local Rd       = 1
      for col=1, 3 do
         if Data[row][Rd] == 0 then
            table.remove(Data[row], Rd)
            ShiftCnt = ShiftCnt + 1
         else
            Rd = Rd + 1
         end
      end
      for i=1,ShiftCnt do
         table.insert(Data[row], 0)
      end
   end
end -- >>>

function combineFields() -- <<<
   for row=1,4 do
      for col=1, 3 do
         if Data[row][col] ~= 0 then
            if Data[row][col] == Data[row][col+1] then
               Data[row][col] = Data[row][col] + 1
               Data[row][col+1] = 0
            end
         end
      end
   end
end -- >>>

function equalData() -- <<<
   for row=1,4 do
      for col=1,4 do
         if Data[row][col] ~= DataCopy[row][col] then
            return false
         end
      end
   end
   return true
end -- >>>

function copyData() -- <<<
   DataCopy[1][1],DataCopy[1][2],DataCopy[1][3],DataCopy[1][4], DataCopy[2][1],DataCopy[2][2],DataCopy[2][3],DataCopy[2][4], DataCopy[3][1],DataCopy[3][2],DataCopy[3][3],DataCopy[3][4], DataCopy[4][1],DataCopy[4][2],DataCopy[4][3],DataCopy[4][4] = Data[1][1],Data[1][2],Data[1][3],Data[1][4], Data[2][1],Data[2][2],Data[2][3],Data[2][4], Data[3][1],Data[3][2],Data[3][3],Data[3][4], Data[4][1],Data[4][2],Data[4][3],Data[4][4]
end -- >>>

function isShiftable() -- <<<
   -- find any gaps
   for row=1,4 do
      for col=1,4 do
         if Data[row][col] == 0 then
            return true
         end
      end
   end
   -- find same neighbours
   for row=1,3 do
      for col=1,3 do
         if (Data[row][col] == Data[row][col+1]) or (Data[row][col] == Data[row+1][col]) then
            return true
         end
      end
   end
   return false
end -- >>>

function shiftLeft() -- <<<
   copyData()
   removeGaps()
   combineFields()
   removeGaps()
   return not equalData()
end -- >>>

function shiftRight() -- <<<
   Data[1][1],Data[1][2],Data[1][3],Data[1][4], Data[2][1],Data[2][2],Data[2][3],Data[2][4], Data[3][1],Data[3][2],Data[3][3],Data[3][4], Data[4][1],Data[4][2],Data[4][3],Data[4][4] = Data[1][4],Data[1][3],Data[1][2],Data[1][1], Data[2][4],Data[2][3],Data[2][2],Data[2][1], Data[3][4],Data[3][3],Data[3][2],Data[3][1], Data[4][4],Data[4][3],Data[4][2],Data[4][1]
   local Changed = shiftLeft()
   Data[1][4],Data[1][3],Data[1][2],Data[1][1], Data[2][4],Data[2][3],Data[2][2],Data[2][1], Data[3][4],Data[3][3],Data[3][2],Data[3][1], Data[4][4],Data[4][3],Data[4][2],Data[4][1] = Data[1][1],Data[1][2],Data[1][3],Data[1][4], Data[2][1],Data[2][2],Data[2][3],Data[2][4], Data[3][1],Data[3][2],Data[3][3],Data[3][4], Data[4][1],Data[4][2],Data[4][3],Data[4][4]
   return Changed
end -- >>>

function shiftUp() -- <<<
   Data[1][1],Data[1][2],Data[1][3],Data[1][4], Data[2][1],Data[2][2],Data[2][3],Data[2][4], Data[3][1],Data[3][2],Data[3][3],Data[3][4], Data[4][1],Data[4][2],Data[4][3],Data[4][4] = Data[1][4],Data[2][4],Data[3][4],Data[4][4], Data[1][3],Data[2][3],Data[3][3],Data[4][3], Data[1][2],Data[2][2],Data[3][2],Data[4][2], Data[1][1],Data[2][1],Data[3][1],Data[4][1]
   local Changed = shiftLeft()
   Data[1][4],Data[2][4],Data[3][4],Data[4][4], Data[1][3],Data[2][3],Data[3][3],Data[4][3], Data[1][2],Data[2][2],Data[3][2],Data[4][2], Data[1][1],Data[2][1],Data[3][1],Data[4][1] = Data[1][1],Data[1][2],Data[1][3],Data[1][4], Data[2][1],Data[2][2],Data[2][3],Data[2][4], Data[3][1],Data[3][2],Data[3][3],Data[3][4], Data[4][1],Data[4][2],Data[4][3],Data[4][4]
   return Changed
end -- >>>

function shiftDown() -- <<<
   Data[1][1],Data[1][2],Data[1][3],Data[1][4], Data[2][1],Data[2][2],Data[2][3],Data[2][4], Data[3][1],Data[3][2],Data[3][3],Data[3][4], Data[4][1],Data[4][2],Data[4][3],Data[4][4] = Data[4][1],Data[3][1],Data[2][1],Data[1][1], Data[4][2],Data[3][2],Data[2][2],Data[1][2], Data[4][3],Data[3][3],Data[2][3],Data[1][3], Data[4][4],Data[3][4],Data[2][4],Data[1][4]
   local Changed = shiftLeft()
   Data[4][1],Data[3][1],Data[2][1],Data[1][1], Data[4][2],Data[3][2],Data[2][2],Data[1][2], Data[4][3],Data[3][3],Data[2][3],Data[1][3], Data[4][4],Data[3][4],Data[2][4],Data[1][4] = Data[1][1],Data[1][2],Data[1][3],Data[1][4], Data[2][1],Data[2][2],Data[2][3],Data[2][4], Data[3][1],Data[3][2],Data[3][3],Data[3][4], Data[4][1],Data[4][2],Data[4][3],Data[4][4]
   return Changed
end -- >>>

function calcTextPos() -- <<<
   for row=1,4 do
      for col=1,4 do
         local TextWidth,TextHeight = SquareTexts[Data[row][col]]:getDimensions()
         TextPos[row][col].s        = (SquareSize*0.8)/math.max(TextHeight,TextWidth)
         local TextOffsetX          = math.floor((SquareSize - (TextWidth *TextPos[row][col].s))/2)
         local TextOffsetY          = math.floor((SquareSize - (TextHeight*TextPos[row][col].s))/2)
         TextPos[row][col].x        = FrameX+TextOffsetX+(Spacing*col)+((col-1)*SquareSize)
         TextPos[row][col].y        = FrameY+TextOffsetY+(Spacing*row)+((row-1)*SquareSize)
      end
   end
end -- >>>

function drawBoard() -- <<<
   love.graphics.setBackgroundColor( BackColor )
   love.graphics.setColor(FrameColor)
   love.graphics.rectangle("fill", FrameX, FrameY, FrameSize, FrameSize, SquareCorner, SquareCorner)

   for row=1,4 do
      for col=1,4 do
         love.graphics.setColor(SquareColors[Data[row][col]])
         love.graphics.rectangle("fill", SquarePos[row][col].x, SquarePos[row][col].y, SquareSize, SquareSize, SquareCorner, SquareCorner)
         if Data[row][col] ~= 0 then
            love.graphics.setColor(TextColor)
            love.graphics.draw(SquareTexts[Data[row][col]], TextPos[row][col].x, TextPos[row][col].y, 0, TextPos[row][col].s, TextPos[row][col].s)
         end
      end
   end
end -- >>>

function love.load() -- <<<

   math.randomseed(os.time())
   CurrentState = 'menu'

   Width, Height = love.graphics.getDimensions()
   FrameSize     = math.floor(math.min(Width, Height) * 0.9)
   FrameX        = math.floor((Width - FrameSize) / 2)
   FrameY        = math.floor((Height - FrameSize) / 2)
   Spacing       = math.floor(FrameSize * 0.02)
   SquareSize    = math.floor((FrameSize - (5*Spacing))/4)
   SquareCorner  = math.floor(FrameSize * 0.02)
   Font          = love.graphics.newFont("OpenSans-Regular.ttf", SquareSize)
   love.graphics.setFont(Font)

   ---[[
   Data = {
      {0,0,0,0},
      {0,0,0,0},
      {0,0,0,0},
      {0,0,0,0},
   }
   --]]

   --[[
   Data = {
      {1,2,3,4},
      {5,6,7,8},
      {9,10,11,12},
      {0,0,0,0},
   }
   --]]

   DataCopy = {
      {0,0,0,0},
      {0,0,0,0},
      {0,0,0,0},
      {0,0,0,0},
   }

   TextPos = {
      {{x=0,y=0,s=1},{x=0,y=0,s=1},{x=0,y=0,s=1},{x=0,y=0,s=1}},
      {{x=0,y=0,s=1},{x=0,y=0,s=1},{x=0,y=0,s=1},{x=0,y=0,s=1}},
      {{x=0,y=0,s=1},{x=0,y=0,s=1},{x=0,y=0,s=1},{x=0,y=0,s=1}},
      {{x=0,y=0,s=1},{x=0,y=0,s=1},{x=0,y=0,s=1},{x=0,y=0,s=1}},
   }

   SquarePos = {
      {{x=0,y=0},{x=0,y=0},{x=0,y=0},{x=0,y=0}},
      {{x=0,y=0},{x=0,y=0},{x=0,y=0},{x=0,y=0}},
      {{x=0,y=0},{x=0,y=0},{x=0,y=0},{x=0,y=0}},
      {{x=0,y=0},{x=0,y=0},{x=0,y=0},{x=0,y=0}},
   }

   for row=1,4 do
      for col=1,4 do
         SquarePos[row][col].x = FrameX+(Spacing*col)+((col-1)*SquareSize)
         SquarePos[row][col].y = FrameY+(Spacing*row)+((row-1)*SquareSize)
      end
   end

   BackColor = {love.math.colorFromBytes(252, 244, 234)} --  #FCF4EA
   TextColor = {love.math.colorFromBytes(250, 237, 212)} --  #FAEDD4
   FrameColor= {love.math.colorFromBytes(127, 119, 111)} --  #7F776F
   SquareColors = {
[0] = {love.math.colorFromBytes(189, 175, 164)}, -- #BDAFA4 empty
      {love.math.colorFromBytes(80 , 129, 142)}, -- #50818E 1  
      {love.math.colorFromBytes(224, 37 , 78 )}, -- #E0254E 2   
      {love.math.colorFromBytes(84 , 104, 48 )}, -- #546830 4   
      {love.math.colorFromBytes(251, 182, 74 )}, -- #FBB64A 8   
      {love.math.colorFromBytes(213, 88 , 31 )}, -- #D5581F 16  
      {love.math.colorFromBytes(120, 84 , 176)}, -- #7854B0 32 
      {love.math.colorFromBytes(63 , 146, 139)}, -- #3F928B 64
      {love.math.colorFromBytes(162, 152, 16 )}, -- #A29810 128
      {love.math.colorFromBytes(136, 42 , 69 )}, -- #882A45 256
      {love.math.colorFromBytes(73 , 86 , 141)}, -- #49568D 512
      {love.math.colorFromBytes(215, 167, 65 )}, -- #D7A741 1024
      {love.math.colorFromBytes(51 , 51 , 51 )}, -- #333333 2048
   }

   SquareTexts = {
[0] = love.graphics.newText(Font,""),
      love.graphics.newText(Font,"1"),
      love.graphics.newText(Font,"2"),
      love.graphics.newText(Font,"4"),
      love.graphics.newText(Font,"8"),
      love.graphics.newText(Font,"16"),
      love.graphics.newText(Font,"32"),
      love.graphics.newText(Font,"64"),
      love.graphics.newText(Font,"128"),
      love.graphics.newText(Font,"256"),
      love.graphics.newText(Font,"512"),
      love.graphics.newText(Font,"1024"),
      love.graphics.newText(Font,"2048"),
   }

   MenuText     = love.graphics.newText(Font,"[P]LAY\n[Q]UIT")
   GameOverText = love.graphics.newText(Font,"GAME OVER")

   State =
   {
      ['menu'] = -- <<<
      {

         ['draw'] = function()
            drawBoard()
            love.graphics.setColor(0.1, 0.1, 0.1, 0.8)
            love.graphics.rectangle("fill", 0, 0, Width, Height)
            love.graphics.setColor(love.math.colorFromBytes(224, 37 , 78 ))
            love.graphics.draw(MenuText, (Width/2)-(MenuText:getWidth()/2), (Height/2)-(MenuText:getHeight()/2))
         end,

         ['keypressed'] = function(key, sc, isrepeat)
            if key == 'p' then
               CurrentState = 'play'
               addField()
               calcTextPos()
            end
         end,
      }, -- >>>

      ['play'] = -- <<<
      {
         ['draw'] = function()
            drawBoard()
         end,

         ['keypressed'] = function(key, sc, isrepeat)
            local Shifted = false
            if (key == 'left')  or (key == 'h') then Shifted = shiftLeft()  end
            if (key == 'right') or (key == 'l') then Shifted = shiftRight() end
            if (key == 'up')    or (key == 'k') then Shifted = shiftUp()    end
            if (key == 'down')  or (key == 'j') then Shifted = shiftDown()  end
            if Shifted then addField() end
            calcTextPos()
            if not isShiftable() then CurrentState = 'gameover' end
         end
      }, -- >>>

      ['gameover'] = -- <<<
      {
         ['draw'] = function()
            drawBoard()
            love.graphics.setColor(0.1, 0.1, 0.1, 0.8)
            love.graphics.rectangle("fill", 0, 0, Width, Height)
            love.graphics.setColor(love.math.colorFromBytes(224, 37 , 78 ))
            love.graphics.draw(GameOverText, (Width/2)-(GameOverText:getWidth()/2), (Height/2)-(GameOverText:getHeight()/2))
         end,

         ['keypressed'] = function(key, sc, isrepeat)
            for row=1,4 do
               for col=1,4 do
                  Data[row][col] = 0
               end
            end
            CurrentState = 'menu'
         end,
      }, -- >>>
   }

end -- >>>

-- function love.update(dt) -- <<<
--    if State[CurrentState].update then
--       State[CurrentState].update(dt)
--    end
-- end -- >>>

function love.draw() -- <<<
   if State[CurrentState].draw then
      State[CurrentState].draw()
   end
end -- >>>

function love.keypressed(key, sc, isrepeat) -- <<<
   if key == 'q' then
      love.event.quit()
   else
      if State[CurrentState].keypressed then
         State[CurrentState].keypressed(key, sc, isrepeat)
      end
   end
end -- >>>

-- vim: fdm=marker fmr=<<<,>>>
