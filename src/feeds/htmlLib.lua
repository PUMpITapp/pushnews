HTML = {}
HTML.__index = HTML

function HTML.findClass(elements, className)

  local t = {}
  for i, e in pairs(elements) do
    if e._attr and e._attr.class and e._attr.class == className then
      table.insert(t, e)
    elseif e ~= nil and type(e) == 'table' then

      local other = HTML.findClass(e, className)

      for k, o in ipairs(other) do
        table.insert (t, o)
      end
    end
  end

  return t

end

function HTML.getText(paragraphs)
  local str = ''

  if paragraphs == nil then
    return nil
  end

  for i, p in ipairs(paragraphs) do
    if type(p) == 'table' then
      str = str .. HTML.getText(p) .. ' '
    elseif p ~= '' then
      str = str .. p
    end
  end

  return str

end