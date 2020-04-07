
abstract class NavigationArgument {

  operator [](String name);
  operator []=(String name, String value);

}

class MapNavigationArgument implements NavigationArgument {
  Map<String, String> _innerMap = Map();

  @override
  operator [](String name) => _innerMap[name];

  @override
  void operator []=(String name, String value) => _innerMap[name] = value;

}