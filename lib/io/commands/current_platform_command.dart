import 'package:args/command_runner.dart';
import 'package:fusion/io/platform_identifier.dart';

class CurrentPlatformCommand extends Command {
  @override
  String get description =>
      "Prints the name of current platform or linux distro";

  @override
  String get name => "--current-platform";

  @override
  void run() => print(PlatformIdentifier.getPlatform());
}
