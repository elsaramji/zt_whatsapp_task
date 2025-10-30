import 'package:flutter/material.dart';

class UpdatesView extends StatelessWidget {
  const UpdatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Updates View (Placeholder)',
          style: TextStyle(color: Colors.white70),
        ),
      ),
      // 2. يمكنك إضافة FAB مختلف هنا (مثل أيقونة الكاميرا) إذا أردت
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // TODO: Implement new status action
      //   },
      //   child: const Icon(Icons.camera_alt),
      // ),
    );
  }
}
