import 'dart:io';
import 'package:chalk/chalk.dart';
import 'package:cupp/cupp.dart' as cupp;
import 'package:cupp/parse.dart';
import 'package:cupp/transform.dart';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('Welcome to the cupp REPL!');
    print('Type "exit" to exit.');
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
    var result = await cupp.evaluate(transform(
      cupp.parse(
        parenthesize(cupp.tokenize(content)),
      ),
    ));
    print(
      chalk.yellow(
        result.toString(),
        ftFace: ChalkFtFace.italic,
      ),
    );
  } catch (e, s) {
    print(chalk.red(e.toString()));
    print(chalk.red(s.toString()));
    repl();
  }
}

void compile(String path) {}

void repl() async {
  try {
    while (true) {
      stdout.write(chalk.green('> '));
      var input = stdin.readLineSync();
      if (input == 'exit') {
        break;
      }
      if (input == null || input.isEmpty) {
        continue;
      }

      if (input.endsWith('{')) {
        var lines = <String>[];
        while (true) {
          stdout.write(chalk.green('    '));
          var line = stdin.readLineSync();
          if (line == null || line.isEmpty) {
            continue;
          }

          if (line == '}') {
            break;
          }
          lines.add(line);
        }
        input = '$input${lines.join('\n')}}';
      }

      while (input!.endsWith(';')) {
        input = input.substring(0, input.length - 1);
      }

      var result = await cupp.evaluate(
        transform(
          cupp.parse(
            parenthesize(cupp.tokenize(input)),
          ),
        ),
      );
      print(
        chalk.yellow(
          result.toString(),
          ftFace: ChalkFtFace.italic,
        ),
      );
    }
  } catch (e, s) {
    print(chalk.red(e.toString()));
    print(chalk.red(s.toString()));
    repl();
  }
}
