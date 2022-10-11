import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import './helper/routes.dart';

import './screens/splash_screen.dart';
import './screens/home_screens/home_tab_screen.dart';
import './screens/home_screens/notification_screen.dart';
import './screens/account_screen/settings_screen.dart';
import './screens/auth_screens/register_screen.dart';
import './screens/auth_screens/login_screen.dart';
import './screens/auth_screens/mandatory_steps_screen.dart';
import './screens/auth_screens/mandatory_steps/availabilities_steps/availabilities_step_screen.dart';
import './screens/auth_screens/mandatory_steps/payment_progress_services_step/progress_service_screen.dart';
import './screens/auth_screens/mandatory_steps/indicate_skills/skills_selection_screen.dart';
import './screens/auth_screens/mandatory_steps/mister_jobby_insurance_step/mister_jobby_insurance.dart';
import './screens/auth_screens/mandatory_steps/learn_rules/learn_rules_step.dart';
import './screens/auth_screens/mandatory_steps/reliability_score_step/reliability_score_step_screen.dart';
import './screens/auth_screens/mandatory_steps/availabilities_steps/time_availabilities_screen.dart';
import './screens/auth_screens/mandatory_steps/payment_progress_services_step/services_steps_screen.dart';
import './screens/auth_screens/mandatory_steps/mister_jobby_insurance_step/insurance_step_screen.dart';
import './screens/auth_screens/mandatory_steps/learn_rules/rules_step_screen.dart';
import './screens/auth_screens/mandatory_steps/add_profile_pic_step/profile_picture_add.dart';
import './screens/auth_screens/mandatory_steps/valid_identity_documents_step/valid_identity_documents_screen.dart';
import './screens/auth_screens/mandatory_steps/social_security_certificate/social_security_certificate_identification.dart';
import './screens/auth_screens/mandatory_steps/valid_identity_documents_step/european_citizen_identification/european_citizen_identification_screen.dart';
import './screens/auth_screens/mandatory_steps/valid_identity_documents_step/european_citizen_identification/identity_card_upload_screen.dart';
import './screens/auth_screens/mandatory_steps/valid_identity_documents_step/european_citizen_identification/french_driving_license_screen.dart';
import './screens/auth_screens/mandatory_steps/valid_identity_documents_step/european_citizen_identification/european_passport_upload_screen.dart';

import './providers/auth_provider/login_provider.dart';
import './providers/auth_provider/register_provider.dart';
import './providers/mandatory_steps_provider/indicate_skills_provider/indicate_skills_provider.dart';
import './providers/const_provider/const_provider.dart';
import './providers/mandatory_steps_provider/european_identity_verification/european_identification.dart';

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
        ChangeNotifierProvider(create: (ctx) => IndicateSkillsProvider()),
        ChangeNotifierProvider(create: (ctx) => ConstProvider()),
        ChangeNotifierProvider(create: (ctx) => EuropeanIdentificationProvider()),
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
          MyRoutes.SPLASHSCREENROUTE: (ctx) => const SplashScreen(),
          MyRoutes.HOMESCREENROUTE: (ctx) => const HomeTabScreen(),
          MyRoutes.NOTIFICATIONSCREENROUTE: (ctx) =>
              const NotificationDisplay(),
          MyRoutes.SETTINGSCREENROUTE: (ctx) => const SettingScreen(),
          MyRoutes.REGISTERROUTE: (ctx) => const RegisterScreen(),
          MyRoutes.LOGINSCREENROUTE: (ctx) => const LoginScreen(),
          MyRoutes.MANDATORYSTEPSSCREENROUTE: (ctx) =>
              const MandatoryStepsScreen(),
          MyRoutes.AVAILABILITIESSCREENROUTE: (ctx) =>
              const AvailabilitiesScreen(),
          MyRoutes.PROGRESSSERVICESROUTE: (ctx) => const ProgressServices(),
          MyRoutes.INDICATESKILLSROUTE: (ctx) => const SkillsSelectionScreen(),
          MyRoutes.INSURANCESCREENROUTE: (ctx) =>
              const MisterJobbyInsuranceScreen(),
          MyRoutes.LEARNRULESSCREENROUTE: (ctx) => const LearnRulesStepScreen(),
          MyRoutes.RELIABILITYSCOREROUTE: (ctx) =>
              const ReliabilityScoreScreen(),
          MyRoutes.TIMEAVAILABILITYSCREENROUTE: (ctx) =>
              const TimeAvailabilitiesScreen(),
          MyRoutes.SERVICESSTEPSCREENROUTE: (ctx) =>
          const ServicesStepsScreen(),
          MyRoutes.INSURANCESTEPSCREENROUTE: (ctx) =>
          const InsuranceStepScreen(),
          MyRoutes.RULESSTEPSCREENROUTE: (ctx) =>
          const RulesStepScreen(),
          MyRoutes.PROFILEPICTUREADDSCREENROUTE: (ctx) =>
          const ProfilePictureAdd(),
          MyRoutes.VALIDIDENTITYDOCUMENTSCREENROUTE: (ctx) =>
          const ValidIdentityDocuments(),
          MyRoutes.EUROPEANCITIZENIDENTIFICATIONROUTE: (ctx) =>
          const EuropeanCitizenIdentificationScreen(),
          MyRoutes.EUROPEANIDCARDUPLOADROUTE: (ctx) =>
          const IdentityCardUploadScreen(),
          MyRoutes.FRENCHDRIVINGLICENSEROUTE: (ctx) =>
          const FrenchDrivingLicenseScreen(),
          MyRoutes.EUROPEANPASSPORTUPLOADROUTE: (ctx) =>
          const EuropeanPassportUploadScreen(),
          MyRoutes.SOCIALSECURITYCERTIFICATEROUTE: (ctx) =>
          const SocialSecurityCertificate(),
        },
      ),
    );
  }
}
