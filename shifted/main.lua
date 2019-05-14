-- author: Marco Trosi

-- TODO
-- font size should depend on TileSize
-- ensure init pattern is not already a solution
-- generate solutions instead of hard coded -> currently only solutions for 3x3 available
-- remember game settings
-- remember won solutions
-- better button size calculation including font size and resizing and fullscreen
-- various screens -> state machine
--    splash screen
--    intro screen
--    about screen
--    options screen
--    won solutions screen
--    playing screen
-- add win animation
-- new music
-- new sound
-- create icon
-- remove unused colors
-- canvas ???
-- should I move the isWon-check to the shiftTile function?
-- is the collectgarbage function used in a good way?

local s = require "shifted"

function love.load() -- <<<
   math.randomseed(os.time())
   s.loadGame()
   s.startGame(s.GameData.NumOfTiles)
end -- >>>

function love.resize(w, h) -- <<<
end -- >>>

-- function love.update(dt) -- <<<
--    if (s.GameData.GameState == 'playing') and s.isWon() then
--       s.winGame()
--    end
-- end -- >>>

function love.draw() -- <<<
   s.drawTiles()
   s.drawMusicButton()
   s.drawSoundButton()
   s.draw3x3Button()
   s.draw4x4Button()
end -- >>>

function love.mousepressed(x, y, button, istouch) -- <<<

   if s.GameData.GameState == 'playing' then

      local TileNum = s.getTileFromCoord(x, y)

      if (TileNum ~= nil) and (s.GameData.Tiles[TileNum] ~= '0') then

         local RowNull, ColNull, NullTileNum = s.getRowColFromTile()
         local RowTile, ColTile              = s.getRowColFromTile(TileNum)

         if s.isShiftable(RowTile, ColTile, RowNull, ColNull) then
            s.shiftTile(RowTile, ColTile, RowNull, ColNull)
            if s.isWon() then
               s.winGame()
            end
         end
      end
   end

   if     s.isMusicButton(x, y) then s.pressMusicButton()
   elseif s.isSoundButton(x, y) then s.pressSoundButton()
   elseif s.is3x3Button(x, y)   then s.startGame(3)
   elseif s.is4x4Button(x, y)   then s.startGame(4)
   end     

end -- >>>

function love.keypressed(key, sc, isrepeat) -- <<<

   if (key == "up") or (key == "down") or (key == "left") or (key == "right") then
      if s.GameData.GameState == "playing" then
         local RowNull, ColNull, NullTileNum = s.getRowColFromTile()
         local TileNum
         if (key == "up") then
            TileNum = NullTileNum + s.GameData.NumOfTiles
         elseif (key == "down") then
            TileNum = NullTileNum - s.GameData.NumOfTiles
         elseif (key == "left") then
            TileNum = NullTileNum + 1
         elseif (key == "right") then
            TileNum = NullTileNum - 1
         end
         local RowTile, ColTile = s.getRowColFromTile(TileNum)
         if (TileNum >= 1) and (TileNum <= (s.GameData.NumOfTiles * s.GameData.NumOfTiles)) then
            s.shiftTile(RowTile, ColTile, RowNull, ColNull)
            if s.isWon() then
               s.winGame()
            end
         end
      end

   elseif (key == "3") or (key == "4") or (key == "5") or (key == "6") then
      s.startGame(tonumber(key))

   elseif key == "m" then
      s.pressMusicButton()

   elseif key == "s" then
      s.pressSoundButton()

   elseif key == "q" then
      print('writing data file')
      serializeData(s.GameData, s.DataFile)
      love.event.quit()
   end
end -- >>>

