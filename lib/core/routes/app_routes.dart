import 'package:go_router/go_router.dart';
import 'package:zt_whatsapp_task/features/auth/data/models/user_model.dart';
import 'package:zt_whatsapp_task/features/auth/presentation/views/login_view.dart';
import 'package:zt_whatsapp_task/features/auth/presentation/views/welecome_view.dart';
import 'package:zt_whatsapp_task/features/chats/presentation/views/chat_diplay_view.dart';
import 'package:zt_whatsapp_task/features/home/persentation/views/get_contacts_view.dart';
import 'package:zt_whatsapp_task/features/status/data/models/dummy_status_model.dart';

import '../../features/chats/data/models/chat_model.dart';
import '../../features/chats/presentation/views/chat_view_creator.dart';
import '../../features/home/persentation/views/home_view.dart';
import '../../features/status/persentation/views/status_player_view.dart';

class AppRouter {
  // 2. Router setup
  static final GoRouter router = GoRouter(
    // 3. Define initial path
    initialLocation: AppRoutes.home,

    // 4. Define all routes
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
      // TODO: Add other routes here (like /otp, /home, /chat)
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
      GoRoute(
        path: AppRoutes.displayChat,
        builder: (context, state) =>
            ChatDispalyView(chat: state.extra as ChatModel),
      ),
      GoRoute(
        path: AppRoutes.statusView,
        builder: (context, state) {
          // استلام البيانات التي أرسلناها (الخريطة)
          final data = state.extra as Map<String, dynamic>;

          return StatusViewScreen(
            allStatuses: data['statuses'] as List<DemoStatus>,
            initialStatusIndex: data['index'] as int,
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
  static String displayChat = '/displaychat';
  static const String statusView = '/status';
}
