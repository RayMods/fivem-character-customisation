resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
  -- Vendor Files
  '@NativeUI/NativeUI.lua',

  -- Menu Files
  './src/client/MainMenu/MainMenu.lua',
  './src/client/menus.lua',

  -- './src/client/menus/constants/parents.lua',
  -- './src/client/menus/HeritageMenu.lua',
  -- './src/client/menus/MainMenu.lua',
  -- './src/client/menus/main.lua',

  './src/main.lua',
}

dependencies {
  'NativeUI'
}
