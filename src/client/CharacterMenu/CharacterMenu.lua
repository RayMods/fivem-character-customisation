local _menu = NativeUI.CreateMenu('Character Creator')
local _sexSelector = NativeUI.CreateListItem('Sex', { 'Female', 'Male' }, 2)
local _values = {
  sex = 2,
}

local function handleChangeItem(send, item, index)
  if (item == _sexSelector) then
    TriggerEvent('cc_initPlayerModel', index)
  end
end

_menu:AddItem(_sexSelector)
_menu.OnListChange = handleChangeItem

function RegisterCharacterMenu(menuPool)
  menuPool:Add(_menu)
  CreateHeritageMenu(menuPool, _menu)

  menuPool:RefreshIndex()

  return _menu
end
