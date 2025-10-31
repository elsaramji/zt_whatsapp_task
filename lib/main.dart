import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zt_whatsapp_task/core/theme/app_themes.dart';

import 'core/routes/app_routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ScreenUtil.ensureScreenSize();
  await GoogleFonts.pendingFonts();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp.router(
          title: 'ZT WhatsApp Task',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}

class HomeTest extends StatelessWidget {
  const HomeTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ZT WhatsApp Task')),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Screen Width: ${1.sw}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Screen Height: ${1.sh}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            TextField(decoration: InputDecoration(hintText: 'Test Input')),
            ElevatedButton(onPressed: () {}, child: const Text('Test Button')),
          ],
        ),
      ),
    );
  }
}
