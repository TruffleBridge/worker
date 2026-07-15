import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/presentation/pages/client_pages/create_profile/create_profile_page.dart';
import 'package:nimora_worker/presentation/pages/client_pages/home/client_home_shell.dart';
import 'package:nimora_worker/presentation/pages/client_pages/job_post/job_post_page.dart';
import 'package:nimora_worker/presentation/pages/client_pages/login/login_page.dart';
import 'package:nimora_worker/presentation/pages/client_pages/sign_in/sign_in_splash_page.dart';
import 'package:nimora_worker/presentation/pages/client_pages/worker_details/worker_detail_page.dart';
import 'package:nimora_worker/presentation/pages/worker_pages/ai_assistant/AiAssistantPage.dart';
import 'package:nimora_worker/presentation/pages/worker_pages/home/home_shell.dart';
import 'package:nimora_worker/presentation/pages/worker_pages/location/location_screen.dart';
import 'package:nimora_worker/presentation/pages/worker_pages/login/login_page.dart';
import 'package:nimora_worker/presentation/pages/worker_pages/onboarding/choose_roles_page.dart';
import 'package:nimora_worker/presentation/pages/worker_pages/onboarding/onboarding_page.dart';
import 'package:nimora_worker/presentation/pages/worker_pages/sign_in_splash/sign_in_splash_page.dart';
import 'package:nimora_worker/presentation/pages/worker_pages/splash/splash_page.dart';
import 'package:nimora_worker/presentation/pages/client_pages/login/client_otp_page.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/job_post/job_post_success_widget.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/account_setting_page.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/byo_clients_page.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/incident_reports_page.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/notifications_page.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/payment_info_page.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/payslips_page.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/rewards_page.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/security_page.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/service_notes_page.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/support_worker_resources_page.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/verifications_page.dart';

abstract class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String chooseRole = '/choose-role';

  //Worker
  static const String signInSplash = '/worker-sign-in-splash';
  static const String login = '/worker-login';
  static const String register = '/worker-register';
  static const String forgotPassword = '/worker-forgot-password';
  static const String definePassword = '/worker-define-password';
  static const String home = '/worker-home';
  static const String aiAssistant = '/worker-ai-assistant';
  static const String account = '/worker-account';
  static const String security = '/worker-security';
  static const String notifications = '/worker-notifications';
  static const String paymentInfo = '/worker-payment-info';
  static const String addBankAccount = '/worker-add-bank-account';
  static const String paymentSuccess = '/worker-payment-success';
  static const String payslips = '/worker-payslips';
  static const String payslipDetail = '/worker-payslip-detail';
  static const String verifications = '/worker-verifications';
  static const String addVerifications = '/worker-add-verifications';
  static const String supportWorkerResources =
      '/worker-support-worker-resources';
  static const String serviceNotes = '/worker-service-notes';
  static const String incidentReports = '/worker-incident-reports';
  static const String incidentForm = '/worker-incident-form';
  static const String myRewards = '/worker-my-rewards';
  static const String byoClients = '/worker-byo-clients';
  static const String locationScreen = '/location-screen';

  //Client
  static const String clientSignInSplash = '/client-sign-in-splash';
  static const String clientLogin = '/client-login';
  static const String clientOtpScreen = '/client-otp-screen';
  static const String clientHome = '/client-home';
  static const String clientCreateProfile = '/client-create-profile';
  static const String clientJobPost = '/job-post';
  static const String workerDetail = '/client-worker-detail';
  static const String jobPostSuccess = '/job-post-success';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SplashPage(),
        transitionsBuilder: _fadeTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.chooseRole,
      name: 'chooseRole',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ChooseRolePage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      name: 'onboarding',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const OnboardingPage(),
        transitionsBuilder: _fadeTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.locationScreen,
      name: 'location-screen',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const LocationScreen(),
        transitionsBuilder: _fadeTransition,
      ),
    ),

    //Worker
    GoRoute(
      path: AppRoutes.signInSplash,
      name: 'workerSignInSplash',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const WorkerSignInSplashPage(),
        transitionsBuilder: _fadeTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'workerLogin',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const LoginPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    // GoRoute(
    //   path: AppRoutes.register,
    //   name: 'register',
    //   pageBuilder: (context, state) => CustomTransitionPage(
    //     key: state.pageKey,
    //     child: const RegisterPage(),
    //     transitionsBuilder: _slideTransition,
    //   ),
    // ),
    // GoRoute(
    //   path: AppRoutes.forgotPassword,
    //   name: 'forgotPassword',
    //   pageBuilder: (context, state) => CustomTransitionPage(
    //     key: state.pageKey,
    //     child: const ForgotPasswordPage(),
    //     transitionsBuilder: _slideTransition,
    //   ),
    // ),
    // GoRoute(
    //   path: AppRoutes.definePassword,
    //   name: 'definePassword',
    //   pageBuilder: (context, state) {
    //     final token = state.uri.queryParameters['token'] ?? '';
    //     return CustomTransitionPage(
    //       key: state.pageKey,
    //       child: DefineNewPasswordPage(token: token),
    //       transitionsBuilder: _slideTransition,
    //     );
    //   },
    // ),
    GoRoute(
      path: AppRoutes.home,
      name: 'workerHome',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomeShellPage(),
        transitionsBuilder: _fadeTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.aiAssistant,
      name: 'workerAiAssistant',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const AiAssistantPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.account,
      name: 'workerAccount',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const AccountPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.security,
      name: 'workerSecurity',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SecurityPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.notifications,
      name: 'workerNotifications',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const NotificationsPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.paymentInfo,
      name: 'workerPaymentInfo',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const PaymentInfoPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.addBankAccount,
      name: 'workerAddBankAccount',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const AddBankAccountPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.paymentSuccess,
      name: 'workerPaymentSuccess',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const PaymentSuccessPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.payslips,
      name: 'workerPayslips',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const PayslipsPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.payslipDetail,
      name: 'workerPayslipDetail',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const PayslipDetailPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.verifications,
      name: 'workerVerifications',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const VerificationsPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.addVerifications,
      name: 'workerAddVerifications',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const AddVerificationPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.supportWorkerResources,
      name: 'workerSupportWorkerResources',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SupportWorkerResourcesPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.serviceNotes,
      name: 'workerServiceNotes',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ServiceNotesPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.incidentReports,
      name: 'workerIncidentReports',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const IncidentReportsPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.incidentForm,
      name: 'workerIncidentForm',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const IncidentFormPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.myRewards,
      name: 'workerMyRewards',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const MyRewardsPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.byoClients,
      name: 'workerByoClients',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ByoClientsPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    //Client
    GoRoute(
      path: AppRoutes.clientSignInSplash,
      name: 'clientSignInSplash',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ClientSignInSplashPage(),
        transitionsBuilder: _fadeTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.clientLogin,
      name: 'clientLogin',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ClientLoginPage(),
        transitionsBuilder: _fadeTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.clientOtpScreen,
      name: 'clientOtpScreen',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ClientOtpScreen(),
        transitionsBuilder: _fadeTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.clientHome,
      name: 'clientHome',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ClientHomeShellPage(),
        transitionsBuilder: _fadeTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.clientJobPost,
      name: 'clientJobPost',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const JobPostPage(),
        transitionsBuilder: _fadeTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.workerDetail,
      name: 'workerDetail',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const WorkerDetailPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.clientCreateProfile,
      name: 'clientCreateProfile',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const CreateProfilePage(),
        transitionsBuilder: _fadeTransition,
      ),
    ),
    GoRoute(
      path: AppRoutes.jobPostSuccess,
      name: 'jobPostSuccess',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const JobPostSuccessScreen(),
        transitionsBuilder: _fadeTransition,
      ),
    ),
  ],
);

Widget _fadeTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) => FadeTransition(opacity: animation, child: child);

Widget _slideTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) => SlideTransition(
  position: Tween<Offset>(
    begin: const Offset(1.0, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
  child: child,
);
