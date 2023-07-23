import 'dart:io';

class PlatformIdentifier {
  static String getPlatform() {
    if (Platform.isWindows) {
      return "windows";
    } else if (Platform.isMacOS) {
      return "macos";
    }
    return _LinuxIdentifier.getDistro();
  }

  static int getArchitecture() {
    var version = Platform.version;
    var bit = version.endsWith("x64\"") ? 64 : 32;
    return bit;
  }

  static bool isx64() {
    return getArchitecture() == 64;
  }
}

class _LinuxIdentifier {
  static String getDistro() {
    String distro = "linux";
    File releaseFile = File('/etc/os-release');
    List<String> lines = releaseFile.readAsLinesSync();
    for (var line in lines) {
      if (line.startsWith("ID=")) {
        distro = line.substring(3).toLowerCase();
        break;
      }
    }
    return distro;
  }

  static bool isUbuntuOrDebian() {
    return ["ubuntu", "debian"].contains(getDistro());
  }

  static bool isFedora() {
    return getDistro() == 'fedora';
  }

  static bool isArch() {
    return getDistro() == 'arch';
  }
}
