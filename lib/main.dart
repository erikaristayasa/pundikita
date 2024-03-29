import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pundi_kita/core/utility/locator.dart';

import 'core/routes/path.dart' as path;
import 'core/routes/router.dart' as route;
import 'core/static/colors.dart';
import 'core/static/extensions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  locatorSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pundikita',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          context.textTheme(),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.PRIMARY,
          secondary: AppColors.SECONDARY,
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id', ''),
      ],
      onGenerateRoute: route.Router.generateRoutes,
      initialRoute: path.SPLASH_SCREEN,
      debugShowCheckedModeBanner: false,
    );
  }
}
