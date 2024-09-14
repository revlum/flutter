
import 'offerwall_platform_interface.dart';

class Offerwall {
  Future<String?> getPlatformVersion() {
    return OfferwallPlatform.instance.getPlatformVersion();
  }
}
