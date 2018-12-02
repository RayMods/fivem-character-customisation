resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
  -- Vendor Files
  '@NativeUI/NativeUI.lua',

  -- Constant Values
  './src/client/CharacterMenu/constants/parents.lua',

  -- Controllers
  './src/client/controllers/pedController.lua',

  -- Menu Files
  './src/client/CharacterMenu/HeritageMenu.lua',
  './src/client/CharacterMenu/CharacterMenu.lua',
  './src/client/MainMenu/MainMenu.lua',
  './src/client/menus.lua',

  './src/main.lua',
}

dependencies {
  'NativeUI'
}
