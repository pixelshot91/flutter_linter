/*
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final constructorLocationComponents = node.constructorName.type.type?.element2?.location?.components;
    if (constructorLocationComponents == null) {
      lints.add(Lint(
        code: 'null_ctor_loc_comp',
        location: unit.lintLocationFromOffset(
          node.offset,
          length: node.length,
        ),
        message: 'constructorLocationComponents == null. what does it mean ?',
      ));
      return;
    }

    final listEq = ListEquality().equals;
    if (listEq(constructorLocationComponents,
        ['package:flutter/src/widgets/icon.dart', 'package:flutter/src/widgets/icon.dart', 'Icon'])) {
      lints.add(Lint(
          code: 'do_not_use_flutter_icon',
          location: unit.lintLocationFromOffset(
            node.offset,
            length: node.length,
          ),
          message:
              'Do not use Icon as it does not use the intrinsic icon size, but use the dimension from ThemeData.iconTheme.size (which is 24 pixels by default). The icon may be well well rendered, but the widget around it may overlap the icon or there may be a gap between the Icon and the other Widget.',
          correction: 'Use FaIcon (from FontAwesome) instead which uses the size of the icon.',
          getAnalysisErrorFixes: (lint) async* {
            final changeBuilder = ChangeBuilder(session: unit.session);

            await changeBuilder.addDartFileEdit(
              unit.libraryElement.source.fullName,
              (fileEditBuilder) {
                fileEditBuilder.addSimpleReplacement(
                    SourceRange(node.constructorName.offset, node.constructorName.length), 'FaIcon');
              },
            );

            final sourceChange = changeBuilder.sourceChange;
            sourceChange.message = "Replace with FaIcon";
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
    super.visitInstanceCreationExpression(node);
  }

 */

/*
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:collection/collection.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class StringInterpolationLinter extends PluginBase {
  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    final lints = <Lint>[];
    unit.unit.visitChildren(
      RecursiveStringInterpolationVisitor(unit: unit, lints: lints),
    );
    for (final lint in lints) {
      yield lint;
    }
  }
}

class RecursiveStringInterpolationVisitor extends RecursiveAstVisitor<void> {
  RecursiveStringInterpolationVisitor({required this.unit, required this.lints});
  final ResolvedUnitResult unit;
  final List<Lint> lints;
  @override
  void visitStringInterpolation(StringInterpolation node) {
    node.elements.whereType<InterpolationExpression>().forEach((interExpr) {
      final staticType = interExpr.expression.staticType;
      if (staticType == null ||
          staticType.nullabilitySuffix != NullabilitySuffix.none ||
          !staticType.isDartCoreInt && !staticType.isDartCoreString) {
        lints.add(Lint(
          code: 'do_not_use_unsafe_string_interpolation',
          location: unit.lintLocationFromOffset(
            interExpr.offset,
            length: interExpr.length,
          ),
          message:
              'Do not use String Interpolation on an object of type $staticType. Everything displayed to the final user should be either a non-nullable String or a non-nullable int',
        ));
      }
    });
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
