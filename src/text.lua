local TextModule = {}

local fontDir = "fonts/"
local registeredFonts = { "arial_regular_12", "lato_large", "lato_medium", "lato_small" }

local fonts = {}

-- Load the fonts (information file and spritesheet) into the fonts table according to the registeredFonts table.
function TextModule.loadFonts()
  for i,font in pairs(registeredFonts) do
    local fontInfo = require(fontDir .. font)
    local fontSprite = gfx.loadpng(fontDir .. fontInfo.file)
    fonts[font] = { info = fontInfo, sprite = fontSprite }
  end
end

-- Print a text on a surface. Font should be a string specified in registeredFonts.
function TextModule.print(surface, font, text, x, y, w, h)
  if fonts[font] then
    local sx = x -- Start x position on the surface
    local surface_w = surface:get_width()
    local surface_h = surface:get_height()

    if w == nil or w > surface_w then
      w = surface_w
    end
    if h == nil or h > surface_h then
      h = surface_h
    end

    for i = 1,#text do -- For each character in the text
      local shouldBePrinted = true
      local c = text:sub(i,i) -- Get the character
    
      if c == ' ' then
        local remaining_length = w - x
        local needed_length = 0
        
        for j = i+1,#text do
          local cc = text:sub(j,j)
          if cc == ' ' then
            break
          end
          tchar = TextModule.getCharInfo(font, cc)
          needed_length = needed_length + tchar.width
        end

        if remaining_length < needed_length then
          x = sx
          y = y + fonts[font].info.height
          shouldBePrinted = false
        end
      end
      
      if shouldBePrinted == true then
        char = TextModule.getCharInfo(font, c)
        if x + char.width > sx + w then -- If the text is gonna be out the surface, popup a new line
          x = sx
          y = y + fonts[font].info.height
        end
        dx = x + char.ox -- dx is the x positon of the character, some characters need offset
        dy = y + fonts[font].info.metrics.ascender - char.oy -- dy is the y position of the character, some characters need offset
        surface:copyfrom(fonts[font].sprite, {x=char.x, y=char.y, w=char.w, h=char.h}, {x=dx, y=dy})
        x = x + char.width -- add offset for next character

        last_i = i

        if y > surface_h then
          return i
        end

      end
    end
  else
    print("Err: font not found.")
  end
end

function TextModule.getCharInfo(font, char)
  for i = 1,#fonts[font].info.chars do 
    if fonts[font].info.chars[i].char == char then
      return fonts[font].info.chars[i]
    end
  end
  return nil
end

-- When this module is required, load the available fonts.
TextModule.loadFonts()

return TextModule
