Map<String, dynamic> parse(List<Map<String, dynamic>> tokens) {
  var cursor = 0;

  Map<String, dynamic> walk() {
    var token = tokens[cursor];
    if (token['type'] == 'name') {
      cursor++;
      return {
        'type': 'Identifier',
        'name': token['value'],
      };
    }

    if (token['type'] == 'number') {
      cursor++;
      return {
        'type': 'NumberLiteral',
        'value': token['value'],
      };
    }

    if (token['type'] == 'string') {
      cursor++;
      return {
        'type': 'StringLiteral',
        'value': token['value'],
      };
    }

    if (token['type'] == 'parenthesis' && token['value'] == '(') {
      token = tokens[++cursor];

      var node = {
        'type': 'CallExpression',
        'name': token['value'],
        'params': [],
      };

      token = tokens[++cursor];

      while ((token['type'] != 'parenthesis') ||
          (token['type'] == 'parenthesis' && token['value'] != ')')) {
        node['params'].add(walk());
        token = tokens[cursor];
      }

      cursor++;
      return node;
    }

    throw Exception("${token['type']} ${token['value']} is not a valid token.");
  }

  var ast = {
    'type': 'Program',
    'body': [],
  };

  while (cursor < tokens.length) {
    (ast['body'] as List).add(walk());
  }

  return ast;
}
