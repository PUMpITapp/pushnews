XML = {}
XML.__index = XML

--- Finding the element that is matching the tagname
-- @param el An element
-- @param name Tagname of the element we are searching for
-- @return the matching elements
function XML.getByName(el, name)
	elements = {}

	for i, kid in ipairs (el.kids) do
		if kid.name == name then
			table.insert(elements, kid)
		end
	end

	return elements

end

--- Returns the element text
-- @param el An element
-- @return The element text 
function XML.elementText(el)
  local pieces = {}
  for _,n in ipairs(el.kids) do
    if n.type=='element' then pieces[#pieces+1] = elementText(n)
    elseif n.type=='text' then pieces[#pieces+1] = n.value
    end
  end
  return table.concat(pieces)
end
