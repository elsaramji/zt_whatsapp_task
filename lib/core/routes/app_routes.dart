import 'package:go_router/go_router.dart';
import 'package:zt_whatsapp_task/features/auth/presentation/views/login_view.dart';
import 'package:zt_whatsapp_task/features/auth/presentation/views/welecome_view.dart';
import '../../features/home/persentation/views/home_view.dart';




class AppRouter {
  // 2. إعداد الراوتر
  static final GoRouter router = GoRouter(
    // 3. تحديد المسار الأولي
    initialLocation: AppRoutes.welcome,

    // 4. تعريف جميع المسارات
    routes: [
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      // TODO: إضافة مسارات أخرى هنا (مثل /otp, /home, /chat)
    ],
  );
}

// 5. مكان مركزي لأسماء المسارات لتجنب الأخطاء الإملائية
class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String home = '/home';
}
