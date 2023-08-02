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
  "pi": (_)=> pi
};

all(Function(dynamic, dynamic) fn) => (List list) => list.reduce(fn);

add(params) =>
    params['left'] + (params['right'] as List).reduce((a, b) => a + b);
subtract(params) =>
    params['left'] - (params['right'] as List).reduce((a, b) => a + b);
multiply(params) =>
    params['left'] * (params['right'] as List).reduce((a, b) => a * b);
divide(a, b) => a / b;
modulo(a, b) => a % b;
pow(a, b) => a ^ b;

max(params) =>
    [params['left'], ...params['right']].reduce((a, b) => a > b ? a : b);


log(Map params) {
  var left = params['left'];
  var right = params['right'];

  if (right.isEmpty) {
    print(left.toString());
  }

  var joined = "$left ${right.reduce((v, e) => '$v $e')}";
  print(joined);
}
