import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zt_whatsapp_task/core/theme/app_colors.dart';
import 'package:zt_whatsapp_task/features/auth/data/source/firebase_data_source.dart';
import 'package:zt_whatsapp_task/features/auth/domain/usecase/sign_in_usecase.dart';

import '../../data/repos/auth_repo_impl.dart';

// 1. نموذج بيانات بسيط لتمثيل الدولة
class Country {
  final String name;
  final String code;

  Country(this.name, this.code);
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 2. قائمة مؤقتة (Mock List) بالدول
  // في تطبيق حقيقي، ستقوم بجلب هذه القائمة من مصدر بيانات
  final List<Country> countries = [
    Country('Egypt', '20'),
    Country('United States', '1'),
    Country('United Kingdom', '44'),
    Country('Saudi Arabia', '966'),
  ];

  // 3. متغيرات الحالة (State Variables)
  late Country selectedCountry; // لتخزين الدولة المختارة
  final TextEditingController _countryCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    // 4. ضبط القيمة الأولية
    selectedCountry = countries[0]; // تعيين "Egypt" كقيمة افتراضية
    _countryCodeController.text = selectedCountry.code;

    _phoneController.addListener(() {
      setState(() {
        isButtonEnabled = _phoneController.text.length > 9; // مثال بسيط للتحقق
      });
    });
  }

  @override
  void dispose() {
    _countryCodeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter your phone number',
          style: textTheme.headlineSmall?.copyWith(color: colors.onSurface),
        ),
        centerTitle: true,
        backgroundColor: colors.surface,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement more options menu
            },
            icon: Icon(Icons.more_vert, color: colors.onSurface),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'WhatsApp will need to verify your phone number.',
              style: textTheme.bodyLarge?.copyWith(color: colors.onSurface),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5.h),
            TextButton(
              onPressed: () {
                // TODO: Implement "What's my number?"
              },
              child: Text(
                "What's my number?",
                style: textTheme.bodyLarge?.copyWith(color: AppColors.blueLink),
              ),
            ),
            SizedBox(height: 30.h),

            // 5. استخدام DropdownButtonFormField بدلاً من TextField
            DropdownButtonFormField<Country>(
              initialValue: selectedCountry,
              items: countries.map((Country country) {
                return DropdownMenuItem<Country>(
                  value: country,
                  child: Text(country.name),
                );
              }).toList(),
              onChanged: (Country? newValue) {
                setState(() {
                  selectedCountry = newValue!;
                  // 6. تحديث كود الدولة تلقائياً
                  _countryCodeController.text = selectedCountry.code;
                });
              },
              // 7. تطبيق التصميم (Styling)
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary, width: 2.w),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary, width: 2.w),
                ),
              ),
              dropdownColor:
                  colors.surface, // لون الخلفية للقائمة في الوضع المظلم
              style: textTheme.bodyLarge?.copyWith(color: colors.onSurface),
              icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
            ),

            SizedBox(height: 12.h),

            Row(
              children: [
                SizedBox(
                  width: 70.w,
                  child: TextField(
                    controller: _countryCodeController,
                    // 8. جعل حقل الكود للقراءة فقط (ReadOnly)
                    readOnly: true,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colors.onSurface,
                    ),
                    decoration: InputDecoration(
                      prefixText: '+ ',
                      prefixStyle: textTheme.bodyLarge?.copyWith(
                        color: colors.onSurface,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 2.w,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 2.w,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colors.onSurface,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Phone number',
                      hintStyle: textTheme.bodyLarge?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 2.w,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 2.w,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: isButtonEnabled
                  ? () {
                      
                        SignInUseCase(AuthRepoImpl(FirebaseDataSourceImpl())).call(
                          '${_countryCodeController.text}${_phoneController.text}',
                        );
                    
                      // TODO: استدعاء usecase المصادقة
                      /*  print(
                        'Sending OTP to +${_countryCodeController.text}${_phoneController.text}',
                        );*/
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: Size(1.sw, 32.h),
              ),
              child: const Text('Next'),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
