/// Interface representing the localization mechanism for application-specific
/// string values. This can be used for configuration and translation purposes,
/// using a data-driven model. Other packages should depend on this interface.
class LocalizationService {
  final String Function(String) stringGetter;

  LocalizationService({this.stringGetter});

  String getString(String propertyName) => stringGetter(propertyName);

  operator [](String propertyName) => getString(propertyName);
}
