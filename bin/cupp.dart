import 'dart:io';

import 'package:chalk/chalk.dart';
import 'package:cupp/cupp.dart' as cupp;

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    repl();
  } else {
    var input = arguments.join(' ');
    print(cupp.tokenize(input));
  }
}

void repl() async {
  print('Welcome to the cupp REPL!');
  print('Type "exit" to exit.');
  while (true) {
    stdout.write('> ');
    var input = stdin.readLineSync();
    if (input == 'exit') {
      break;
    }
    print(
      chalk.yellow(
          (await cupp.evaluate(cupp.parse(cupp.tokenize(input ?? ""))))
              .toString(),
          ftFace: ChalkFtFace.italic),
    );
  }
}
