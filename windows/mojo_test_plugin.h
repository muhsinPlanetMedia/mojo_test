#ifndef FLUTTER_PLUGIN_MOJO_TEST_PLUGIN_H_
#define FLUTTER_PLUGIN_MOJO_TEST_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace mojo_test {

class MojoTestPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  MojoTestPlugin();

  virtual ~MojoTestPlugin();

  // Disallow copy and assign.
  MojoTestPlugin(const MojoTestPlugin&) = delete;
  MojoTestPlugin& operator=(const MojoTestPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace mojo_test

#endif  // FLUTTER_PLUGIN_MOJO_TEST_PLUGIN_H_
