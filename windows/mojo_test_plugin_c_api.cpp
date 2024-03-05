#include "include/mojo_test/mojo_test_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "mojo_test_plugin.h"

void MojoTestPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  mojo_test::MojoTestPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
