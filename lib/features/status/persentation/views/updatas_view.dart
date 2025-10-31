import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zt_whatsapp_task/core/routes/app_routes.dart';
import 'package:zt_whatsapp_task/core/theme/app_colors.dart';

import '../../data/models/dummy_status_model.dart';

class UpdatesView extends StatelessWidget {
  const UpdatesView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Split data: First element is "My Status", the rest are "Recent" updates
    final myStatus = DUMMY_STATUSES[0];
    final recentUpdates = DUMMY_STATUSES.sublist(1);

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        children: [
          // --- 1. "My Status" section ---
          _MyStatusTile(status: myStatus),

          // --- 2. "Recent Updates" divider ---
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Text(
              'Recent updates',
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // --- 3. Recent status updates list ---
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentUpdates.length,
            itemBuilder: (context, index) {
              final status = recentUpdates[index];
              return _StatusUpdateTile(
                status: status,
                onTap: () {
                  // When tapped, navigate to status view screen
                  context.push(
                    AppRoutes.statusView,
                    extra: {
                      'statuses': DUMMY_STATUSES, // Send complete status list
                      'index':
                          index +
                          1, // Send tapped index (adding 1 since we removed 'My Status')
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      // --- 4. FAB buttons for adding status ---
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            onPressed: () {
              // TODO: Implement text status logic
            },
            heroTag: 'text_status',
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            child: const Icon(Icons.edit),
          ),
          SizedBox(height: 16.h),
          FloatingActionButton(
            onPressed: () {
              // TODO: Implement camera status logic
            },
            heroTag: 'camera_status',
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}

// --- "My Status" widget ---
class _MyStatusTile extends StatelessWidget {
  final DemoStatus status;
  const _MyStatusTile({required this.status});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        alignment: Alignment.bottomRight,
        children: [
          _StatusAvatar(
            avatarUrl: status.userAvatarUrl,
            hasUnseenStories: false, // My status is always "seen"
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: 2.w,
              ),
            ),
            child: Icon(Icons.add, color: Colors.white, size: 16.sp),
          ),
        ],
      ),
      title: Text(
        'My status',
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'Tap to add status update',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      onTap: () {
        // --- (Modification start) ---
        // When tapped, navigate to my status view screen
        context.push(
          AppRoutes.statusView,
          extra: {
            'statuses': DUMMY_STATUSES, // Send complete status list
            'index': 0, // Send index for "My Status" which is 0
          },
        );
        // --- (Modification end) ---
      },
    );
  }
}

// --- Widget for displaying another user's status ---
class _StatusUpdateTile extends StatelessWidget {
  final DemoStatus status;
  final VoidCallback onTap;

  const _StatusUpdateTile({required this.status, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _StatusAvatar(
        avatarUrl: status.userAvatarUrl,
        hasUnseenStories: true, // By default, all are unseen
      ),
      title: Text(
        status.userName,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '${status.timestamp.hour}:${status.timestamp.minute.toString().padLeft(2, '0')}',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      onTap: onTap,
    );
  }
}

// --- Avatar widget with green ring ---
class _StatusAvatar extends StatelessWidget {
  final String avatarUrl;
  final bool hasUnseenStories;

  const _StatusAvatar({
    required this.avatarUrl,
    required this.hasUnseenStories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: hasUnseenStories ? AppColors.primary : Colors.grey.shade400,
          width: 2.5.w,
        ),
      ),
      child: CircleAvatar(
        radius: 24.r,
        backgroundImage: NetworkImage(avatarUrl),
      ),
    );
  }
}
