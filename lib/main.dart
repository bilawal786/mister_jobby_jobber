import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import './helper/routes.dart';

import './screens/splash_screen.dart';
import './screens/home_screens/home_tab_screen.dart';
import './screens/home_screens/notification_screen.dart';
import './screens/account_screen/settings_screen.dart';
import './screens/auth_screens/register_screen.dart';
import './screens/auth_screens/login_screen.dart';
import './screens/auth_screens/mandatory_steps_screen.dart';
import './screens/auth_screens/mandatory_steps/availabilities_step_screen.dart';

import './providers/auth_provider/login_provider.dart';
import './providers/auth_provider/register_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
      ],
      path: 'assets/languages',
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => LoginProvider()),
        ChangeNotifierProvider(create: (ctx) => RegisterProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'Mister Jobby Jobber',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            // iconTheme: IconThemeData(color: Colors.black),
            // color: Colors.deepPurpleAccent,
            // foregroundColor: Colors.black,
            systemOverlayStyle: SystemUiOverlayStyle(
              //<-- SEE HERE
              // Status bar color
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 36,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontFamily: 'Cerebri Sans Bold',
            ),
            titleMedium: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontFamily: 'Cerebri Sans Bold',
            ),
            titleSmall: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontFamily: 'Cerebri Sans Bold',
            ),
            bodyLarge: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontFamily: 'Cerebri Sans Bold',
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontFamily: 'Cerebri Sans Bold',
            ),
            bodySmall: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              fontFamily: 'Cerebri Sans Regular',
            ),
            labelLarge: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w700,
              fontFamily: 'Cerebri Sans Regular',
            ),
            labelMedium: TextStyle(
              fontSize: 14,
              color: Colors.black38,
              fontWeight: FontWeight.w700,
              fontFamily: 'Cerebri Sans Regular',
            ),
            labelSmall: TextStyle(
              fontSize: 12,
              color: Colors.black38,
              fontWeight: FontWeight.w500,
              fontFamily: 'Cerebri Sans Regular',
            ),
            displayLarge: TextStyle(
              fontSize: 16,
              color: Colors.black38,
              fontWeight: FontWeight.normal,
              fontFamily: 'Cerebri Sans Regular',
            ),
            displayMedium: TextStyle(
              fontSize: 14,
              color: Colors.black38,
              fontWeight: FontWeight.normal,
              fontFamily: 'Cerebri Sans Regular',
            ),
            displaySmall: TextStyle(
              fontSize: 12,
              color: Colors.black38,
              fontWeight: FontWeight.normal,
              fontFamily: 'Cerebri Sans Regular',
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black38,
            size: 30,
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Theme.of(context).primaryColor,
            textTheme: ButtonTextTheme.normal,
          ),
        ),
        routes: {
          MyRoutes.SPLASHSCREENROUTE:(ctx)=>const SplashScreen(),
          MyRoutes.HOMESCREENROUTE: (ctx) => const HomeTabScreen(),
          MyRoutes.NOTIFICATIONSCREENROUTE: (ctx) => const NotificationDisplay(),
          MyRoutes.SETTINGSCREENROUTE: (ctx) => const SettingScreen(),
          MyRoutes.REGISTERROUTE: (ctx) => const RegisterScreen(),
          MyRoutes.LOGINSCREENROUTE: (ctx) => const LoginScreen(),
          MyRoutes.MANDATORYSTEPSSCREENROUTE: (ctx) => const MandatoryStepsScreen(),
          MyRoutes.AVAILABILITIESSCREENROUTE: (ctx) => const AvailabilitiesScreen(),
        },
      ),
    );
  }
}
