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

void repl() {
  print('Welcome to the cupp REPL!');
  print('Type "exit" to exit.');
  while (true) {
    print('cupp> ');
    var input = stdin.readLineSync();
    if (input == 'exit') {
      break;
    }
    print(
      chalk.yellow(cupp.tokenize(input ?? "").toString(),
          ftFace: ChalkFtFace.italic),
    );
  }
}
