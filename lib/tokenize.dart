List<Map<String, dynamic>> tokenize(String input) {
  var tokens = <Map<String, dynamic>>[];
  var cursor = 0;

  while (cursor < input.length) {
    var char = input[cursor];

    if (isWhitespace(char)) {
      cursor++;
      continue;
    }

    if (isQuote(char)) {
      var quote = char;
      var value = '';
      cursor++;
      while (cursor < input.length) {
        char = input[cursor];
        if (char == quote) {
          break;
        }
        value += char;
        cursor++;
      }
      tokens.add({
        'type': 'string',
        'value': value,
      });
      cursor++;
      continue;
    }

    if (isParenthesis(char)) {
      tokens.add({
        'type': 'parenthesis',
        'value': char,
      });
      cursor++;
      continue;
    }

    if (isNumber(char)) {
      var value = '';
      while (cursor < input.length) {
        char = input[cursor];
        if (!isNumber(char)) {
          break;
        }
        value += char;
        cursor++;
      }
      tokens.add({
        'type': 'number',
        'value': value,
      });
      continue;
    }

    if (isLetter(char)) {
      var value = '';
      while (cursor < input.length) {
        char = input[cursor];
        if (!isLetter(char)) {
          break;
        }
        value += char;
        cursor++;
      }
      tokens.add({
        'type': 'name',
        'value': value,
      });
      continue;
    }

    if (isSymbol(char)) {
      var value = '';
      while (cursor < input.length) {
        char = input[cursor];
        if (!isSymbol(char)) {
          break;
        }
        value += char;
        cursor++;
      }
      tokens.add({
        'type': 'symbol',
        'value': value,
      });
      continue;
    }

    throw Exception('Unknown character: $char');
  }
  return tokens;
}

bool isQuote(String char) {
  return char == '"' || char == "'" || char == '`';
}

bool isParenthesis(String char) {
  return isOpeningParenthesis(char) || isClosingParenthesis(char);
}

bool isOpeningParenthesis(String char) {
  return char == '(' || char == '[' || char == '{';
}

bool isClosingParenthesis(String char) {
  return char == ')' || char == ']' || char == '}';
}

bool isWhitespace(String char) {
  return char == ' ' || char == '\n' || char == '\t';
}

bool isNumber(String char) {
  return RegExp(r'\d').hasMatch(char);
}

bool isLetter(String char) {
  return RegExp(r'[a-zA-Z]').hasMatch(char);
}

bool isSymbol(String char) {
  return RegExp(r'[!@#$%^&*_=+<>.,;:?/\\|~-]').hasMatch(char);
}
