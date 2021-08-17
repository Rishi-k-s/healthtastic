import 'dart:io' show Platform;

class Secret {
  static const WEB_CLIENT_ID = "183839496109-1j13765dfv5hrl24qd2t5ioggj7hr3kf.apps.googleusercontent.com";
  static const ANDROID_CLIENT_ID = "183839496109-t0aumqpqkv23jdajc11ln8kjlcaij2f9.apps.googleusercontent.com";
  static String getId() => Platform.isAndroid ? Secret.ANDROID_CLIENT_ID : Secret.WEB_CLIENT_ID;
}
