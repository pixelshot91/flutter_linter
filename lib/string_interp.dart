import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class StringInterpolationLinter extends DartLintRule {
  StringInterpolationLinter() : super(code: _code);

  static const _code = LintCode(
    name: 'do_not_use_unsafe_string_interpolation',
    problemMessage:
        'Do not use String Interpolation on an object of type `{0}`. Everything displayed to the final user should be either a non-nullable String or a non-nullable int',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addStringInterpolation((node) {
      node.elements.whereType<InterpolationExpression>().forEach((interExpr) {
        final staticType = interExpr.expression.staticType;
        if (staticType == null ||
            staticType.nullabilitySuffix != NullabilitySuffix.none ||
            !staticType.isDartCoreInt && !staticType.isDartCoreString) {
          reporter.reportErrorForOffset(code, interExpr.offset, interExpr.length, [staticType.toString()]);
        }
      });
    });
  }
}
/*
class RecursiveStringInterpolationVisitor extends RecursiveAstVisitor<void> {
  RecursiveStringInterpolationVisitor({required this.unit, required this.lints});
  final ResolvedUnitResult unit;
  final List<Lint> lints;
  @override
  void visitStringInterpolation(StringInterpolation node) {
    super.visitStringInterpolation(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.methodName.name == 'toString') {
      lints.add(Lint(
        code: 'do_not_use_toString',
        location: unit.lintLocationFromOffset(
          node.offset,
          length: node.length,
        ),
        message: 'Do not use toString as for production code. "toString" is only mean for bugging purposes',
        correction: 'If you want to display a int, use myInt.toStr',
      ));
    }
    super.visitMethodInvocation(node);
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    if (node.identifier.name == 'name' && node.prefix.staticType?.element2?.kind == ElementKind.ENUM) {
      lints.add(Lint(
          code: 'do_not_use_enum_name',
          location: unit.lintLocationFromOffset(
            node.offset,
            length: node.length,
          ),
          message:
              'Do not use the function "name" of an enum in production code. "name" is only mean for bugging purposes as it is not localized.',
          correction: ' If you want to display an enum, use localization',
          getAnalysisErrorFixes: (lint) async* {
            final changeBuilder = ChangeBuilder(session: unit.session);

            await changeBuilder.addDartFileEdit(
              unit.libraryElement.source.fullName, // Path to the current file
              (fileEditBuilder) {
                fileEditBuilder.addSimpleReplacement(
                    SourceRange(node.identifier.offset, node.identifier.length), 'loc(loc)');
              },
            );

            final sourceChange = changeBuilder.sourceChange;
            sourceChange.message = "Replace with ${node.prefix.name}.loc";
            yield AnalysisErrorFixes(
              lint.asAnalysisError(),
              fixes: [
                PrioritizedSourceChange(
                  0,
                  sourceChange,
                ),
              ],
            );
          }));
    }
    super.visitPrefixedIdentifier(node);
  }
}
*/
