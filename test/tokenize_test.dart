import 'package:test/test.dart';
import 'package:cupp/cupp.dart' show tokenize;

void main() {
  test("should return empty list when input is empty", () {
    expect(tokenize(''), []);
  });
  test("Shoulfd ignore all whitespaces", () => expect(tokenize('  '), []));
  test(
    "Should tokenize a single character",
    () {
      const tokens = [
        {'type': 'name', 'value': 'a'},
      ];
      expect(tokenize('a'), tokens);
    },
    skip: false,
  );
  test(
    "Should token ( as parenthesis",
    () {
      const tokens = [
        {'type': 'parenthesis', 'value': '('},
      ];
      expect(tokenize('('), tokens);
    },
  );
  test(
    "Should tokenize a string",
    () {
      const tokens = [
        {'type': 'string', 'value': 'hello'},
      ];
      expect(tokenize('"hello"'), tokens);
    },
  );
  test(
    "Should tokenize a number",
    () {
      const tokens = [
        {'type': 'number', 'value': '123'},
      ];
      expect(tokenize('123'), tokens);
    },
  );
  test(
    "Should tokenize a name",
    () {
      const tokens = [
        {'type': 'name', 'value': 'add'},
      ];
      expect(tokenize('add'), tokens);
    },
  );
}
