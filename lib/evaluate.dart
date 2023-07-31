import 'std_library.dart';

Future<List<dynamic>> evaluateArgs(List<dynamic> args) async {
  return Future.wait(args.map((arg) async => await evaluate(arg)));
}

Future<dynamic> evaluate(Map<String, dynamic> ast) async {
  
  if (ast['type'] == 'Program') {
    return await evaluate(ast['body'][0]);
  }

  if (ast['type'] == 'CallExpression') {
    var callee = ast['name'];
    var args = await evaluateArgs(ast['params']);
    var [first, ...rest] = args;
    return apply({
      'name': callee,
      'args': {'left': first, 'right': rest}
    });
  }

  if (ast['type'] == 'AssignmentExpression') {
    define({'name': ast['name'], 'value': await evaluate(ast['params'][0])});
  }

  if (ast['type'] == 'NumberLiteral') {
    return double.parse(ast['value']);
  }

  if (ast['type'] == 'StringLiteral') {
    return ast['value'];
  }

  if (ast['type'] == 'Identifier') {
    return ast['name'];
  }

  throw Exception("${ast['type']} is not a valid type.");
}

dynamic apply(node) {
  var fn = environment[node['name']];
  if (fn == null) {
    throw Exception("${node['name']} is not a function.");
  }
  return fn(node['args']);
}

void define(node) {
  environment[node.name] = node.value;
}

dynamic getIdentifierValue(name) {
  return environment[name];
}

Object pluckDeep(Map<String, dynamic> obj, String path) =>
    path.split('.').fold(obj, (prev, curr) => (prev as Map)[curr]);
