import 'package:cupp/tokenize.dart';
import 'package:cupp/utilities.dart';

Map<String, dynamic> parse(tokens) {
  if (tokens is List) {
    var [first, ...rest] = tokens;
    return {
      "type": "CallExpression",
      "name": first['value'],
      "params": rest.map(parse).toList()
        ..removeWhere((element) => element.values.isEmpty)
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

dynamic parenthesize(tokens) {
  if (tokens is! List) {
    tokens = [tokens];
  }
  var token = pop(tokens);
  if (isOpeningParenthesis(token['value'])) {
    var expression = [];
    while (!isClosingParenthesis(peek(tokens)['value'])) {
      expression.add(parenthesize(tokens));
    }
    pop(tokens);
    return expression;
  }
  return token;
}
