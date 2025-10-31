import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zt_whatsapp_task/features/auth/domain/entities/user.dart';

import '../../../../core/routes/app_routes.dart';
import '../cubit/contact_state.dart';
import '../cubit/contacts_cubit.dart';

class SelectContactView extends StatefulWidget {
  const SelectContactView({super.key});

  @override
  State<SelectContactView> createState() => _SelectContactViewState();
}

class _SelectContactViewState extends State<SelectContactView> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => ContactsCubit(),
      child: Builder(
        builder: (context) {
          context.read<ContactsCubit>().getContacts();
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: colors.onSurface),
                onPressed: () => context.pop(),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select contact',
                    style: textTheme.headlineSmall?.copyWith(
                      color: colors.onSurface,
                    ),
                  ),
                  // سيتم تحديث هذا الرقم من الـ Cubit
                  BlocBuilder<ContactsCubit, ContactsState>(
                    builder: (context, state) {
                      if (state is ContactsLoaded) {
                        return Text(
                          '${state.users.length} contacts',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: colors.onSurface,
                    size: 24.sp,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: colors.onSurface,
                    size: 24.sp,
                  ),
                ),
              ],
              backgroundColor: colors.surface,
              elevation: 0,
            ),
            body: BlocBuilder<ContactsCubit, ContactsState>(
              builder: (context, state) {
                if (state is ContactsLoading || state is ContactsInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ContactsError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                if (state is ContactsLoaded) {
                  return ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          child: Text(
                            'Contacts on WhatsApp',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        );
                      }
                      final user = state.users[index];
                      return ContactListTile(user: user);
                    },
                  );
                }
                return const Center(child: Text('Something went wrong.'));
              },
            ),
          );
        },
      ),
    );
  }
}

class ContactListTile extends StatelessWidget {
  const ContactListTile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.push(AppRoutes.chat, extra: user);
        print('Selected contact: ${user.name}');
      },
      leading: CircleAvatar(
        radius: 20.r,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.person, size: 24.sp),
      ),
      title: Text(
        user.name ?? 'No Name',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        user.phone, // يمكنك استبدال هذا بحالة (Status) المستخدم لاحقاً
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
