-- User Interface stuff using SUIT lib > 
local suit = require('libs.suit')
local cfg = require('code.simconfig')
local apiG = love.graphics

local ui = {}

ui.cnormal = suit.theme.color.normal
ui.selectedColor =  { bg={55, 113, 140}, fg={255,255,255} } 
ui.cc = ui.cnormal
ui.consumedClick = false

ui.leftPanelWidth = 110
ui.leftPanelColor = { 82, 82, 82}

function ui.onRadioCellsChanged( NewIdx )
  print ( ui.radioBtns_cells.selectedCaption )
end

ui.radioBtns_cells = {
  {caption = 'block'},
  {caption = 'grass'},
  {caption = 'cave'},
  {caption = 'food'},
  {caption = 'ground'},
  bWidth = 85,
  bHeight = 30,
  selectedIdx = 1,
  selectedCaption = 'block',
  onChanged = ui.onRadioCellsChanged
}
  
function ui.draw()
  apiG.setColor( ui.leftPanelColor )
  apiG.rectangle("fill", 0,0, ui.leftPanelWidth, apiG.getHeight() )
  apiG.setColor(120,180,100)
  apiG.print(tostring(love.timer.getFPS( ))..' FPS', 10, 10)  
  apiG.print('F# '..cfg.simFrameNumber, 10, 25)     
  --apiG.print("DebugCounter 1 = "..cfg.debugCounters[1], 10, 25)
  --apiG.print("DebugCounter 2 = "..cfg.debugCounters[2], 10, 40)
  suit.draw()
end

function ui.suitRadio( rbtns, x, y )
  local grow
  x = x or 10
  y = y or 10

  --ui.consumedClick = false
  suit.layout:reset(x, y) 
  suit.layout:padding(10,2)     
  for i=1,#rbtns do 
    if rbtns.selectedIdx  then
      if rbtns.selectedIdx == i then
        ui.cc = ui.selectedColor
        grow = 25
      else
        ui.cc = ui.cnormal
        grow = 0
      end
    end
    rbtns[i].ret = suit.Button(rbtns[i].caption, { color = { normal = ui.cc }} , suit.layout:row( rbtns.bWidth + grow, rbtns.bHeight) )  
    if rbtns[i].ret.hit then  
      --ui.consumedClick = true
      rbtns.selectedIdx = i
      if rbtns.onChanged then
        rbtns.selectedCaption = rbtns[i].caption
        rbtns.onChanged(i)
      end
    end
  end 
end

return ui