import 'package:args/command_runner.dart';
import 'package:fusion/io/commands/current_platform_command.dart';
import 'package:fusion/io/commands/version_command.dart';

Future<void> run(List<String> args) async {
  CommandRunner runner = CommandRunner("fusion", "The Fusion Package Manager")
    ..addCommand(VersionCommand())
    ..addCommand(CurrentPlatformCommand());
  await runner.run(args);
}
