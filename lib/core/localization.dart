/// Interface representing the localization mechanism for application-specific
/// string values. This can be used for configuration and translation purposes,
/// using a data-driven model. Other packages should depend on this interface.
class Localization {
  String Function(String name) _getter;

  Localization(this._getter);

  String get(String propertyName) => _getter(propertyName);

  operator [](String propertyName) => get(propertyName);
}
