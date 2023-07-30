Future<dynamic> evaluate(Map<String, dynamic> obj) async {
}

Object pluckDeep(Map<String, dynamic> obj, String path) =>
    path.split('.').fold(obj, (prev, curr) => (prev as Map)[curr]);
