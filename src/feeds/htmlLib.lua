HTML = {}
HTML.__index = HTML

function HTML.findTag(elements, tagname)
  if elements == nil then
    return nil
  end

  local t = {}

  for i, e in pairs(elements) do
    if e._tag == tagname then
      table.insert(t, e)
    elseif e ~= nil and type(e) == 'table' then

      local other = HTML.findTag(e, tagname)

      for k, o in ipairs(other) do
        table.insert (t, o)
      end
    end
  end

  return t
end

function HTML.findId(elements, id)
  local t = {}
  for i, e in pairs(elements) do
    if e._attr and e._attr.id then
      if e._attr.id == id then
        table.insert(t, e)
      end
    end

    if e ~= nil and type(e) == 'table' then

      local other = HTML.findId(e, id)

      for k, o in ipairs(other) do
        table.insert (t, o)
      end
    end
  end

  return t
end

function HTML.findClass(elements, className)

  local t = {}
  for i, e in pairs(elements) do
    if e._attr and e._attr.class then
      --multiple classes can be in the class atribute
      --so we have to split it using space separator
      --then look each token

      local found = false
      for token in string.gmatch(e._attr.class, "[^%s]+") do
        if token == className then
          found = true
        end
      end

      if found or e._attr.class == className then
        table.insert(t, e)
      end
    end

    if e ~= nil and type(e) == 'table' then

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