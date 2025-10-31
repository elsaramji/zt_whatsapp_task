import 'package:flutter/material.dart';

// 1. Represents a single story (image or video)
class DemoStory {
  final String url; // Image link
  final Duration duration;
  final MediaType mediaType;

  DemoStory({
    required this.url,
    this.duration = const Duration(seconds: 5), // Display duration
    this.mediaType = MediaType.image,
  });
}

enum MediaType { image, video }

// 2. Represents a group of stories for a single user
class DemoStatus {
  final String userName;
  final String userAvatarUrl;
  final DateTime timestamp;
  final List<DemoStory> stories;

  DemoStatus({
    required this.userName,
    required this.userAvatarUrl,
    required this.timestamp,
    required this.stories,
  });
}

// --- 3. Test data (with real images) ---
final List<DemoStatus> DUMMY_STATUSES = [
  DemoStatus(
    userName: "Mahmoud Elsaramji",
    userAvatarUrl: "https://picsum.photos/seed/mahmoud/200", // Real avatar image
    timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
    stories: [
      DemoStory(url: "https://picsum.photos/seed/story1/1080/1920"), // Real story image
      DemoStory(url: "https://picsum.photos/seed/story2/1080/1920"), // Real story image
    ],
  ),
  DemoStatus(
    userName: "Flutter Dev",
    userAvatarUrl: "https://picsum.photos/seed/flutterdev/200", // Real avatar image
    timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    stories: [
      DemoStory(url: "https://picsum.photos/seed/flutterstory/1080/1920"), // Real story image
    ],
  ),
  DemoStatus(
    userName: "Designer",
    userAvatarUrl: "https://picsum.photos/seed/designer/200", // Real avatar image
    timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    stories: [
      DemoStory(url: "https://picsum.photos/seed/design1/1080/1920"), // Real story image
      DemoStory(url: "https://picsum.photos/seed/design2/1080/1920"), // Real story image
      DemoStory(url: "https://picsum.photos/seed/design3/1080/1920"), // Real story image
    ],
  ),
];

