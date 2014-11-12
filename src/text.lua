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
      local c = text:sub(i,i) -- Get the character
      for j = 1,#fonts[font].info.chars do -- For each character in the font
        local fc = fonts[font].info.chars[j] -- Get the character information
        if fc.char == c then
          if x + fc.width > sx + w then -- If the text is gonna be out the surface, popup a new line
            x = sx
            y = y + fonts[font].info.height
          end
          dx = x + fc.ox -- dx is the x positon of the character, some characters need offset
          dy = y + fonts[font].info.metrics.ascender - fc.oy -- dy is the y position of the character, some characters need offset
          surface:copyfrom(fonts[font].sprite, {x=fc.x, y=fc.y, w=fc.w, h=fc.h}, {x=dx, y=dy})
          x = x + fc.width -- add offset for next character
          break
        end
      end
    end
  else
    print("Err: font not found.")
  end
end

-- When this module is required, load the available fonts.
TextModule.loadFonts()

return TextModule
