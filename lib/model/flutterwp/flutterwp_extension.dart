
import 'package:flutter_wordpress/flutter_wordpress.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:meta/meta.dart';

class VLFWordPress extends WordPress {

  VLFWordPress() : super(
    baseUrl : GlobalConfiguration().get("serverUrl") ?? "vivalafocaccia.com",
    authenticator: WordPressAuthenticator.JWT
  );

  Future<User> authenticateUserWithGoogle({@required String googleToken})
      async {
    // TODO: Implement google authentication
    throw new UnimplementedError("authenticateUserWithGoogle");
  }

  Future<User> authenticateUserWithFacebook({@required String facebookToken})
      async {
    // TODO: Implement google authentication
    throw new UnimplementedError("authenticateUserWithFacebook");
  }

}