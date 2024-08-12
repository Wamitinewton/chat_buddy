import 'package:athena_ai/core/app/app.dart';
import 'package:athena_ai/feature/hive/model/chat_bot/chat_bot.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initLoggy();
  _initgoogleFonts();

  final appDocumentDir = await getApplicationDocumentsDirectory();

  Hive
    ..init(appDocumentDir.path)
    ..registerAdapter(ChatBotAdapter());
  await Hive.openBox<ChatBot>('chatbots');
  runApp(const ProviderScope(child: NewtonAIBuddy()));
}

void _initLoggy() {
  Loggy.initLoggy(
      logOptions: const LogOptions(
        LogLevel.all,
        stackTraceLevel: LogLevel.warning,
      ),
      logPrinter: const PrettyPrinter());

  debugPrint("Loggy loaded sucessfully...............");
}

void _initgoogleFonts() {
  GoogleFonts.config.allowRuntimeFetching = false;

  LicenseRegistry.addLicense(() async* {
    final licence = await rootBundle.loadString("google_fonts/OFL.txt");
    yield LicenseEntryWithLineBreaks(['google_fonts'], licence);
  });
}
