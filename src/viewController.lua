-- The view controller allows to handle the transition between the view.

viewController = {}

function viewController:new()
	newObj = {
		views = {},
		currentViewIdentifier = nil
	}
  self.__index = self
  return setmetatable(newObj, self)
end

-- Adds a view to the view controller. Each view is associted with an identifier.
function viewController:addView(identifier, view)
	if identifier and not self.views[identifier] then 
		if view then
			self.views[identifier] = { view=view, loaded=false }
		else
			error("Cannot add view \"" .. identifier .. "\", view is empty.")
		end
	else 
		error("Cannot add view, identifier is missing or view with this identifier already exists.")
	end
end

-- Present a view to the screen. Each view should have a viewDidLoad and drawView method.
-- ! viewDidLoad is called the first time the view is loaded.
-- ! drawView is called when the view is already loaded in the memory,
--   This should allow to redraw the view as it was before presenting another view.
function viewController:presentView(identifier)
	if identifier and self.views[identifier] then
		if self.currentViewIdentifier and self.views[self.currentViewIdentifier].view.viewDidEnd then
			self.views[self.currentViewIdentifier].view:viewDidEnd()
		end

		self.currentViewIdentifier = identifier
		
		if self.views[identifier].loaded == true then
			self.views[identifier].view:drawView()
		else
			self.views[identifier].loaded = true
			self.views[identifier].view:viewDidLoad()
		end
	else
		error("Cannot present view, identifier is missing or view not found.")
	end
end


function viewController:removeView(identifier)
	if identifier and self.views[identifier] then
		if self.views[identifier].view.freeView then
			self.views[identifier].view:freeView()
		else
			print("Warn: this view, \"" .. identifier .. "\" has been deleted but their was no freeView() method.")
		end
		self.views[identifier] = nil
	else
		error("No identifier provided or view not found.")
	end
end

-- Returns the view specified by identifier.
function viewController:getView(identifier)
	if identifier and self.views[identifier] then
		return self.views[identifier]
	else
		error("No identifier provided or view not found.")
	end
end

-- Returns both the current view identifier and the current view object.
function viewController:getcurrentViewIdentifier()
	return self.currentViewIdentifier, self.views[self.currentViewIdentifier]
end

-- This allows to have one onKey function per view. Each view has it's own onKey function and the 
-- right onKey function is exectued depending on the current view that is shown on the screen.
function viewController:onKey(key, state)
	if self.currentViewIdentifier then 
		if self.views[self.currentViewIdentifier].view.onKey then
			self.views[self.currentViewIdentifier].view:onKey(key, state)
		else
			print("onKey method missing in view with identifier \"" .. self.currentViewIdentifier .. "\".")
		end
	end
end
