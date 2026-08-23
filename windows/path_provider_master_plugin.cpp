#include "path_provider_master_plugin.h"

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <windows.h>
#include <shlobj.h>
#include <memory>
#include <sstream>

namespace path_provider_master {

// static
void PathProviderMasterPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "path_provider_master",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<PathProviderMasterPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

PathProviderMasterPlugin::PathProviderMasterPlugin() {}

PathProviderMasterPlugin::~PathProviderMasterPlugin() {}

std::string PathProviderMasterPlugin::GetKnownFolderPath(const GUID& folder_id) {
  PWSTR path = nullptr;
  HRESULT hr = SHGetKnownFolderPath(folder_id, 0, nullptr, &path);
  
  if (SUCCEEDED(hr)) {
    int size = WideCharToMultiByte(CP_UTF8, 0, path, -1, nullptr, 0, nullptr, nullptr);
    std::string result(size - 1, 0);
    WideCharToMultiByte(CP_UTF8, 0, path, -1, &result[0], size, nullptr, nullptr);
    CoTaskMemFree(path);
    return result;
  }
  
  return "";
}

std::string PathProviderMasterPlugin::GetTemporaryPath() {
  wchar_t temp_path[MAX_PATH];
  DWORD result = GetTempPathW(MAX_PATH, temp_path);
  
  if (result > 0) {
    int size = WideCharToMultiByte(CP_UTF8, 0, temp_path, -1, nullptr, 0, nullptr, nullptr);
    std::string path(size - 1, 0);
    WideCharToMultiByte(CP_UTF8, 0, temp_path, -1, &path[0], size, nullptr, nullptr);
    
    // حذف backslash انتهایی
    if (!path.empty() && path.back() == '\\') {
      path.pop_back();
    }
    
    return path;
  }
  
  return "";
}

std::string PathProviderMasterPlugin::GetAppDataPath() {
  return GetKnownFolderPath(FOLDERID_RoamingAppData);
}

void PathProviderMasterPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  
  const std::string& method = method_call.method_name();
  
  if (method == "getTemporaryDirectory") {
    std::string path = GetTemporaryPath();
    if (!path.empty()) {
      result->Success(flutter::EncodableValue(path));
    } else {
      result->Error("UNAVAILABLE", "Temporary directory not available");
    }
  }
  else if (method == "getApplicationSupportDirectory") {
    std::string path = GetAppDataPath();
    if (!path.empty()) {
      result->Success(flutter::EncodableValue(path));
    } else {
      result->Error("UNAVAILABLE", "Application support directory not available");
    }
  }
  else if (method == "getLibraryDirectory") {
    // Windows Library directory ندارد
    result->Success(flutter::EncodableValue());
  }
  else if (method == "getApplicationDocumentsDirectory") {
    std::string path = GetKnownFolderPath(FOLDERID_Documents);
    if (!path.empty()) {
      result->Success(flutter::EncodableValue(path));
    } else {
      result->Error("UNAVAILABLE", "Documents directory not available");
    }
  }
  else if (method == "getExternalStorageDirectory") {
    // Windows external storage ندارد
    result->Success(flutter::EncodableValue());
  }
  else if (method == "getExternalCacheDirectories") {
    result->Success(flutter::EncodableValue());
  }
  else if (method == "getExternalStorageDirectories") {
    result->Success(flutter::EncodableValue());
  }
  else if (method == "getDownloadsDirectory") {
    std::string path = GetKnownFolderPath(FOLDERID_Downloads);
    if (!path.empty()) {
      result->Success(flutter::EncodableValue(path));
    } else {
      result->Error("UNAVAILABLE", "Downloads directory not available");
    }
  }
  else if (method == "getPublicPicturesDirectory") {
    std::string path = GetKnownFolderPath(FOLDERID_PublicPictures);
    if (!path.empty()) {
      result->Success(flutter::EncodableValue(path));
    } else {
      result->Error("UNAVAILABLE", "Public pictures directory not available");
    }
  }
  else if (method == "getPublicVideosDirectory") {
    std::string path = GetKnownFolderPath(FOLDERID_PublicVideos);
    if (!path.empty()) {
      result->Success(flutter::EncodableValue(path));
    } else {
      result->Error("UNAVAILABLE", "Public videos directory not available");
    }
  }
  else if (method == "getPublicMusicDirectory") {
    std::string path = GetKnownFolderPath(FOLDERID_PublicMusic);
    if (!path.empty()) {
      result->Success(flutter::EncodableValue(path));
    } else {
      result->Error("UNAVAILABLE", "Public music directory not available");
    }
  }
  else if (method == "getPublicDownloadsDirectory") {
    std::string path = GetKnownFolderPath(FOLDERID_PublicDownloads);
    if (!path.empty()) {
      result->Success(flutter::EncodableValue(path));
    } else {
      result->Error("UNAVAILABLE", "Public downloads directory not available");
    }
  }
  else if (method == "getPublicDocumentsDirectory") {
    std::string path = GetKnownFolderPath(FOLDERID_PublicDocuments);
    if (!path.empty()) {
      result->Success(flutter::EncodableValue(path));
    } else {
      result->Error("UNAVAILABLE", "Public documents directory not available");
    }
  }
  else if (method == "getPublicDCIMDirectory") {
    // Windows DCIM directory ندارد
    result->Success(flutter::EncodableValue());
  }
  else {
    result->NotImplemented();
  }
}

}  // namespace path_provider_master
