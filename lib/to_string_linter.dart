import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class ToStringLinter extends DartLintRule {
  ToStringLinter() : super(code: _code);

  static const _code = LintCode(
    name: 'do_not_use_toString',
    problemMessage: 'Do not use toString as for production code. "toString" is only mean for bugging purposes',
    correctionMessage: 'If you want to display a int, use myInt.toStr',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      if (node.methodName.name == 'toString') {
        if (node.target?.staticType?.isDartCoreInt != true) {
          reporter.reportErrorForNode(_code, node);
        }
      }
    });
  }
}
