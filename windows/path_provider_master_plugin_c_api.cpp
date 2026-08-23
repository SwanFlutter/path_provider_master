#include "include/path_provider_master/path_provider_master_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "path_provider_master_plugin.h"

void PathProviderMasterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  path_provider_master::PathProviderMasterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
