import 'dart:math';

import 'package:test/test.dart';
import 'package:cupp/cupp.dart';

void main() {
  test("should fall back to returning a primitive number", () async {
    var ast = parse(parenthesize(tokenize("1")));
    var result = await evaluate(ast);
    expect(result, equals(1));
  });
  test("should fall back to returning a primitive string value", () async {
    var ast = parse(parenthesize(tokenize('"hello"')));
    var result = await evaluate(ast);
    expect(result, equals("hello"));
  });
  test("should be able to evaluate a single expression", () async {
    var ast = parse(parenthesize(tokenize("(add 1 2)")));
    var result = await evaluate(ast);
    expect(result, equals(3));
  });
  test("should be able to evaluate a nested expression", () async {
    var ast = parse(parenthesize(tokenize("(add 1 (subtract 2 3))")));
    var result = await evaluate(ast);
    expect(result, equals(0));
  });
  test("should be able to lookup identifiers in the environment", () async {
    var ast = parse(parenthesize(tokenize("pi")));
    var result = await evaluate(ast);
    expect(result, equals(pi));
  });
  test("Should be able to give highest number in a range", () async {
    var ast = parse(parenthesize(tokenize("(max 1 2 3 4 5)")));
    var result = await evaluate(ast);
    expect(result, equals(5));
  });
}
