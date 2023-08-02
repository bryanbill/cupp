import 'package:cupp/traverse.dart';
import 'package:test/test.dart';

void main() {
  test("should traverse all the nodes in the tree and reverse the math", () {
    var ast = {
      "type": "CallExpression",
      "name": "add",
      "params": [
        {"type": "NumberLiteral", "value": 2},
        {
          "type": "CallExpression",
          "name": "subtract",
          "params": [
            {"type": "NumberLiteral", "value": 4},
            {"type": "NumberLiteral", "value": 2}
          ]
        }
      ]
    };

    var visitor = {
      "CallExpression": {
        "enter": (node, _) {
          if (node['name'] == "add") {
            node['name'] = "subtract";
          } else if (node['name'] == "subtract") {
            node['name'] = "add";
          }
        }
      },
      "NumberLiteral": {
        "exit": (node, _) {
          node['value'] = -node['value'];
        }
      }
    };

    traverse(ast, visitor);
    expect(ast['name'], equals('subtract'));
  });

  test("Should traverse all the nodes and double all the numbers", () {
    var ast = {
      "type": "CallExpression",
      "name": "add",
      "params": [
        {"type": "NumberLiteral", "value": 12},
        {"type": "NumberLiteral", "value": 6}
      ]
    };

    var visitor = {
      "NumberLiteral": {
        "exit": (node, _) {
          node['value'] = node['value'] * 2;
        }
      }
    };

    traverse(ast, visitor);
    expect((ast['params'] as List)[0]['value'], equals(24));
    expect((ast['params'] as List)[1]['value'], equals(12));
  });

  test("should subtitute symbols with functions", () {
    var ast = {
      "type": "CallExpression",
      "name": "+",
      "params": [
        {"type": "NumberLiteral", "value": 2},
        {
          "type": "CallExpression",
          "name": "-",
          "params": [
            {"type": "NumberLiteral", "value": 4},
            {"type": "NumberLiteral", "value": 2}
          ]
        }
      ]
    };

    var visitor = {
      "CallExpression": {
        "enter": (node, _) {
          if (node['name'] == "+") {
            node['name'] = "add";
          } else if (node['name'] == "-") {
            node['name'] = "subtract";
          }
        }
      }
    };

    traverse(ast, visitor);
    expect(ast['name'], equals('add'));
  });
}
