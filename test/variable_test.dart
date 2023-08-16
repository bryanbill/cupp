import 'package:cupp/cupp.dart';
import 'package:cupp/std_library.dart';
import 'package:test/test.dart';

void main() {
  test("should be able to define new variables with final as kind", () {
    const code = "(final x 1)";
    var ast = {
      "type": "VariableDeclaration",
      "identifier": {
        "type": "Identifier",
        "name": "x",
      },
      "assignment": {
        "type": "NumberLiteral",
        "value": '1',
      },
      "kind": "final",
    };

    expect(transform(parse(parenthesize(tokenize(code)))), equals(ast));
  });

  test("should be able to define new variables with var as kind", () {
    const code = "(let x 1)";
    var ast = {
      "type": "VariableDeclaration",
      "identifier": {
        "type": "Identifier",
        "name": "x",
      },
      "assignment": {
        "type": "NumberLiteral",
        "value": '1',
      },
      "kind": "var",
    };

    expect(transform(parse(parenthesize(tokenize(code)))), equals(ast));
  });

  test("Should be able to lookup defined variables in the environment",
      () async {
    const code = "(let x 1)";
    await evaluate(transform(parse(parenthesize(tokenize(code)))));
    final x = (environment['x'] as Map)['assignment'] as Function;
    var result = {
      "type": "double",
      "value": 1,
    };
    expect(x.call(), equals(result));
  });

  test("final variables must have an assignment", () {
    const code = "(final x)";
    expect(() => evaluate(transform(parse(parenthesize(tokenize(code))))),
        throwsA(TypeMatcher<Exception>()));
  });
}
