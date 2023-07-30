import 'package:test/test.dart';
import 'package:cupp/cupp.dart' show parse;

void main() {
  test("identifies (...n) as CallExpression", () {
    const tokens = [
      {'type': 'parenthesis', 'value': '('},
      {'type': 'name', 'value': 'add'},
      {'type': 'number', 'value': '2'},
      {'type': 'number', 'value': '2'},
      {'type': 'parenthesis', 'value': ')'},
    ];
    const ast = {
      'type': 'Program',
      'body': [
        {
          'type': 'CallExpression',
          'name': 'add',
          'params': [
            {
              'type': 'NumberLiteral',
              'value': '2',
            },
            {
              'type': 'NumberLiteral',
              'value': '2',
            },
          ],
        },
      ],
    };
    expect(parse(tokens), ast);
  });
  test("expects to parse the tokens", () {
    const tokens = [
      {'type': 'parenthesis', 'value': '('},
      {'type': 'name', 'value': 'add'},
      {'type': 'number', 'value': '2'},
      {'type': 'parenthesis', 'value': '('},
      {'type': 'name', 'value': 'subtract'},
      {'type': 'number', 'value': '4'},
      {'type': 'number', 'value': '2'},
      {'type': 'parenthesis', 'value': ')'},
      {'type': 'parenthesis', 'value': ')'},
    ];
    const ast = {
      'type': 'Program',
      'body': [
        {
          'type': 'CallExpression',
          'name': 'add',
          'params': [
            {
              'type': 'NumberLiteral',
              'value': '2',
            },
            {
              'type': 'CallExpression',
              'name': 'subtract',
              'params': [
                {
                  'type': 'NumberLiteral',
                  'value': '4',
                },
                {
                  'type': 'NumberLiteral',
                  'value': '2',
                },
              ],
            },
          ],
        },
      ],
    };
    expect(parse(tokens), ast);
  });
}
