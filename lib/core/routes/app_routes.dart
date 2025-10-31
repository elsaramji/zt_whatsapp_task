import 'package:go_router/go_router.dart';
import 'package:zt_whatsapp_task/features/auth/data/models/user_model.dart';
import 'package:zt_whatsapp_task/features/auth/presentation/views/login_view.dart';
import 'package:zt_whatsapp_task/features/auth/presentation/views/welecome_view.dart';
import 'package:zt_whatsapp_task/features/home/persentation/views/get_contacts_view.dart';

import '../../features/chats/presentation/views/chat_view_creator.dart';
import '../../features/home/persentation/views/home_view.dart';

class AppRouter {
  // 2. إعداد الراوتر
  static final GoRouter router = GoRouter(
    // 3. تحديد المسار الأولي
    initialLocation: AppRoutes.login,

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
      GoRoute(
        path: AppRoutes.getContacts,
        builder: (context, state) => const SelectContactView(),
      ),
      GoRoute(
        path: AppRoutes.chat,
        builder: (context, state) {
          final user = state.extra as UserModel;
          return ChatDetailView(
            chatId: user.id,
            receiverId: user.id,
            user: user,
          );
        },
      ),
    ],
  );
}

// 5. مكان مركزي لأسماء المسارات لتجنب الأخطاء الإملائية
class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String getContacts = '/getcontacts';
  static String chat = '/chat';
}
