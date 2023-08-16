import 'package:test/test.dart';
import 'package:cupp/cupp.dart' show parse, tokenize, parenthesize;

void main() {
  test("should return NumberLiteral for number tokens", () {
    var tokens = tokenize("(1)");
    var ast = {'type': 'NumberLiteral', 'value': '1'};
    expect(parse(tokens)['args'][0], ast);
  });
  test("should return StringLiteral for string tokens", () {
    var tokens = tokenize('("hello")');
    var ast = {'type': 'StringLiteral', 'value': 'hello'};
    expect(parse(tokens)['args'][0], ast);
  });
  test("should return an AST for a basic data strucuture", () {
    var tokens = tokenize("add 2 3");

    const ast = {
      "type": 'CallExpression',
      "name": 'add',
      "args": [
        {"type": 'NumberLiteral', "value": '2'},
        {"type": 'NumberLiteral', "value": '3'},
      ],
    };

    expect(parse(tokens), ast);
  });
  test("should return an AST for a nested data structure", () {
    var tokens = parenthesize(tokenize("(add 2 3 (subtract 4 2))"));

    const ast = {
      "type": 'CallExpression',
      "name": 'add',
      "args": [
        {"type": 'NumberLiteral', "value": '2'},
        {"type": 'NumberLiteral', "value": '3'},
        {
          "type": 'CallExpression',
          "name": 'subtract',
          "args": [
            {"type": 'NumberLiteral', "value": '4'},
            {"type": 'NumberLiteral', "value": '2'},
          ],
        },
      ],
    };

    expect(parse(tokens), ast);
  });
}
