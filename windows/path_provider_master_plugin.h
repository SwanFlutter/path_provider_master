#ifndef FLUTTER_PLUGIN_PATH_PROVIDER_MASTER_PLUGIN_H_
#define FLUTTER_PLUGIN_PATH_PROVIDER_MASTER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace path_provider_master {

class PathProviderMasterPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  PathProviderMasterPlugin();

  virtual ~PathProviderMasterPlugin();

  // Disallow copy and assign.
  PathProviderMasterPlugin(const PathProviderMasterPlugin&) = delete;
  PathProviderMasterPlugin& operator=(const PathProviderMasterPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
  
  // Helper methods
  std::string GetKnownFolderPath(const GUID& folder_id);
  std::string GetTemporaryPath();
  std::string GetAppDataPath();
};

}  // namespace path_provider_master

#endif  // FLUTTER_PLUGIN_PATH_PROVIDER_MASTER_PLUGIN_H_
