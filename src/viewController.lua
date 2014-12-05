-- The view controller allows to handle the transition between the view.
viewController = {}

--- Creates a new view controller
-- @return viewController
function viewController:new()
  newObj = {
    views = {},
    currentViewIdentifier = nil
  }
  self.__index = self
  return setmetatable(newObj, self)
end

--- Adds a view to the view controller. Each view is associted with an identifier.
-- @param identifier Name of the view
-- @param view The view module which should be added to the identifier
function viewController:addView(identifier, view)
  if identifier and not self.views[identifier] then
    if view then
      self.views[identifier] = view
    else
      error("Cannot add view \"" .. identifier .. "\", view is empty.")
    end
  else
    error("Cannot add view, identifier is missing or view with this identifier already exists.")
  end
end

--- Present a view to the screen. Each view should have a viewDidLoad and drawView method.
  -- viewDidLoad is called when the view is loaded
  -- This should allow to redraw the view as it was before presenting another view.
--@param identifier Name of the view
function viewController:presentView(identifier)
  if identifier and self.views[identifier] then
    if self.currentViewIdentifier and self.views[self.currentViewIdentifier].viewDidEnd then
      self.views[self.currentViewIdentifier]:viewDidEnd()
    end

    self.currentViewIdentifier = identifier
    self.views[identifier]:viewDidLoad()
  else
    error("Cannot present view, identifier is missing or view not found.")
  end
end

--- Removes the selected view
-- @param identifier Name of the view
function viewController:removeView(identifier)
  if identifier and self.views[identifier] then
    if self.views[identifier].freeView then
      self.views[identifier]:freeView()
    else
      print("Warn: this view, \"" .. identifier .. "\" has been deleted but their was no freeView() method.")
    end
    self.views[identifier] = nil
  else
    error("No identifier provided or view not found.")
  end
end

--- Returns the view specified by identifier.
-- @param identifier Name of the view
-- @return view The specified view
function viewController:getView(identifier)
  if identifier and self.views[identifier] then
    return self.views[identifier]
  else
    error("No identifier provided or view not found.")
  end
end

--- Returns both the current view identifier and the current view object.
-- @return currentViewIdentifier The name of the view
-- @return view The specified view
function viewController:getcurrentViewIdentifier()
  return self.currentViewIdentifier, self.views[self.currentViewIdentifier]
end

--- This allows to have one onKey function per view. Each view has it's own onKey function and the 
  -- right onKey function is exectued depending on the current view that is shown on the screen.
-- @param key keyboard input
-- @param state state of the key, down = pressed, up = released
function viewController:onKey(key, state)
  if self.currentViewIdentifier then
    if self.views[self.currentViewIdentifier].onKey then
      self.views[self.currentViewIdentifier]:onKey(key, state)
    else
      print("onKey method missing in view with identifier \"" .. self.currentViewIdentifier .. "\".")
    end
  end
end
