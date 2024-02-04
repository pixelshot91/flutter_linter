import 'package:analyzer/error/listener.dart';
import 'package:collection/collection.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class IconLinter extends DartLintRule {
  IconLinter() : super(code: _code);

  static const _code = LintCode(
    name: 'do_not_use_flutter_icon',
    problemMessage:
        'Do not use Icon as it does not use the intrinsic icon size, but use the dimension from ThemeData.iconTheme.size (which is 24 pixels by default). The icon may be well well rendered, but the widget around it may overlap the icon or there may be a gap between the Icon and the other Widget.',
    correctionMessage: 'Use FaIcon (from FontAwesome) instead which uses the size of the icon.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      final constructorLocationComponents = node.constructorName.type.type?.element?.location?.components;

      final listEq = ListEquality<String>().equals;
      if (listEq(constructorLocationComponents,
          ['package:flutter/src/widgets/icon.dart', 'package:flutter/src/widgets/icon.dart', 'Icon'])) {
        reporter.reportErrorForNode(_code, node);
      }
    });
  }
}
