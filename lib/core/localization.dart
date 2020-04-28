
/// Interface representing the localization mechanism for application-specific
/// string values. This can be used for configuration and translation purposes,
/// using a data-driven model. Other packages should depend on this interface.
abstract class Localization {

  operator [](String propertyName);

  String get(String propertyName);

}