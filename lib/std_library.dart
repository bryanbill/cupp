var environment = {
  'add': add,
  'subtract': subtract,
  'multiply': multiply,
  'divide': divide,
  'modulo': modulo,
  'pow': pow,
  'max': max,
};

all(Function(dynamic, dynamic) fn) => (List list) => list.reduce(fn);

add(params) =>
    params['left'] + (params['right'] as List).reduce((a, b) => a + b);
subtract(params) =>
    params['left'] - (params['right'] as List).reduce((a, b) => a + b);
multiply(params) => params['left'] *
    (params['right'] as List).reduce((a, b) => a * b);
divide(a, b) => a / b;
modulo(a, b) => a % b;
pow(a, b) => a ^ b;

max(List list) => list.reduce((a, b) => a > b ? a : b);
