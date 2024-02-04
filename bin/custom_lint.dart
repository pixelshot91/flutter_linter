// This is the entrypoint of our custom linter
import 'dart:isolate';

import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'string_interp.dart';

void main(List<String> args, SendPort sendPort) {
  startPlugin(sendPort, StringInterpolationLinter());
}
