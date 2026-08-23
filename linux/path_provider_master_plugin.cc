#include "include/path_provider_master/path_provider_master_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>
#include <cstring>
#include <unistd.h>
#include <pwd.h>

#define PATH_PROVIDER_MASTER_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), path_provider_master_plugin_get_type(), \
                               PathProviderMasterPlugin))

struct _PathProviderMasterPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(PathProviderMasterPlugin, path_provider_master_plugin, g_object_get_type())

// دریافت home directory
static gchar* get_home_directory() {
  const char* home = g_get_home_dir();
  return g_strdup(home);
}

// دریافت XDG directory
static gchar* get_xdg_directory(const gchar* env_var, const gchar* fallback) {
  const char* dir = g_getenv(env_var);
  if (dir != nullptr && dir[0] != '\0') {
    return g_strdup(dir);
  }
  
  gchar* home = get_home_directory();
  gchar* result = g_build_filename(home, fallback, nullptr);
  g_free(home);
  return result;
}

// Handle method call
static void path_provider_master_plugin_handle_method_call(
    PathProviderMasterPlugin* self,
    FlMethodCall* method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar* method = fl_method_call_get_name(method_call);

  if (strcmp(method, "getTemporaryDirectory") == 0) {
    const gchar* temp_dir = g_get_tmp_dir();
    g_autoptr(FlValue) result = fl_value_new_string(temp_dir);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
  } 
  else if (strcmp(method, "getApplicationSupportDirectory") == 0) {
    gchar* data_home = get_xdg_directory("XDG_DATA_HOME", ".local/share");
    g_autoptr(FlValue) result = fl_value_new_string(data_home);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
    g_free(data_home);
  }
  else if (strcmp(method, "getLibraryDirectory") == 0) {
    // Linux Library directory ندارد
    g_autoptr(FlValue) result = fl_value_new_null();
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
  }
  else if (strcmp(method, "getApplicationDocumentsDirectory") == 0) {
    gchar* documents = get_xdg_directory("XDG_DOCUMENTS_DIR", "Documents");
    g_autoptr(FlValue) result = fl_value_new_string(documents);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
    g_free(documents);
  }
  else if (strcmp(method, "getExternalStorageDirectory") == 0) {
    // Linux external storage ندارد
    g_autoptr(FlValue) result = fl_value_new_null();
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
  }
  else if (strcmp(method, "getExternalCacheDirectories") == 0) {
    g_autoptr(FlValue) result = fl_value_new_null();
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
  }
  else if (strcmp(method, "getExternalStorageDirectories") == 0) {
    g_autoptr(FlValue) result = fl_value_new_null();
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
  }
  else if (strcmp(method, "getDownloadsDirectory") == 0) {
    gchar* downloads = get_xdg_directory("XDG_DOWNLOAD_DIR", "Downloads");
    g_autoptr(FlValue) result = fl_value_new_string(downloads);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
    g_free(downloads);
  }
  else if (strcmp(method, "getPublicPicturesDirectory") == 0) {
    gchar* pictures = get_xdg_directory("XDG_PICTURES_DIR", "Pictures");
    g_autoptr(FlValue) result = fl_value_new_string(pictures);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
    g_free(pictures);
  }
  else if (strcmp(method, "getPublicVideosDirectory") == 0) {
    gchar* videos = get_xdg_directory("XDG_VIDEOS_DIR", "Videos");
    g_autoptr(FlValue) result = fl_value_new_string(videos);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
    g_free(videos);
  }
  else if (strcmp(method, "getPublicMusicDirectory") == 0) {
    gchar* music = get_xdg_directory("XDG_MUSIC_DIR", "Music");
    g_autoptr(FlValue) result = fl_value_new_string(music);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
    g_free(music);
  }
  else if (strcmp(method, "getPublicDownloadsDirectory") == 0) {
    gchar* downloads = get_xdg_directory("XDG_DOWNLOAD_DIR", "Downloads");
    g_autoptr(FlValue) result = fl_value_new_string(downloads);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
    g_free(downloads);
  }
  else if (strcmp(method, "getPublicDocumentsDirectory") == 0) {
    gchar* documents = get_xdg_directory("XDG_DOCUMENTS_DIR", "Documents");
    g_autoptr(FlValue) result = fl_value_new_string(documents);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
    g_free(documents);
  }
  else if (strcmp(method, "getPublicDCIMDirectory") == 0) {
    // Linux DCIM directory ندارد
    g_autoptr(FlValue) result = fl_value_new_null();
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
  }
  else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  fl_method_call_respond(method_call, response, nullptr);
}

static void path_provider_master_plugin_dispose(GObject* object) {
  G_OBJECT_CLASS(path_provider_master_plugin_parent_class)->dispose(object);
}

static void path_provider_master_plugin_class_init(PathProviderMasterPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = path_provider_master_plugin_dispose;
}

static void path_provider_master_plugin_init(PathProviderMasterPlugin* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call,
                          gpointer user_data) {
  PathProviderMasterPlugin* plugin = PATH_PROVIDER_MASTER_PLUGIN(user_data);
  path_provider_master_plugin_handle_method_call(plugin, method_call);
}

void path_provider_master_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  PathProviderMasterPlugin* plugin = PATH_PROVIDER_MASTER_PLUGIN(
      g_object_new(path_provider_master_plugin_get_type(), nullptr));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "path_provider_master",
                            FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb,
                                            g_object_ref(plugin),
                                            g_object_unref);

  g_object_unref(plugin);
}
