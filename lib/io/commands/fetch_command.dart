import 'package:args/command_runner.dart';

class FetchCommand extends Command {
  @override
  String get description => "Fetches the latest package list";

  @override
  String get name => "--fetch";

  @override
  void run() {
    print("TODO: ");
  }
}
