local TextModule = {}

local fontDir = "fonts/"
local registeredFonts = { "open_sans_regular_10_white", "open_sans_regular_10", "open_sans_regular_8_red", "open_sans_regular_8_black" }

local fonts = {}

--- Load the fonts (information file and spritesheet) into the fonts table according to the registeredFonts table.
function TextModule.loadFonts()
  for i,font in pairs(registeredFonts) do
    local fontInfo = require(fontDir .. font)
    local fontSprite = gfx.loadpng(fontDir .. fontInfo.file)
    fontSprite:premultiply()
    fonts[font] = { info = fontInfo, sprite = fontSprite }
  end
end

--- Print a text on a surface. Font should be a string specified in registeredFonts.
-- @param #string surface The surface on which we want to print the text.   
-- @param #string font The font we want to use when printing
-- @param #string text The text to be printed
-- @param #number x Start position for printing on the surface x-axis
-- @param #number y Start position for printing on the surface y-axis
-- @param #number w The width to use for printing the text
-- @param #number h The height to use for printing the text
-- @return #number where the FINISH THIS ONE!
-- @return #number Position...
function TextModule.print(surface, font, text, x, y, w, h)
  local last_i = 0
  local surface_w = 0
  local surface_h = 0
  local sy = y -- Start y position on the surface
  local sx = x -- Start x position on the surface

  if fonts[font] then
    if surface == nil then
      surface_w = w
      surface_h = h
    else 
      surface_w = surface:get_width()
      surface_h = surface:get_height()
    end

    if w == nil or w > surface_w then
      w = surface_w
    end
    
    if h == nil or h > surface_h then
      h = surface_h
    end

    for i = 1,#text do -- For each character in the text
      local shouldBePrinted = true
      local c = string.sub(text,i,i) -- Get the character

      if c == ' ' then
        local remaining_length = (sx + w) - x
        local needed_length = TextModule.getCharInfo(font, ' ').width

        for j = i+1,#text do
          local cc = string.sub(text,j,j)

          if cc == ' ' then
            break
          end

          tchar = TextModule.getCharInfo(font, cc)

          if tchar ~= nil then
            needed_length = needed_length + tchar.width
          end
        end

        if remaining_length < needed_length then
          x = sx
          y = y + fonts[font].info.height
          shouldBePrinted = false
        end
      end

      if shouldBePrinted == true then
        char = TextModule.getCharInfo(font, c)

        if char ~= nil then
          if x + char.width > sx + w then -- If the text is gonna be out the surface, popup a new line
            x = sx
            y = y + fonts[font].info.height
          end

          if y > sy + h then
            return i, x
          end

          if char.w > 0 and char.h > 0 and surface ~= nil then
            dx = x + char.ox -- dx is the x positon of the character, some characters need offset
            dy = y + fonts[font].info.metrics.ascender - char.oy -- dy is the y position of the character, some characters need offset
            surface:copyfrom(fonts[font].sprite, {x=char.x, y=char.y, w=char.w, h=char.h}, {x=dx, y=dy}, true)
          end

          x = x + char.width -- add offset for next character
        end
      end

      last_i = i
    end

    return last_i, x
  else
    print("Err: font not found.")
  end
end

function TextModule.getCharInfo(font, char)
  return fonts[font].info.chars[char]
  --for i = 1,#fonts[font].info.chars do
    --if fonts[font].info.chars[i].char == char then
      --return fonts[font].info.chars[i]
    --end
  --end
  --return nil
end

-- When this module is required, load the available fonts.
TextModule.loadFonts()

return TextModule
