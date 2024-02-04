import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class EnumNameLinter extends DartLintRule {
  EnumNameLinter() : super(code: _code);

  static const _code = LintCode(
    name: 'do_not_use_enum_name',
    problemMessage:
        'Do not use the function "name" of an enum in production code. "name" is only mean for bugging purposes as it is not localized.',
    // correctionMessage: 'If you want to display an enum, use localization',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addPrefixedIdentifier((node) {
      if (node.identifier.name == 'name' && node.prefix.staticType?.element?.kind == ElementKind.ENUM) {
        reporter.reportErrorForNode(_code, node);
      }
    });
  }
}
