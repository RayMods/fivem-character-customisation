
local FATHERS = {
  'Adrian',
   'Alex',
   'Andrew',
   'Angel',
   'Anthony',
   'Benjamin',
   'Claude',
   'Daniel',
   'Diego',
   'Ethan',
   'Evan',
   'Gabriel',
   'Isaac',
   'John',
   'Joshua',
   'Juan',
   'Kevin',
   'Louis',
   'Michael',
   'Niko',
   'Samual',
   'Santiago',
   'Vincent',
}
local MOTHERS = {
  'Amelia',
  'Ashely',
  'Audrey',
  'Ava',
  'Briana',
  'Camila',
  'Charlotte',
  'Elizabeth',
  'Emma',
  'Evelyn',
  'Giselle',
  'Grace',
  'Hannah',
  'Isabella',
  'Jasmine',
  'Misty',
  'Natalie',
  'Nicole',
  'Olivia',
  'Sophie',
  'Violet',
  'Zoe',
}

local _menu = nil
local HeritageMenu = {}

function CreateHeritageMenu(menuPool, parentMenu)
  local pct = {}
  for i = 1, 100 do
    pct[i] = i
  end

  _menu = menuPool:AddSubMenu(parentMenu, 'Heritage', 'Select to choose your parents.')

  addParentItem('Dad', FATHERS, 'Select your Dad.')
  addParentItem('Mom', MOTHERS, 'Select your Mom.')
  addSliderItem('Resemblance', pct, 'Select if your features are influenced more by your Mother or your Father.')
  addSliderItem('Skin Tone', pct, 'Select if your skin tone is influenced more by your Mother or your Father.')

  return _menu
end

function addParentItem(name, options, description)
  local menuItem = NativeUI.CreateListItem(name, options, 1, description)
  _menu:AddItem(menuItem)
end

function addSliderItem(name, options, description)
  local menuItem = NativeUI.CreateSliderItem(name, options, 50, description, true)
  _menu:AddItem(menuItem)
end
