-- TODO:
-- fix margins, spaces and font size

function calcSizes() -- <<<

   Width, Height = love.graphics.getDimensions()

   FontSizeFactor = 0.08

   if Width >= Height then
      FontSize = FontSizeFactor*Height
      Space    = (Height-(FontSize*10))/11
   else
      FontSize = FontSizeFactor*Width
      Space    = (Width-(FontSize*11))/12
   end

   ClockHeight = (FontSize*10)+(Space*9)
   ClockWidth  = (FontSize*11)+(Space*10)

   -- fontSize(FontSize)

   for rowi,rowt in ipairs(Data) do
      for coli, colt in ipairs(rowt) do
         Data[rowi][coli].X = calcX(coli)
         Data[rowi][coli].Y = calcY(rowi)
      end
   end
end -- >>>

function calcX(col) -- <<<
   return ((Width-ClockWidth)/2)+((col-1)*FontSize) + ((col-1)*Space) + (FontSize/2)
end -- >>>

function calcY(row) -- <<<
   return  (((row-1)*FontSize) + ((row-1)*Space) + (FontSize/2))-((Height-ClockHeight)/2)
end -- >>>

function drawLetter(t) -- <<<
   love.graphics.print(t.c, t.X, t.Y)
end -- >>>



function love.load() -- <<<

   Font = love.graphics.newFont("GeosansLight.ttf", 30)
   love.graphics.setFont(Font)
   love.graphics.setLineStyle("smooth")
   BackgroundColor = { 16/255,  15/255,  14/255}
   InactiveColor   = { 38/255,  35/255,  32/255}
   ActiveColor     = {221/255, 209/255, 173/255}

   Data =
   {
      {{c="E"},{c="S"},{c="K"},{c="I"},{c="S"},{c="T"},{c="A"},{c="F"},{c="Ü"},{c="N"},{c="F"}},
      {{c="Z"},{c="E"},{c="H"},{c="N"},{c="Z"},{c="W"},{c="A"},{c="N"},{c="Z"},{c="I"},{c="G"}},
      {{c="D"},{c="R"},{c="E"},{c="I"},{c="V"},{c="I"},{c="E"},{c="R"},{c="T"},{c="E"},{c="L"}},
      {{c="V"},{c="O"},{c="R"},{c="F"},{c="U"},{c="N"},{c="K"},{c="N"},{c="A"},{c="C"},{c="H"}},
      {{c="H"},{c="A"},{c="L"},{c="B"},{c="A"},{c="E"},{c="L"},{c="F"},{c="Ü"},{c="N"},{c="F"}},
      {{c="E"},{c="I"},{c="N"},{c="S"},{c="X"},{c="A"},{c="M"},{c="Z"},{c="W"},{c="E"},{c="I"}},
      {{c="D"},{c="R"},{c="E"},{c="I"},{c="P"},{c="M"},{c="J"},{c="V"},{c="I"},{c="E"},{c="R"}},
      {{c="S"},{c="E"},{c="C"},{c="H"},{c="S"},{c="N"},{c="L"},{c="A"},{c="C"},{c="H"},{c="T"}},
      {{c="S"},{c="I"},{c="E"},{c="B"},{c="E"},{c="N"},{c="Z"},{c="W"},{c="Ö"},{c="L"},{c="F"}},
      {{c="Z"},{c="E"},{c="H"},{c="N"},{c="E"},{c="U"},{c="N"},{c="K"},{c="U"},{c="H"},{c="R"}},
   }

   TimeWords =
   {
      ["es"]        ={State=true , {r=1, c=1}, {r=1, c=2}                                                                    },
      ["ist"]       ={State=true , {r=1, c=4}, {r=1, c=5}, {r=1, c=6 }                                                       },
      ["funfMIN"]   ={State=false, {r=1, c=8}, {r=1, c=9}, {r=1, c=10}, {r=1, c=11}                                          },
      ["zehnMIN"]   ={State=false, {r=2, c=1}, {r=2, c=2}, {r=2, c=3 }, {r=2, c=4 }                                          },
      ["zwanzigMIN"]={State=false, {r=2, c=5}, {r=2, c=6}, {r=2, c=7 }, {r=2, c=8 }, {r=2, c=9 }, {r=2, c=10}, {r=2, c=11 }  },
      ["dreiMIN"]   ={State=false, {r=3, c=1}, {r=3, c=2}, {r=3, c=3 }, {r=3, c=4 }                                          },
      ["viertelMIN"]={State=false, {r=3, c=5}, {r=3, c=6}, {r=3, c=7 }, {r=3, c=8 }, {r=3, c=9 }, {r=3, c=10}, {r=3, c=11 }  },
      ["vor"]       ={State=false, {r=4, c=1}, {r=4, c=2}, {r=4, c=3 }                                                       },
      ["nach"]      ={State=false, {r=4, c=8}, {r=4, c=9}, {r=4, c=10}, {r=4, c=11}                                          },
      ["halb"]      ={State=false, {r=5, c=1}, {r=5, c=2}, {r=5, c=3 }, {r=5, c=4 }                                          },
      ["elfSTD"]    ={State=false, {r=5, c=6}, {r=5, c=7}, {r=5, c=8 }                                                       },
      ["funfSTD"]   ={State=false, {r=5, c=8}, {r=5, c=9}, {r=5, c=9 }, {r=5, c=10}                                          },
      ["einSTD"]    ={State=false, {r=6, c=1}, {r=6, c=2}, {r=6, c=3 }                                                       },
      ["einsSTD"]   ={State=false, {r=6, c=1}, {r=6, c=2}, {r=6, c=3 }, {r=6, c=4 }                                          },
      ["zweiSTD"]   ={State=false, {r=6, c=8}, {r=6, c=9}, {r=6, c=10}, {r=6, c=11}                                          },
      ["dreiSTD"]   ={State=false, {r=7, c=1}, {r=7, c=2}, {r=7, c=3 }, {r=7, c=4 }                                          },
      ["vierSTD"]   ={State=false, {r=7, c=8}, {r=7, c=9}, {r=7, c=10}, {r=7, c=11}                                          },
      ["sechsSTD"]  ={State=false, {r=8, c=1}, {r=8, c=2}, {r=8, c=3 }, {r=8, c=4 }, {r=8, c=5 }                             },
      ["achtSTD"]   ={State=false, {r=8, c=8}, {r=8, c=9}, {r=8, c=10}, {r=8, c=11}                                          },
      ["siebenSTD"] ={State=false, {r=9, c=1}, {r=9, c=2}, {r=9, c=3 }, {r=9, c=4 }, {r=9, c=5 }, {r=9, c=6 }                },
      ["zwolfSTD"]  ={State=false, {r=9, c=7}, {r=9, c=8}, {r=9, c=9 }, {r=9, c=10}, {r=9, c=11}                             },
      ["zehnSTD"]   ={State=false, {r=10,c=1}, {r=10,c=2}, {r=10,c=3 }, {r=10,c=4 }                                          },
      ["neunSTD"]   ={State=false, {r=10,c=4}, {r=10,c=5}, {r=10,c=6 }, {r=10,c=7 }                                          },
      ["uhr"]       ={State=false, {r=10,c=9}, {r=10,c=10}, {r=10,c=11}                                                      },
   }

   calcSizes()
end -- >>>

function love.keypressed(key, sc, isrepeat) -- <<<
   if key == "q" then
      love.event.quit()
   end
   if key == "f" then
      love.window.setFullscreen(not (love.window.getFullscreen()))
      calcSizes()
   end
end -- >>>

function love.resize(w,h) -- <<<
   calcSizes()
end -- >>>

function love.update(dt) -- <<<

   for k,v in pairs(TimeWords) do v.State = false end
   TimeWords.es.State  = true
   TimeWords.ist.State = true

   time = os.date('*t')
   Min = time.min
   Hour= time.hour

   if     (Min >= 58) or (Min <= 2)  then -- volle Stunde
      TimeWords.uhr.State = true
   elseif (Min >=  3) and (Min <= 7)  then -- 5  nach
      TimeWords.funfMIN.State = true
      TimeWords.nach.State    = true
   elseif (Min >=  8) and (Min <= 12) then -- 10 nach
      TimeWords.zehnMIN.State = true
      TimeWords.nach.State    = true
   elseif (Min >= 13) and (Min <= 17) then -- viertel nach          ODER viertel
      TimeWords.viertelMIN.State = true
      TimeWords.nach.State       = true
   elseif (Min >= 18) and (Min <= 22) then -- 20 nach           ODER 10 vor halb
      TimeWords.zwanzigMIN.State = true
      TimeWords.nach.State       = true
   elseif (Min >= 23) and (Min <= 27) then -- 5 vor halb
      TimeWords.funfMIN.State = true
      TimeWords.vor.State     = true
      TimeWords.halb.State    = true
   elseif (Min >= 28) and (Min <= 32) then -- halb
      TimeWords.halb.State    = true
   elseif (Min >= 33) and (Min <= 37) then -- 5 nach halb
      TimeWords.funfMIN.State = true
      TimeWords.nach.State     = true
      TimeWords.halb.State     = true
   elseif (Min >= 38) and (Min <= 42) then -- 20 vor           ODER 10 nach halb
      TimeWords.zwanzigMIN.State = true
      TimeWords.vor.State        = true
   elseif (Min >= 43) and (Min <= 47) then -- viertel vor       ODER dreiviertel
      TimeWords.viertelMIN.State = true
      TimeWords.vor.State        = true
   elseif (Min >= 48) and (Min <= 52) then -- 10 vor
      TimeWords.zehnMIN.State = true
      TimeWords.vor.State     = true
   elseif (Min >= 53) and (Min <= 57) then -- 5 vor
      TimeWords.funfMIN.State = true
      TimeWords.vor.State     = true
   end

   if (Min >= 23) and (Min <= 57) then
      Hour = Hour + 1
   end

   if Hour >= 24 then
      Hour = 0
   end

   if     (Hour == 0 ) or (Hour == 12) then
      TimeWords.zwolfSTD.State = true
   elseif (Hour == 1 ) or (Hour == 13) then
      if (Min >= 58) or (Min <= 2) then
         TimeWords.einSTD.State = true
      else
         TimeWords.einsSTD.State = true
      end
   elseif (Hour == 2 ) or (Hour == 14) then
      TimeWords.zweiSTD.State = true
   elseif (Hour == 3 ) or (Hour == 15) then
      TimeWords.dreiSTD.State = true
   elseif (Hour == 4 ) or (Hour == 16) then
      TimeWords.vierSTD.State = true
   elseif (Hour == 5 ) or (Hour == 17) then
      TimeWords.funfSTD.State = true
   elseif (Hour == 6 ) or (Hour == 18) then
      TimeWords.sechsSTD.State = true
   elseif (Hour == 7 ) or (Hour == 19) then
      TimeWords.siebenSTD.State = true
   elseif (Hour == 8 ) or (Hour == 20) then
      TimeWords.achtSTD.State = true
   elseif (Hour == 9 ) or (Hour == 21) then
      TimeWords.neunSTD.State = true
   elseif (Hour == 10) or (Hour == 22) then
      TimeWords.zehnSTD.State = true
   elseif (Hour == 11) or (Hour == 23) then
      TimeWords.elfSTD.State = true
   end
end -- >>>

function love.draw() -- <<<

   local g = love.graphics

   g.setBackgroundColor(BackgroundColor)

   g.setColor(InactiveColor)
   for rowi,rowt in ipairs(Data) do
      for coli, letter in ipairs(rowt) do
         drawLetter(letter)
      end
   end

   g.setColor(ActiveColor)
   for k,w in pairs(TimeWords) do
      if w.State then
         for i,v in ipairs(w) do
            drawLetter(Data[v.r][v.c])
         end
      end
   end
end -- >>>


-- vim: fmr=<<<,>>> fdm=marker
