import 'package:args/command_runner.dart';
import 'package:fusion/io/app_constants.dart';

class VersionCommand extends Command {
  @override
  String get description => "Prints installed fusion version";

  @override
  String get name => "--version";

  @override
  void run() => print(getFusionVersion());
}
