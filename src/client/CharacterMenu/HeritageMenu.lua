local _menu = nil
local _heritageWindow = nil
local _values = {
  dad = 1,
  mom = 1,
  faceMix = 0.5,
  skinMix = 0.5,
  skinTone = 0,
}


local function addParentItem(name, options, description)
  local optionNames = {}
  for i = 1, #options do
    optionNames[i] = options[i].name
  end

  local menuItem = NativeUI.CreateListItem(name, optionNames, 0, description)
  _menu:AddItem(menuItem)
end

local function addSliderItem(name, options, description)
  local menuItem = NativeUI.CreateSliderItem(name, options, 50, description, true)
  _menu:AddItem(menuItem)
end

local function addHeritageWindow(mom, dad)
  _heritageWindow = NativeUI.CreateHeritageWindow()
  _menu:AddWindow(_heritageWindow)
end

local function updateHeritageWindow(parent, index)
  local father
  local mother

  _values[parent] = index;

  father = HERITAGE_FATHERS[_values.dad]
  mother = HERITAGE_MOTHERS[_values.mom]

  _heritageWindow:Index(mother.textureId, father.textureId)

  -- TODO: Emit client event and have a ped controller class update the head blend.
  SetPedHeadBlendData(
    PlayerPedId(),
    mother.faceId,
    father.faceId,
    nil, -- third face id
    mother.skinId, -- first skin id (mother skin tone?)
    father.skinId, -- second skin id (father skin tone?)
    nil, -- third skin id
    _values.faceMix, -- shape mix (face)
    _values.skinMix, -- skin mix,
    nil, -- third mix,
    false  -- not a parent ped
  )
end

local function updateMixValue(mixKey, value)
  local father = HERITAGE_FATHERS[_values.dad]
  local mother = HERITAGE_MOTHERS[_values.mom]

  _values[mixKey] = value / 100

  -- TODO: Emit client event for ped controller
  SetPedHeadBlendData(
    PlayerPedId(),
    mother.faceId,
    father.faceId,
    nil,
    mother.skinId,
    father.skinId,
    nil,
    _values.faceMix,
    _values.skinMix,
    nil,
    false
  )
end

function CreateHeritageMenu(menuPool, parentMenu)
  local pct = {}
  for i = 1, 100 do
    pct[i] = i
  end

  _menu = menuPool:AddSubMenu(parentMenu, 'Heritage', 'Select to choose your parents.')

  addHeritageWindow()
  addParentItem('Mom', HERITAGE_MOTHERS, 'Select your Mom.')
  addParentItem('Dad', HERITAGE_FATHERS, 'Select your Dad.')
  addSliderItem('Resemblance', pct, 'Select if your features are influenced more by your Mother or your Father.')
  addSliderItem('Skin Tone', pct, 'Select if your skin tone is influenced more by your Mother or your Father.')

  _menu.OnListChange = function (sender, item, index)
    updateHeritageWindow(item:Text():lower(), index)
  end
  _menu.OnSliderChange = function (sender, item, index)
    local itemKey = (item:Text():lower() == 'resemblance') and 'faceMix' or 'skinMix'
    updateMixValue(itemKey, index)
  end

  return _menu
end
