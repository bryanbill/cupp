import 'package:test/test.dart';
import 'package:cupp/cupp.dart' show parse;

void main() {
  test("should return NumberLiteral for number tokens", () {
    var tokens = [
      {'type': 'number', 'value': '1'},
    ];
    var ast = {'type': 'NumberLiteral', 'value': '1'};
    expect(parse(tokens), ast);
  });
  test("should return StringLiteral for string tokens", () {
    var tokens = [
      {'type': 'string', 'value': 'hello'},
    ];
    var ast = {'type': 'StringLiteral', 'value': 'hello'};
    expect(parse(tokens), ast);
  });
  test("should return an AST for a basic data strucuture", () {
    var tokens = [
      {"type": 'parenthesis', "value": '('},
      {"type": 'name', "value": 'add'},
      {"type": 'number', "value": 2},
      {"type": 'number', "value": 3},
      {"type": 'parenthesis', "value": ')'},
    ];

    const ast = {
      "type": 'CallExpression',
      "name": 'add',
      "params": [
        {"type": 'NumberLiteral', "value": 2},
        {"type": 'NumberLiteral', "value": 3},
      ],
    };

    expect(parse(tokens), ast);
  });
  test("should return an AST for a nested data structure", () {
     var tokens = [
      { "type": 'parenthesis', "value": '(' },
      { "type": 'name', "value": 'add' },
      { "type": 'number', "value": 2 },
      { "type": 'number', "value": 3 },
      { "type": 'parenthesis', "value": '(' },
      { "type": 'name', "value": 'subtract' },
      { "type": 'number', "value": 4 },
      { "type": 'number', "value": 2 },
      { "type": 'parenthesis', "value": ')' },
      { "type": 'parenthesis', "value": ')' },
    ];

    const ast = {
      "type": 'CallExpression',
      "name": 'add',
      "params": [
        { "type": 'NumberLiteral', "value": 2 },
        { "type": 'NumberLiteral', "value": 3 },
        {
          "type": 'CallExpression',
          "name": 'subtract',
          "params": [
            { "type": 'NumberLiteral', "value": 4 },
            { "type": 'NumberLiteral', "value": 2 },
          ],
        },
      ],
    };

    expect(parse(tokens), ast);
  });
}
