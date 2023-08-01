import 'dart:io';

import 'package:chalk/chalk.dart';
import 'package:cupp/cupp.dart' as cupp;
import 'package:cupp/parse.dart';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    repl();
  } else {
    if (arguments.first == "-h" || arguments.first == "--help") {
      print("Usage: cupp [options] [file]");
      print("Options:");
      print("  -h, --help    Print this help message");
      print("  -v, --version Print the version number");
      print("  -r, --run     Run the file");
      print("  -c, --compile Compile the file");
      return;
    }

    if (arguments.first == "-v" || arguments.first == "--version") {
      print("Cupp version 0.0.1");
      return;
    }

    if (arguments.first == "-r" || arguments.first == "--run") {
      if (arguments.length < 2) {
        print("Error: No file specified");
        return;
      }
      await run(arguments[1]);
      return;
    }

    if (arguments.first == "-c" || arguments.first == "--compile") {
      if (arguments.length < 2) {
        print("Error: No file specified");
        return;
      }
      compile(arguments[1]);
      return;
    }
  }
}

Future<void> run(String path) async {
  var content = File(path).readAsStringSync();
  if (content.isEmpty) {
    print("Error: File is empty");
    return;
  }
  try {
    print(
      chalk.yellow(
          (await cupp.evaluate(cupp.parse(cupp.tokenize(content)))).toString(),
          ftFace: ChalkFtFace.italic),
    );
  } catch (e, s) {
    print(chalk.red(e.toString()));
    print(chalk.red(s.toString()));
  }
}

void compile(String path) {}

void repl() async {
  try {
    print('Welcome to the cupp REPL!');
    print('Type "exit" to exit.');
    while (true) {
      stdout.write(chalk.green('> '));
      var input = stdin.readLineSync();
      if (input == 'exit') {
        break;
      }
      if (input == null || input.isEmpty) {
        continue;
      }

      print(
        chalk.yellow(
          (
            await cupp.evaluate(cupp.parse(
              parenthesize(cupp.tokenize(input)),
            )),
          )
              .toString(),
          ftFace: ChalkFtFace.italic,
        ),
      );
    }
  } catch (e, s) {
    print(chalk.red(e.toString()));
    print(chalk.red(s.toString()));
  }
}
