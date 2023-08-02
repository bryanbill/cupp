import 'dart:math';

var environment = {
  'add': add,
  'subtract': subtract,
  'multiply': multiply,
  'divide': divide,
  'modulo': modulo,
  'pow': pow,
  'max': max,
  'log': log,
  "pi": (_) => {"type": "number", "value": pi}
};

all(Function(dynamic, dynamic) fn) => (List list) => list.reduce(fn);

add(params) {
  var left = params['left'];
  var right = params['right'];
  if (right == null || right.isEmpty) return left;

  return left + right.reduce((a, b) => a + b);
}

subtract(params) {
  var left = params['left'];
  var right = params['right'];
  if (right == null || right.isEmpty) return left;

  return left - right.reduce((a, b) => a + b);
}

multiply(params) {
  var left = params['left'];
  var right = params['right'];
  if (right == null || right.isEmpty) return left;

  return left * right.reduce((a, b) => a * b);
}

divide(params) {
  var left = params['left'];
  var right = params['right'];
  if (right == null || right.isEmpty) return left;

  return left / right.reduce((a, b) => a / b);
}

modulo(params) {
  var left = params['left'];
  var right = params['right'];
  if (right == null || right.isEmpty) return left;

  return left % right.reduce((a, b) => a % b);
}

pow(params) {
  var left = params['left'];
  var right = params['right'];
  if (right == null || right.isEmpty) return left;

  return left ^ right.reduce((a, b) => a ^ b);
}

max(params) =>
    [params['left'], ...params['right']].reduce((a, b) => a > b ? a : b);

log(Map params) {
  var left = params['left'];
  var right = params['right'];

  if (right == null || right.isEmpty) {
    print(left.toString());
    return;
  }

  var joined = "$left ${right.reduce((v, e) => '$v $e')}";
  print(joined);
}
