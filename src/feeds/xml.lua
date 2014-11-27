XML = {}
XML.__index = XML

function XML.getByName(el, name)
	elements = {}

	for i, kid in ipairs (el.kids) do
		if kid.name == name then
			table.insert(elements, kid)
		end
	end

	return elements

end

function XML.elementText(el)
  local pieces = {}
  for _,n in ipairs(el.kids) do
    if n.type=='element' then pieces[#pieces+1] = elementText(n)
    elseif n.type=='text' then pieces[#pieces+1] = n.value
    end
  end
  return table.concat(pieces)
end
