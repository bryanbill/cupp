Future<dynamic> evaluate(Map<String, dynamic> ast) async {
  if (ast['type'] == 'Program') {
    return await evaluate(ast['body'][0]);
  }

  if (ast['type'] == 'CallExpression') {
    var callee = ast['name'];
    var args = ast['params'].map((arg) async => await evaluate(arg));
    if (callee == 'add') {
      return (await args.first) + (await args.last);
    }
    if (callee == 'subtract') {
      return (await args.first) - (await args.last);
    }
    if (callee == 'multiply') {
      return (await args.first) * (await args.last);
    }
    if (callee == 'divide') {
      return (await args.first) / (await args.last);
    }
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

Object pluckDeep(Map<String, dynamic> obj, String path) =>
    path.split('.').fold(obj, (prev, curr) => (prev as Map)[curr]);
