import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:flutter_linter/enum_name_linter.dart';
import 'package:flutter_linter/icon_linter.dart';
import 'package:flutter_linter/to_string_linter.dart';

import 'string_interp.dart';

// This is the entrypoint of our custom linter
PluginBase createPlugin() => _FlutterLinter();

/// A plugin class is used to list all the assists/lints defined by a plugin.
class _FlutterLinter extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        StringInterpolationLinter(),
        ToStringLinter(),
        EnumNameLinter(),
        IconLinter(),
      ];
}
