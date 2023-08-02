import 'std_library.dart';

Future<List<dynamic>> evaluateArgs(List<dynamic> args) async {
  return Future.wait(args.map((arg) async => await evaluate(arg)));
}

Future<dynamic> evaluate(Map<String, dynamic> node) async {
  if (node['type'] == 'Program') {
    return await evaluate(node['body'][0]);
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

  if (node['type'] == 'Identifier') {
    return getIdentifierValue(node['name']);
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
  return fn(node['args']);
}

void define(node) async{
  var identifier = node['identifier']['name'];
  var result = await evaluate(node['assignment']);

  environment[identifier] = (_) => {
        "kind": node['kind'],
        "type": result.runtimeType.toString(),
        "value": result,
      };
}

dynamic getIdentifierValue(name) {
  if (environment.containsKey(name)) {
    var value = environment[name];
    if (value is Function) {
      return value?.call({})['value'];
    }
    return value;
  }

  throw Exception("Undefined variable $name");
}

Object pluckDeep(Map<String, dynamic> obj, String path) =>
    path.split('.').fold(obj, (prev, curr) => (prev as Map)[curr]);
