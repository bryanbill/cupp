dynamic pop(List list) {
  var item = list[0];
  list.removeAt(0);
  return item;
}

dynamic peek(List list) {
  return list[0];
}
