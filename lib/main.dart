
import 'package:athena_ai/core/app/style.dart';
import 'package:athena_ai/feature/welcome/welcome_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loggy/loggy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initLoggy();
  _initgoogleFonts();
  runApp(const MyApp());
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: darkTheme,
      home: const WelcomePage()
    );
  }
}
