var specialForms = {
  "let": (Map node) {
    var identifier = (node['args'] as List)[0];
    var value = <String, dynamic>{
      "type": "Literal",
      "value": null,
    };

    if ((node['args'] as List).length > 1) {
      value = Map.from((node['args'] as List)[1]);
    }

    node['type'] = 'VariableDeclaration';
    node['identifier'] = identifier;
    node['assignment'] = value;
    node['kind'] = 'var';

    node.remove('name');
    node.remove('args');
  },
  "final": (Map node) {
    var identifier = (node['args'] as List)[0];
    if (!((node['args'] as List).length > 1)) {
      throw Exception("final requires an assignment");
    }
    var value = Map.from((node['args'] as List)[1]);

    node['type'] = 'VariableDeclaration';
    node['identifier'] = identifier;
    node['assignment'] = value;
    node['kind'] = 'final';

    node.remove('name');
    node.remove('args');
  },
};
