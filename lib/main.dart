import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mister_jobby_jobber/providers/auth_provider/forget_password_provider.dart';
import 'package:mister_jobby_jobber/providers/jobs_providers/single_job_comments_provider.dart';
import 'package:mister_jobby_jobber/screens/search_screen/comment_screen.dart';
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
import './screens/auth_screens/mandatory_steps/availabilities_steps/friday_availability_screen.dart';
import './screens/auth_screens/mandatory_steps/availabilities_steps/saturday_availability_screen.dart';
import './screens/auth_screens/mandatory_steps/availabilities_steps/sunday_availability_screen.dart';
import './screens/auth_screens/mandatory_steps/availabilities_steps/thursday_availability_screen.dart';
import './screens/auth_screens/mandatory_steps/availabilities_steps/tuesday_availability_screen.dart';
import './screens/auth_screens/mandatory_steps/availabilities_steps/wednesday_availability_screen.dart';
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
import './screens/auth_screens/mandatory_steps/social_security_certificate/vital_card_upload_screen.dart';
import './screens/auth_screens/mandatory_steps/social_security_certificate/social_security_certificate_upload.dart';
import './screens/auth_screens/mandatory_steps/valid_identity_documents_step/non_european_citizen/non_european_citizen_identification.dart';
import './screens/auth_screens/mandatory_steps/valid_identity_documents_step/non_european_citizen/work_permit_upload.dart';
import './screens/auth_screens/mandatory_steps/personal_information/personal_information_screen.dart';
import './screens/account_screen/get_badges/badge_pro_screen.dart';
import './screens/account_screen/get_badges/get_badge_pro_screen.dart';
import './screens/home_screens/calender_event.dart';
import './screens/search_screen/area_of_intervention.dart';
import './screens/account_screen/settings/others_settings/about_us.dart';
import './screens/account_screen/settings/others_settings/help_center.dart';
import './screens/account_screen/settings/others_settings/insurance.dart';
import './screens/account_screen/settings/others_settings/tax_credit.dart';
import './screens/account_screen/settings/others_settings/term_and_conditions.dart';
import './screens/account_screen/settings/others_settings/trust_and_security.dart';
import './screens/account_screen/settings/others_settings/faq_screen.dart';
import './screens/account_screen/settings/others_settings/manage_notifications.dart';

import './providers/auth_provider/login_provider.dart';
import './providers/auth_provider/register_provider.dart';
import './providers/mandatory_steps_provider/indicate_skills_provider/indicate_skills_provider.dart';
import './providers/const_provider/const_provider.dart';
import './providers/mandatory_steps_provider/european_identity_verification/european_identification.dart';
import './providers/mandatory_steps_provider/social_security/social_security_provider.dart';
import './providers/mandatory_steps_provider/personal_information_provider/personal_information_provider.dart';
import './providers/jobs_providers/job_details_provider.dart';
import './providers/preferences_provider/preferences_provider.dart';
import './providers/mandatory_steps_provider/time_availability_provider/availability_provider.dart';
import './providers/mandatory_steps_provider/service_provider/services_provider.dart';
import './providers/mandatory_steps_provider/insurance_provider/insurance_provider.dart';
import './providers/mandatory_steps_provider/rules_provider/rules_provider.dart';
import './providers/mandatory_steps_provider/non_european_identification_provider/non_euro_identification_provider.dart';
import './providers/mandatory_steps_provider/profile_image_provider/profile_image_provider.dart';
import './providers/jobs_providers/area_of_intervention_provider/area_intervention_provider.dart';
import './providers/check_profile_completion_provider/check_profile_completion_provider.dart';
import './providers/reliability_score_provider/reliability_score_provider.dart';
import './providers/faq_provider.dart';
import './providers/accounts_providers/about_provider/about_provider.dart';
import './providers/accounts_providers/terms_and_condition_provider/terms_and_condition_provider.dart';
import './providers/jobs_providers/available_jobs_provider/available_jobs_provider.dart';
import 'providers/notifications_provider/notifications_provider.dart';


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
        ChangeNotifierProvider(create: (ctx) => SocialSecurityProvider()),
        ChangeNotifierProvider(create: (ctx) => PersonalInformationProvider()),
        ChangeNotifierProvider(create: (ctx) => JobsDetailProvider()),
        ChangeNotifierProvider(create: (ctx) => PreferencesProvider()),
        ChangeNotifierProvider(create: (ctx) => AvailabilityProvider()),
        ChangeNotifierProvider(create: (ctx) => ServicesProvider()),
        ChangeNotifierProvider(create: (ctx) => InsuranceProvider()),
        ChangeNotifierProvider(create: (ctx) => RulesProvider()),
        ChangeNotifierProvider(create: (ctx) => ProfileImageProvider()),
        ChangeNotifierProvider(create: (ctx) => NonEuroIdentificationProvider()),
        ChangeNotifierProvider(create: (ctx) => AreaInterventionProvider()),
        ChangeNotifierProvider(create: (ctx) => CheckProfileCompletionProvider()),
        ChangeNotifierProvider(create: (ctx) => ReliabilityScoreProvider()),
        ChangeNotifierProvider(create: (ctx) => FAQProvider()),
        ChangeNotifierProvider(create: (ctx) => AboutProvider()),
        ChangeNotifierProvider(create: (ctx) => TermsAndConditonProvider()),
        ChangeNotifierProvider(create: (ctx) => AvailableJobsProvider()),
        ChangeNotifierProvider(create: (ctx) => NotificationsProvider()),
        ChangeNotifierProvider(create: (ctx) => SingleJobCommentsProvider()),
        ChangeNotifierProvider(create: (ctx) => ForgetPasswordProvider()),
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
          MyRoutes.MONDAYTIMEAVAILABILITY: (ctx) =>
              const MondayTimeAvailabilityScreen(),
          MyRoutes.TUESDAYTIMEAVAILABILITY: (ctx) =>
          const TuesdayTimeAvailabilityScreen(),
          MyRoutes.WEDNESDAYTIMEAVAILABILITY: (ctx) =>
          const WednesdayTimeAvailabilityScreen(),
          MyRoutes.THURSDAYTIMEAVAILABILITY: (ctx) =>
          const ThursdayAvailabilityScreen(),
          MyRoutes.FRIDAYTIMEAVAILABILITY: (ctx) =>
          const FridayAvailabilityScreen(),
          MyRoutes.SATURDAYTIMEAVAILABILITY: (ctx) =>
          const SaturdayAvailabilityScreen(),
          MyRoutes.SUNDAYTIMEAVAILABILITY: (ctx) =>
          const SundayAvailabilityScreen(),
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
          MyRoutes.VITALCARDUPLOADEROUTE: (ctx) =>
          const VitalCardUpload(),
          MyRoutes.SECURITYCARDUPLOADEROUTE: (ctx) =>
          const SocialSecurityCertificateUpload(),
          MyRoutes.NONEUROPEANCITIZENROUTE: (ctx) =>
          const NonEuropeanCitizen(),
          MyRoutes.WORKPERMITSCREENROUTE: (ctx) =>
          const WorkPermitUpload(),
          MyRoutes.PERSONALINFORMATIONSCREENROUTE: (ctx) =>
          const PersonalInformationScreen(),
          MyRoutes.BADGEPROSCREENROUTE: (ctx) =>
          const BadgeProScreen(),
          MyRoutes.GETBADGEPROSCREENROUTE: (ctx) =>
          const GetBadgeProScreen(),
          MyRoutes.EVENTCALENDERSCREENROUTE: (ctx) =>
          const EventCalender(),
          MyRoutes.RADIUSINTERVENTIONSCREENROUTE: (ctx) =>
          const AreaOfInterventionScreen(),
          MyRoutes.ABOUTUSSCREENROUTE: (ctx) =>
          const AboutUsScreen(),
          MyRoutes.HELPCENTERSCREENROUTE: (ctx) =>
          const HelpCenter(),
          MyRoutes.INSURANCESETTINGSCREENROUTE: (ctx) =>
          const Insurance(),
          MyRoutes.MANAGENOTIFICATIONSSCREENROUTE: (ctx) =>
          const ManageNotifications(),
          MyRoutes.TAXCREDITSCREENROUTE: (ctx) =>
          const TaxCredit(),
          MyRoutes.TERMSANDCONDITIONSSCREENROUTE: (ctx) =>
          const TermsAndCondition(),
          MyRoutes.TRUSTANDSECURITYSCREENROUTE: (ctx) =>
          const TrustAndSecurity(),
          MyRoutes.FAQSCREENROUTE: (ctx) =>
          const FAQScreen(),
          MyRoutes.COMMENTSCREENROUTE: (ctx) =>
          const CommentScreen(),
        },
      ),
    );
  }
}
