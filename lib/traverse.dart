import 'package:chalk/chalk.dart';
import 'package:cupp/evaluate.dart';

dynamic traverse(node, visitor) {
  traverseNode(node, null, visitor);
}

dynamic traverseNode(node, parent, visitor) {
  var methods = visitor[node['type']];
  if (methods != null && methods['enter'] != null) {
    methods['enter'](node, parent);
  }

  if (node['params'] != null && node['params'].isNotEmpty) {
    traverseArray(node['params'], node, visitor);
  }

  if (methods != null && methods['exit'] != null) {
    methods['exit'](node, parent);
  }
}

dynamic traverseArray(array, parent, visitor) {
  if (array.isEmpty) {
    return;
  }
  array.forEach((child) {
    traverseNode(child, parent, visitor);
  });
}
