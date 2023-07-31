import 'package:cupp/tokenize.dart';
import 'package:cupp/utilities.dart';

Map<String, dynamic> parse(tokens) {
  print(tokens);
  tokens = parenthesize(tokens);
  if (tokens is List) {
    var [first, ...rest] = tokens;
    return {
      "type": "CallExpression",
      "name": first['value'],
      "params": rest.map((token) => parse(token)).toList()
    };
  }

  var token = tokens;

  if (token['type'] == 'number') {
    return {"type": "NumberLiteral", "value": token['value']};
  }

  if (token['type'] == 'string') {
    return {"type": "StringLiteral", "value": token['value']};
  }

  if (token['type'] == 'name') {
    return {"type": "Identifier", "name": token['value']};
  }

  return {};
}

dynamic parenthesize(List tokens) {
  var token = pop(tokens);

  print("Popped token: $token");

  if (isOpeningParenthesis(token['value'].toString())) {
    var expression = <dynamic>[];
    while (!isClosingParenthesis(peek(tokens)['value'].toString())) {
      expression.add(parenthesize(tokens));
    }
    pop(tokens);
    return expression;
  }
  return token;
}
