import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zt_whatsapp_task/core/theme/app_colors.dart';

import '../../../chats/presentation/views/chats_view.dart';
import '../../../status/persentation/views/updatas_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // 1. قائمة الشاشات التي سيتم التبديل بينها
  final List<Widget> _pages = [const ChatsView(), const UpdatesView()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WhatsApp',
          style: textTheme.headlineSmall?.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement Camera Action
            },
            icon: Icon(
              Icons.camera_alt_outlined,
              color: colors.onSurface,
              size: 24.sp,
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO: Implement More Options Menu
            },
            icon: Icon(Icons.more_vert, color: colors.onSurface, size: 24.sp),
          ),
        ],
        backgroundColor: colors.surface, // استخدام لون السطح من الثيم
        elevation: 0,
      ),
      // 2. IndexedStack يحافظ على حالة الشاشات عند التبديل
      body: IndexedStack(index: _selectedIndex, children: _pages),
      // 3. شريط التنقل السفلي
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          // 4. العنصر الأول: Chats
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline, size: 24.sp),
            activeIcon: Icon(Icons.chat_bubble, size: 24.sp),
            label: 'Chats',
          ),
          // 5. العنصر الثاني: Updates
          BottomNavigationBarItem(
            icon: Icon(Icons.update_outlined, size: 24.sp),
            activeIcon: Icon(Icons.update, size: 24.sp),
            label: 'Updates', 
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        // --- 6. تطبيق التصميم (Styling) ---
        backgroundColor: colors.surface,
        type: BottomNavigationBarType.fixed, // يضمن ثبات الخلفية
        selectedItemColor: AppColors.primary, // لون الأيقونة النشطة
        unselectedItemColor: AppColors.grey, // لون الأيقونات غير النشطة
        showSelectedLabels: true, // إظهار التسمية للنشط
        showUnselectedLabels: true, // إظهار التسمية لغير النشط
        selectedFontSize: 16.sp,
        unselectedFontSize: 16.sp,
      ),
    );
  }
}
