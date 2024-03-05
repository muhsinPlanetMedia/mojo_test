//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <mojo_test/mojo_test_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) mojo_test_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MojoTestPlugin");
  mojo_test_plugin_register_with_registrar(mojo_test_registrar);
}
