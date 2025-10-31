import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zt_whatsapp_task/core/routes/app_routes.dart';
import 'package:zt_whatsapp_task/core/theme/app_colors.dart';

import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';

// 1. Simple data model to represent country
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
  final List<Country> countries = [
    Country('Egypt', '20'),
    Country('United States', '1'),
    Country('United Kingdom', '44'),
    Country('Saudi Arabia', '966'),
  ];

  late Country selectedCountry;
  final TextEditingController _countryCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    selectedCountry = countries[0];
    _countryCodeController.text = selectedCountry.code;

    _phoneController.addListener(() {
      setState(() {
        // You can add better validation here (e.g., 10 digits)
        isButtonEnabled = _phoneController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _countryCodeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // --- Function to display SnackBar ---
  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(context).colorScheme.error
            : Colors.green,
      ),
    );
  }

  // --- Function to call Cubit ---
  void _login() {
    // Ensure button is enabled and state is not loading
    if (!isButtonEnabled) return;

    final phoneNumber =
        '${_countryCodeController.text}${_phoneController.text}';

    // Call Cubit function
    context.read<AuthCubit>().loginUser(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
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
              onPressed: () {},
              icon: Icon(Icons.more_vert, color: colors.onSurface),
            ),
          ],
        ),
        // --- 2. استخدام BlocListener للاستماع للتغييرات ---
        // هذا مثالي لإظهار الـ SnackBar أو الانتقال بين الشاشات
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              // 2a. حالة النجاح: إظهار SnackBar أخضر
            //  _showSnackBar('Login Successful! User ID: ${state.user.id}');
              // TODO: الانتقال إلى الشاشة الرئيسية
              // Navigator.of(context).pushReplacement(...);
              context.go(AppRoutes.home);
            } else if (state is AuthFailure) {
              // 2b. حالة الفشل: إظهار SnackBar أحمر
              _showSnackBar(state.errorMessage, isError: true);
            }
          },
          child: Padding(
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
                  onPressed: () {},
                  child: Text(
                    "What's my number?",
                    style: textTheme.bodyLarge?.copyWith(
                      color: AppColors.blueLink,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),

                // ... (DropdownButtonFormField الخاص بالدولة - لا تغيير هنا)
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
                      _countryCodeController.text = selectedCountry.code;
                    });
                  },
                  decoration: InputDecoration(
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
                  dropdownColor: colors.surface,
                  style: textTheme.bodyLarge?.copyWith(color: colors.onSurface),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.primary,
                  ),
                ),

                SizedBox(height: 12.h),

                // ... (Row الخاص بأكواد الهاتف - لا تغيير هنا)
                Row(
                  children: [
                    SizedBox(
                      width: 70.w,
                      child: TextField(
                        controller: _countryCodeController,
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

                // --- 3. استخدام BlocBuilder لتغيير الزر ---
                // هذا مثالي لتغيير شكل الواجهة (مثل إظهار التحميل)
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    // 3a. التحقق إذا كانت الحالة هي "تحميل"
                    final isLoading = state is AuthLoading;

                    return ElevatedButton(
                      onPressed: (isButtonEnabled && !isLoading)
                          ? () {
                              // التأكد من أن الزر مفعل والحالة ليست تحميل
                              if (!isButtonEnabled) return;

                              final phoneNumber =
                                  '${_countryCodeController.text}${_phoneController.text}';

                              // استدعاء دالة الـ Cubit
                              context.read<AuthCubit>().loginUser(phoneNumber);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: Size(1.sw, 32.h),
                      ),
                      // 3b. تغيير محتوى الزر بناءً على حالة التحميل
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            )
                          : const Text('Next'),
                    );
                  },
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
