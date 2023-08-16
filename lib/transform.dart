import 'package:cupp/special_forms.dart';
import 'package:cupp/traverse.dart';

Map<String, dynamic> transform(Map<String, dynamic> node) {
  traverse(node, {
    "CallExpression": {
      "enter": (node, _) {
        if (specialForms[node['name']] != null) {
          specialForms[node['name']]!(node);
        }
      }
    },
    "VariableDeclaration": {
      "enter": (node, _) {
        if (specialForms[node['kind']] != null) {
          specialForms[node['kind']]!(node);
        }
      }
    },
  });

  return node;
}
