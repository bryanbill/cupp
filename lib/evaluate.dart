import 'package:cupp/transform.dart';

import 'std_library.dart';

Future<List<dynamic>> evaluateArgs(List<dynamic> args) async {
  return Future.wait(args.map((arg) async => await evaluate(transform(arg))));
}

Future<dynamic> evaluate(Map<String, dynamic> node) async {
  if (node['type'] == 'Program') {
    return await evaluate(transform(node['body'][0]));
  }

  if (node['type'] == 'CallExpression') {
    var callee = node['name'];
    var args = await evaluateArgs(node['params']);
    var [first, ...rest] = args;
    return apply({
      'name': callee,
      'args': {'left': first, 'right': rest}
    });
  }

  if (node['type'] == 'VariableDeclaration') {
    define(node);
    return;
  }

  if (node['type'] == "AssignmentExpression") {
    assign(node);
    return;
  }

  if (node['type'] == 'Identifier') {
    return getIdentifierValue(node['name']);
  }

  if (node['type'] == 'Literal') {
    return node['value'];
  }

  if (node['type'] == 'NumberLiteral') {
    return double.parse(node['value']);
  }

  if (node['type'] == 'StringLiteral') {
    return node['value'];
  }

  if (node['type'] == 'BooleanLiteral') {
    return bool.tryParse(node['value']);
  }

  throw Exception("I don't know how to evaluate ${node['type']}");
}

dynamic apply(node) {
  var fn = environment[node['name']];
  if (fn == null) {
    throw Exception("${node['name']} is not a function.");
  }
  if (fn is Function) return fn(node['args']);

  if (fn is Map) {
    return fn['value'](node['args']);
  }
}

void define(node) async {
  var identifier = node['identifier']['name'];
  var result = await evaluate(transform(node['assignment']));

  environment[identifier] = {
    'kind': node['kind'],
    "assignment": () => {
          "type": result.runtimeType.toString(),
          "value": result,
        }
  };
  return;
}

void assign(node) async {
  var identifier = node['identifier']['name'];
  var result = await evaluate(transform(node['assignment']));

  if (environment.containsKey(identifier)) {
    final env = environment[identifier];

    if ((env! as Map)['kind'] == 'final') {
      throw Exception("Cannot reassign final variable $identifier");
    }

    environment[identifier] = {
      'kind': (env as Map)['kind'],
      "assignment": () => {
            "type": result.runtimeType.toString(),
            "value": result,
          }
    };

    return;
  }

  throw Exception("Undefined variable $identifier");
}

dynamic getIdentifierValue(name) {
  if (environment.containsKey(name)) {
    var value = environment[name];
    if ((value as Map)['assignment'] is Function) {
      final result = value['assignment'].call();
      if (result is Future) {
        return result.then((value) => value);
      }
      return result['value'];
    }
    return value;
  }

  throw Exception("Undefined variable $name");
}

Object pluckDeep(Map<String, dynamic> obj, String path) =>
    path.split('.').fold(obj, (prev, curr) => (prev as Map)[curr]);
