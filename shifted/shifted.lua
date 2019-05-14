-- author: Marco Trosi

local Shifted = {}

local GameDataDefault =
{
   SoundOn   = true,
   MusicOn   = true,
   GameState = 'playing',
   NumOfTiles= 4,
   Solutions =
   {
      [3] = -- <<<
      {
         tlh1 = {Pattern='1,2,3,4,5,6,7,8,0', Done=false},
-- 123
-- 456
-- 780
         tlh0 = {Pattern='0,1,2,3,4,5,6,7,8', Done=false},
-- 012
-- 345
-- 678
         tlv1 = {Pattern='1,4,7,2,5,8,3,6,0', Done=false},
-- 147
-- 258
-- 360
         tlv0 = {Pattern='0,3,6,1,4,7,2,5,8', Done=false},
-- 036
-- 147
-- 258
         blh1 = {Pattern='7,8,0,4,5,6,1,2,3', Done=false},
-- 780
-- 456
-- 123
         blh0 = {Pattern='6,7,8,3,4,5,0,1,2', Done=false},
-- 678
-- 345
-- 012
         blv1 = {Pattern='3,6,0,2,5,8,1,4,7', Done=false},
-- 360
-- 258
-- 147
         blv0 = {Pattern='2,5,8,1,4,7,0,3,6', Done=false},
-- 258
-- 147
-- 036
         trh1 = {Pattern='3,2,1,6,5,4,0,8,7', Done=false},
-- 321
-- 654
-- 087
         trh0 = {Pattern='2,1,0,5,4,3,8,7,6', Done=false},
-- 210
-- 543
-- 876
         trv1 = {Pattern='7,4,1,8,5,2,0,6,3', Done=false},
-- 741
-- 852
-- 063
         trv0 = {Pattern='6,3,0,7,4,1,8,5,2', Done=false},
-- 630
-- 741
-- 852
         brh1 = {Pattern='0,8,7,6,5,4,3,2,1', Done=false},
-- 087
-- 654
-- 321
         brh0 = {Pattern='8,7,6,5,4,3,2,1,0', Done=false},
-- 876
-- 543
-- 210
         brv1 = {Pattern='0,6,3,8,5,2,7,4,1', Done=false},
-- 063
-- 852
-- 741
         brv0 = {Pattern='8,5,2,7,4,1,6,3,0', Done=false},
-- 852
-- 741
-- 630
      }, -- >>>

      [4] = -- <<<
      {
         tlh1 = '',
         tlh0 = '',
         tlv1 = '',
         tlv0 = '',

         blh1 = '',
         blh0 = '',
         blv1 = '',
         blv0 = '',

         trh1 = '',
         trh0 = '',
         trv1 = '',
         trv0 = '',

         brh1 = '',
         brh0 = '',
         brv1 = '',
         brv0 = '',
      }, -- >>>
   }
}

-- local variables <<<
local WinWidth  = love.graphics.getWidth()
local WinHeight = love.graphics.getHeight()
local OffX
local OffY
local TileSize
local TilesPos = {}
local Font
local Music
local Cheer
local Pop
local Color =
{

   ['red1']   = {158/255,  12/255,  57/255}, 
   ['red2']   = {226/255,  27/255,  90/255}, 
   ['green1'] = {131/255, 163/255,   0/255}, 
   ['green2'] = {221/255, 257/255, 227/255}, 
   ['orange'] = {206/255, 153/255,  14/255}, 
   ['blue2']  = { 86/255, 126/255, 187/255}, 
   ['grey1']  = { 51/255,  51/255,  51/255}, 
   ['grey3']  = {220/255, 224/255, 230/255}, 
   ['grey2']  = { 96/255, 109/255, 128/255}, 

}

local MusicButton =
{
   XPos  = 0,
   YPos  = 0,
   Color = 0,
   TXPos = 0,
   TYPos = 0,
}

local SoundButton =
{
   XPos  = 0,
   YPos  = 0,
   Color = 0,
   TXPos = 0,
   TYPos = 0,
}

local TbTButton =
{
   XPos  = 0,
   YPos  = 0,
   TXPos = 0,
   TYPos = 0,
}

local FbFButton =
{
   XPos  = 0,
   YPos  = 0,
   TXPos = 0,
   TYPos = 0,
}
-- >>>

function serializeData(t, f) -- <<<

   local DataFile = love.filesystem.newFile(f)

   local function serializeDataHelper(obj, cnt)

      local cnt = cnt or 0

      if type(obj) == "table" then

         DataFile:write("\n" .. string.rep("\t", cnt) .. "{\n")
         cnt = cnt + 1

         for k,v in pairs(obj) do

            if type(k) == "string" then
               DataFile:write(string.rep("\t",cnt) .. '["' .. k .. '"] = ')
            end

            if type(k) == "number" then
               DataFile:write(string.rep("\t",cnt) .. "[" .. k .. "] = ")
            end

            serializeDataHelper(v, cnt)
            DataFile:write(",\n")
         end

         cnt = cnt-1
         DataFile:write(string.rep("\t", cnt) .. "}")

      elseif type(obj) == "string" then
         DataFile:write(string.format("%q", obj))

      else
         DataFile:write(tostring(obj))
      end 
   end

   DataFile:open('w')
   DataFile:write("return")
   serializeDataHelper(t)
   DataFile:close()

end -- >>>

function calcBoard() -- <<<

   -- board <<<
   local RasterX  = WinWidth  / (Shifted.GameData.NumOfTiles + 2)
   local RasterY  = WinHeight / (Shifted.GameData.NumOfTiles + 2)
   TileSize = math.floor(math.min(RasterX, RasterY))

   if(WinHeight < WinWidth) then -- horizontal
      OffX = math.floor((WinWidth - (TileSize * Shifted.GameData.NumOfTiles))/2)
      OffY = TileSize
   else -- vertical
      OffY = math.floor((WinHeight - (TileSize * Shifted.GameData.NumOfTiles))/2)
      OffX = TileSize
   end
   -- >>>

   -- music button <<<
   MusicButton.XPos = OffX + (((TileSize*Shifted.GameData.NumOfTiles) - (2*TileSize))/3)
   MusicButton.YPos = WinHeight - ((TileSize/4)*3)

   if Shifted.GameData.MusicOn then
      MusicButton.Color = Color.green1
   else
      MusicButton.Color = Color.red2
   end
   -- fontSize(math.floor(TileSize/3))
   MusicButton.TXPos = MusicButton.XPos + ((TileSize - Font:getWidth('music'))/2)
   MusicButton.TYPos = MusicButton.YPos + ((TileSize/2 - Font:getHeight())/2)
   -- >>>

   -- sound button <<<
   SoundButton.XPos = OffX + ((((TileSize * Shifted.GameData.NumOfTiles) - (2*TileSize)) / 3)*2) + TileSize
   SoundButton.YPos = WinHeight - ((TileSize/4)*3)

   if Shifted.GameData.SoundOn then
      SoundButton.Color = Color.green1
   else
      SoundButton.Color = Color.red2
   end

   SoundButton.TXPos = SoundButton.XPos + ((TileSize - Font:getWidth('sound'))/2)
   SoundButton.TYPos = SoundButton.YPos + ((TileSize/2 - Font:getHeight())/2)
   -- >>>

   -- 3x3 button <<<
   TbTButton.XPos  = OffX + (((TileSize * Shifted.GameData.NumOfTiles) - (2*TileSize)) / 3)
   TbTButton.YPos  = (TileSize*0.25)
   TbTButton.TXPos = TbTButton.XPos + ((TileSize - Font:getWidth('3x3'))/2)
   TbTButton.TYPos = TbTButton.YPos + ((TileSize/2 - Font:getHeight())/2)
   -- >>>

   -- 4x4 button <<<
   FbFButton.XPos  = OffX + ((((TileSize * Shifted.GameData.NumOfTiles) - (2*TileSize)) / 3)*2) + TileSize
   FbFButton.YPos  = (TileSize*0.25)
   FbFButton.TXPos = FbFButton.XPos + ((TileSize - Font:getWidth('4x4'))/2)
   FbFButton.TYPos = FbFButton.YPos + ((TileSize/2 - Font:getHeight())/2)
   -- >>>

end -- >>>

function shuffleTiles() -- <<<

   Shifted.GameData.Tiles = {}
   local Values = {}
   local NumOfTiles = Shifted.GameData.NumOfTiles * Shifted.GameData.NumOfTiles

   for i=0, (NumOfTiles-1) do
      table.insert(Values, i)
   end

   for i=1, NumOfTiles do
      local RandNum = math.random(1,#Values)
      table.insert(Shifted.GameData.Tiles, tostring(Values[RandNum]))
      table.remove(Values, RandNum)
   end
end -- >>>

function calcTilesPos(Tiles) -- <<<
   TilesPos = {}

   for i,v in ipairs(Tiles) do
         table.insert(TilesPos,
         {
            Text  = v,
            XPos  = OffX + (((i-1) % Shifted.GameData.NumOfTiles) * TileSize),
            YPos  = OffY + (math.floor((i-1)/Shifted.GameData.NumOfTiles) * TileSize),
            TXPos = OffX + (((i-1) % Shifted.GameData.NumOfTiles) * TileSize)         + ((TileSize - Font:getWidth(v))/2),
            TYPos = OffY + (math.floor((i-1)/Shifted.GameData.NumOfTiles) * TileSize) + ((TileSize - Font:getHeight())/2),
         })
   end

   collectgarbage()
end -- >>>

function drawTile(t) -- <<<
   love.graphics.setColor(Color.blue2)
   love.graphics.rectangle('fill', t.XPos, t.YPos, TileSize, TileSize)
   love.graphics.setColor(Color.grey1)
   love.graphics.rectangle('line', t.XPos, t.YPos, TileSize, TileSize)
   love.graphics.setColor(Color.grey3)
   love.graphics.print(t.Text, t.TXPos, t.TYPos)
end -- >>>

function getTileFromRowCol(Row, Col) -- <<<
   return ((Row-1)*Shifted.GameData.NumOfTiles)+Col
end -- >>>


function Shifted.loadGame() -- <<<
   Font = love.graphics.newFont("font/GeosansLight.ttf", 30)
   love.graphics.setFont(Font)

   Shifted.DataFile = 'data.lua'
   if love.filesystem.getInfo(Shifted.DataFile, 'file') then
      print('loading data file')
      local Status, GameData = pcall(dofile, love.filesystem.getSaveDirectory() .. '/' .. Shifted.DataFile)
      if Status then
         Shifted.GameData = GameData
      else
         print('could not load data file', GameData)
         os.exit(1)
      end
   else
      print('no data file')
      Shifted.GameData = GameDataDefault
   end

   Pop = love.audio.newSource("sound/pop.wav", "static")
   Cheer = love.audio.newSource("sound/cheer.wav", "static")
   Music = love.audio.newSource("music/music.mp3", "static")
   if Shifted.GameData.MusicOn then
      love.audio.play(Music)
   end

   love.graphics.setBackgroundColor(Color.grey1)
end -- >>>

function Shifted.startGame(NumOfTiles) -- <<<
   Shifted.GameData.NumOfTiles = NumOfTiles
   -- if MSC then music.paused = false end
   calcBoard()
   shuffleTiles()
   calcTilesPos(Shifted.GameData.Tiles)
   Shifted.GameData.GameState = "playing"
end -- >>>

function Shifted.drawTiles() -- <<<
   for i,v in ipairs(TilesPos) do
      if v.Text ~= "0" then
         drawTile(v)
      end
   end
end -- >>>

function Shifted.drawMusicButton() -- <<<
   love.graphics.setColor(MusicButton.Color)
   love.graphics.rectangle('fill', MusicButton.XPos, MusicButton.YPos, TileSize, TileSize/2)
   love.graphics.setColor(Color.grey3)
   love.graphics.print("music", MusicButton.TXPos, MusicButton.TYPos)
end -- >>>

function Shifted.drawSoundButton() -- <<<
   love.graphics.setColor(SoundButton.Color)
   love.graphics.rectangle('fill', SoundButton.XPos, SoundButton.YPos, TileSize, TileSize/2)
   love.graphics.setColor(Color.grey3)
   love.graphics.print('sound', SoundButton.TXPos, SoundButton.TYPos)
end -- >>>

function Shifted.draw3x3Button() -- <<<
   love.graphics.setColor(Color.orange)
   love.graphics.rectangle('fill', TbTButton.XPos, TbTButton.YPos, TileSize, TileSize/2)
   love.graphics.setColor(Color.grey3)
   love.graphics.print('3x3', TbTButton.TXPos, TbTButton.TYPos)
end -- >>>

function Shifted.draw4x4Button() -- <<<
   love.graphics.setColor(Color.orange)
   love.graphics.rectangle('fill', FbFButton.XPos, FbFButton.YPos, TileSize, TileSize/2)
   love.graphics.setColor(Color.grey3)
   love.graphics.print('4x4', FbFButton.TXPos, FbFButton.TYPos)
end -- >>>

function Shifted.isMusicButton(x,y) -- <<<
   if (x >= MusicButton.XPos) and (x <= (MusicButton.XPos + TileSize)) and (y >= MusicButton.YPos) and (y <= (MusicButton.YPos + (TileSize/2))) then
      return true
   else
      return false
   end
end -- >>>

function Shifted.pressMusicButton() -- <<<
   Shifted.GameData.MusicOn = not Shifted.GameData.MusicOn
   if Shifted.GameData.MusicOn then
      love.audio.play(Music)
      MusicButton.Color = Color.green1
   else
      love.audio.pause(Music)
      MusicButton.Color = Color.red2
   end
end -- >>>

function Shifted.isSoundButton(x,y) -- <<<
   if (x >= SoundButton.XPos) and (x <= (SoundButton.XPos + TileSize)) and (y >= SoundButton.YPos) and (y <= (SoundButton.YPos + (TileSize/2))) then
      return true
   else
      return false
   end
end -- >>>

function Shifted.pressSoundButton() -- <<<
   Shifted.GameData.SoundOn = not Shifted.GameData.SoundOn
   if Shifted.GameData.SoundOn then
      SoundButton.Color = Color.green1
   else
      SoundButton.Color = Color.red2
   end
end -- >>>

function Shifted.is3x3Button(x,y) -- <<<
   if (x >= TbTButton.XPos) and (x <= (TbTButton.XPos + TileSize)) and (y >= TbTButton.YPos) and (y <= (TbTButton.YPos + (TileSize/2))) then
      return true
   else
      return false
   end
end -- >>>

function Shifted.is4x4Button(x,y) -- <<<
   if (x >= FbFButton.XPos) and (x <= (FbFButton.XPos + TileSize)) and (y >= FbFButton.YPos) and (y <= (FbFButton.YPos + (TileSize/2))) then
      return true
   else
      return false
   end
end -- >>>

function Shifted.getTileFromCoord(x,y) -- <<<
   for i,v in ipairs(TilesPos) do
      if (x >= v.XPos) and (x <= (v.XPos + TileSize)) and (y >= v.YPos) and (y <= v.YPos + TileSize) then
         return i
      end
   end
end -- >>>

function Shifted.isTile(i) -- NOT YET USED <<<
   if (TileNum ~= nil) and (s.GameData.Tiles[TileNum] ~= "0") then
   end
end -- >>>

function Shifted.getRowColFromTile(i) -- <<<
   if i == nil then
      for n,v in ipairs(Shifted.GameData.Tiles) do
         if v == "0" then
            i=n
            break
         end
      end
   end
   return ((math.floor((i-1)/Shifted.GameData.NumOfTiles))+1), (((i-1)%Shifted.GameData.NumOfTiles)+1), i
end -- >>>

function Shifted.isShiftable(RowTile, ColTile, RowNull, ColNull) -- <<<
   return ((RowTile == RowNull) or (ColTile == ColNull))
end -- >>>

function Shifted.shiftTile(RowTile, ColTile, RowNull, ColNull) -- <<<

   if RowTile == RowNull then

      d = (ColTile-ColNull)/math.abs(ColTile-ColNull)

      for i=ColNull, ColTile-d, d do
         Tile1 = getTileFromRowCol(RowTile, i)
         Tile2 = getTileFromRowCol(RowTile, i+d)
         -- print("d",d,"i",i,"ColNull",ColNull,"ColTile",ColTile,"Tile1",Tile1,"Tile2",Tile2)
         Shifted.GameData.Tiles[Tile1], Shifted.GameData.Tiles[Tile2] = Shifted.GameData.Tiles[Tile2], Shifted.GameData.Tiles[Tile1]
      end
   end

   if ColTile == ColNull then

      d = (RowTile-RowNull)/math.abs(RowTile-RowNull)

      for i=RowNull, RowTile-d, d do
         Tile1 = getTileFromRowCol(i,   ColTile)
         Tile2 = getTileFromRowCol(i+d, ColTile)
         -- print("d",d,"i",i,"ColNull",ColNull,"ColTile",ColTile,"Tile1",Tile1,"Tile2",Tile2)
         Shifted.GameData.Tiles[Tile1], Shifted.GameData.Tiles[Tile2] = Shifted.GameData.Tiles[Tile2], Shifted.GameData.Tiles[Tile1]
      end
   end

   calcTilesPos(Shifted.GameData.Tiles)

   if Shifted.GameData.SoundOn then love.audio.play(Pop) end
   
end -- >>>

function Shifted.isWon() -- <<<
   local TilesString = table.concat(Shifted.GameData.Tiles,",")
   for i,v in pairs(Shifted.GameData.Solutions[Shifted.GameData.NumOfTiles]) do
      if TilesString == v.Pattern then
         Shifted.GameData.Solutions[Shifted.GameData.NumOfTiles][i].Done = true
         return true
      end
   end
   return false
end -- >>>

function Shifted.winGame() -- <<<
   Shifted.GameData.GameState = "won"
   love.audio.pause(Music)
   if Shifted.GameData.SoundOn then love.audio.play(Cheer) end
   print('writing data file')
   serializeData(Shifted.GameData, Shifted.DataFile)
end -- >>>

return Shifted
