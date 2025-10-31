import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/dummy_status_model.dart';

class StatusViewScreen extends StatefulWidget {
  final List<DemoStatus> allStatuses;
  final int initialStatusIndex;

  const StatusViewScreen({
    super.key,
    required this.allStatuses,
    required this.initialStatusIndex,
  });

  @override
  State<StatusViewScreen> createState() => _StatusViewScreenState();
}

class _StatusViewScreenState extends State<StatusViewScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late int _currentUserIndex;
  late int _currentStoryIndex;

  @override
  void initState() {
    super.initState();
    _currentUserIndex = widget.initialStatusIndex;
    _currentStoryIndex = 0;

    _pageController = PageController(initialPage: _currentUserIndex);

    // 1. Initialize the 5-second timer
    _animationController = AnimationController(
      vsync: this,
      duration: widget.allStatuses[_currentUserIndex].stories[0].duration,
    );

    // 2. Add listener for navigation control
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextStory(); // When timer completes, move to next story
      }
    });

    _loadStory(animate: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // --- Function to load a new story ---
  void _loadStory({bool animate = true}) {
    _animationController.stop();
    _animationController.reset();

    final story =
        widget.allStatuses[_currentUserIndex].stories[_currentStoryIndex];
    _animationController.duration = story.duration;

    if (animate) {
      _animationController.forward();
    }
  }

  // --- Navigation to next story ---
  void _nextStory() {
    final currentUser = widget.allStatuses[_currentUserIndex];
    if (_currentStoryIndex < currentUser.stories.length - 1) {
      // If there are remaining stories for the same user
      setState(() {
        _currentStoryIndex++;
      });
      _loadStory();
    } else {
      // If this is the last story, move to next user
      _nextUser();
    }
  }

  // --- Navigation to previous story ---
  void _prevStory() {
    if (_currentStoryIndex > 0) {
      // If there are previous stories for the same user
      setState(() {
        _currentStoryIndex--;
      });
      _loadStory();
    } else {
      // If this is the first story, move to previous user
      _prevUser();
    }
  }

  // --- Navigation to next user (by swiping) ---
  void _nextUser() {
    if (_currentUserIndex < widget.allStatuses.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Last user, close the screen
      context.pop();
    }
  }

  // --- Navigation to previous user (by swiping) ---
  void _prevUser() {
    if (_currentUserIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // First user, close the screen
      context.pop();
    }
  }

  // --- Handling tap (right/left/center) ---
  void _onTapUp(TapUpDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    if (dx < screenWidth / 3) {
      // Tap on left third
      _prevStory();
    } else if (dx > screenWidth * 2 / 3) {
      // Tap on right third
      _nextStory();
    } else {
      // Tap in the middle (pause/play) - not used in WhatsApp
      // if (_animationController.isAnimating) {
      //   _animationController.stop();
      // } else {
      //   _animationController.forward();
      // }
    }
  }

  // --- Handling long press (pause) ---
  void _onLongPressStart(LongPressStartDetails details) {
    _animationController.stop();
  }

  // --- Handling finger lift (resume) ---
  void _onLongPressEnd(LongPressEndDetails details) {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapUp: _onTapUp,
        onLongPressStart: _onLongPressStart,
        onLongPressEnd: _onLongPressEnd,
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.allStatuses.length,
          // Called when changing user (by swiping)
          onPageChanged: (index) {
            setState(() {
              _currentUserIndex = index;
              _currentStoryIndex = 0; // Start from the first story for the new user
            });
            _loadStory();
          },
          itemBuilder: (context, userIndex) {
            final status = widget.allStatuses[userIndex];
            final story = status.stories[_currentStoryIndex];

            return Stack(
              fit: StackFit.expand,
              children: [
                // --- 1. Display image ---
                Image.network(
                  story.url,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),

                // --- 2. Progress bar and info ---
                _StoryHeader(
                  animationController: _animationController,
                  status: status,
                  currentStoryIndex: _currentStoryIndex,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// --- Header widget (progress bars + user info) ---
class _StoryHeader extends StatelessWidget {
  final AnimationController animationController;
  final DemoStatus status;
  final int currentStoryIndex;

  const _StoryHeader({
    required this.animationController,
    required this.status,
    required this.currentStoryIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- 1. Progress bars ---
          Row(
            children: List.generate(
              status.stories.length,
              (index) => Expanded(
                child: _ProgressBar(
                  animationController: animationController,
                  storyIndex: index,
                  currentStoryIndex: currentStoryIndex,
                ),
              ),
            ),
          ),
          // --- 2. User information ---
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(status.userAvatarUrl),
            ),
            title: Text(
              status.userName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            subtitle: Text(
              '${status.timestamp.hour}:${status.timestamp.minute.toString().padLeft(2, '0')}',
              style: TextStyle(color: Colors.grey[300], fontSize: 14.sp),
            ),
            trailing: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 28.sp),
              onPressed: () => context.pop(),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Single progress bar widget ---
class _ProgressBar extends StatelessWidget {
  final AnimationController animationController;
  final int storyIndex;
  final int currentStoryIndex;

  const _ProgressBar({
    required this.animationController,
    required this.storyIndex,
    required this.currentStoryIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.5.h,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          double value;
          if (storyIndex < currentStoryIndex) {
            value = 1.0; // Previous story (completed)
          } else if (storyIndex == currentStoryIndex) {
            value = animationController.value; // Current story (in progress)
          } else {
            value = 0.0; // Upcoming story (empty)
          }

          return LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.white.withOpacity(0.4),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 2.5.h,
          );
        },
      ),
    );
  }
}
