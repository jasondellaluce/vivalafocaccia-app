
class NavigationArgument {
  Map<String, String> _innerMap = Map();

  operator [](String name) => _innerMap[name];
  
  void operator []=(String name, String value) => _innerMap[name] = value;

}