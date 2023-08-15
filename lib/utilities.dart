import 'package:chalk/chalk.dart';

dynamic pop(List list) {
  var item = list[0];
  list.removeAt(0);
  return item;
}

dynamic peek(List list) {
  return list[0];
}

// colors
void magenta(Object object) => print(chalk.magenta(object.toString()));
void red(Object object) => print(chalk.red(object.toString()));
void green(Object object) => print(chalk.green(object.toString()));
void yellow(Object object) => print(chalk.yellow(object.toString()));
void blue(Object object) => print(chalk.blue(object.toString()));
void cyan(Object object) => print(chalk.cyan(object.toString()));
void white(Object object) => print(chalk.white(object.toString()));
