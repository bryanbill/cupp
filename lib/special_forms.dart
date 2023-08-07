var specialForms = {
  "let": (Map node) {
    var identifier = (node['params'] as List)[0];
    var value = {
      "type": "Literal",
      "value": null,
    };

    if ((node['params'] as List).length > 1) {
      value = Map.from((node['params'] as List)[1]);
    }
    node['type'] = 'VariableDeclaration';
    node['identifier'] = identifier;
    node['assignment'] = value;
    node['kind'] = 'var';

    node.remove('name');
    node.remove('params');
  },
  "final": (Map node) {
    var identifier = (node['params'] as List)[0];
    var value = (node['params'] as List)[1];

    node['type'] = 'VariableDeclaration';
    node['identifier'] = identifier;
    node['assignment'] = value;
    node['kind'] = 'final';

    node.remove('name');
    node.remove('params');
  },
  "=": (Map node) {
    var identifier = (node['params'] as List)[0];
    var value = (node['params'] as List)[1];

    node['type'] = 'AssignmentExpression';
    node['identifier'] = identifier;
    node['assignment'] = value;

    node.remove('name');
    node.remove('params');
  },
  "+": (node) {
    node['name'] = 'add';
    return node;
  },
  "-": (node) {
    node['name'] = 'subtract';
    return node;
  },
  "*": (node) {
    node['name'] = 'multiply';
    return node;
  },
  "/": (node) {
    node['name'] = 'divide';
    return node;
  },
  "%": (node) {
    node['name'] = 'modulo';
    return node;
  },
  "^": (node) {
    node['name'] = 'pow';
    return node;
  },
};
