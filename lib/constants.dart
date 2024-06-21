import 'dart:math';

import 'package:flutter/animation.dart';

const kDefaultAnimationDuration = Duration(milliseconds: 800);
const kDefaultAnimationCurve = Curves.easeIn;

class User {
  final String name;
  final int age;
  final String videoUrl;
  final String location;
  final String imageUrl;
  final String caption;
  final List<String> tags;
  bool liked = false;

  User({
    required this.name,
    required this.age,
    required this.videoUrl,
    required this.imageUrl,
    required this.location,
    required this.caption,
    required this.tags,
    this.liked = false,
  });
}

final Random random = Random();

final List<User> usersList = [
  User(
    name: "Arthur Smith",
    age: 25,
    videoUrl:
        "https://videos.pexels.com/video-files/2795401/2795401-sd_540_960_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577009/pexels-photo-1577009.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "Phoenix, USA",
    tags: ["gaming", "hiking"], // New field
    caption: "Love the great outdoors!", // New field
  ),
  User(
    name: "Courtney Brown",
    age: 30,
    videoUrl:
        "https://videos.pexels.com/video-files/2791669/2791669-sd_540_960_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/775358/pexels-photo-775358.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "New York, USA",
    tags: ["photography", "skipping"], // New field
    caption: "Capturing life's moments.", // New field
  ),
  User(
    name: "Arthur Jones",
    age: 22,
    videoUrl:
        "https://videos.pexels.com/video-files/4434136/4434136-sd_540_960_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1858175/pexels-photo-1858175.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "Los Angeles, USA",
    tags: ["surfing", "travel"], // New field
    caption: "Always chasing the next wave.", // New field
  ),
  User(
    name: "Arthur Williams",
    age: 28,
    videoUrl:
        "https://videos.pexels.com/video-files/4650486/4650486-hd_720_1366_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577012/pexels-photo-1577012.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "Chicago, USA",
    tags: ["cooking", "music"], // New field
    caption: "Cooking up some beats.", // New field
  ),
  User(
    name: "Courtney Taylor",
    age: 27,
    videoUrl:
        "https://videos.pexels.com/video-files/5353260/5353260-sd_540_960_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577013/pexels-photo-1577013.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "Houston, USA",
    tags: ["dancing", "reading"], // New field
    caption: "Lost in a good book.", // New field
  ),
  User(
    name: "Arthur Lee",
    age: 24,
    videoUrl:
        "https://videos.pexels.com/video-files/8044824/8044824-sd_540_960_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577014/pexels-photo-1577014.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "San Diego, USA",
    tags: ["gaming", "tech"], // New field
    caption: "Tech geek at heart.", // New field
  ),
  User(
    name: "Arthur Clark",
    age: 32,
    videoUrl:
        "https://videos.pexels.com/video-files/8233934/8233934-hd_720_1366_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577015/pexels-photo-1577015.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "Austin, USA",
    tags: ["hiking", "photography"], // New field
    caption: "Exploring new heights.", // New field
  ),
  User(
    name: "Courtney Walker",
    age: 29,
    videoUrl:
        "https://videos.pexels.com/video-files/7505763/7505763-sd_540_960_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577016/pexels-photo-1577016.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "Dallas, USA",
    tags: ["music", "travel"], // New field
    caption: "Journey through sound.", // New field
  ),
  User(
    name: "Arthur Harris",
    age: 21,
    videoUrl:
        "https://videos.pexels.com/video-files/6586074/6586074-sd_540_960_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1362724/pexels-photo-1362724.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "San Francisco, USA",
    tags: ["skateboarding", "tech"], // New field
    caption: "Riding the tech wave.", // New field
  ),
  User(
    name: "Arthur Lewis",
    age: 35,
    videoUrl:
        "https://videos.pexels.com/video-files/6799742/6799742-sd_540_960_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577100/pexels-photo-1577100.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "Seattle, USA",
    tags: ["gardening", "reading"], // New field
    caption: "Books and blooms.", // New field
  ),
  User(
    name: "Courtney Hall",
    age: 23,
    videoUrl:
        "https://videos.pexels.com/video-files/8588877/8588877-hd_720_1366_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/3304341/pexels-photo-3304341.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "Boston, USA",
    tags: ["fashion", "dancing"], // New field
    caption: "Dancing through life.", // New field
  ),
  User(
    name: "Arthur Queen",
    age: 26,
    videoUrl:
        "https://videos.pexels.com/video-files/4990426/4990426-sd_540_960_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1758144/pexels-photo-1758144.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "Denver, USA",
    tags: ["skiing", "cooking"], // New field
    caption: "Cooking up a storm.", // New field
  ),
  User(
    name: "Arthur Wright",
    age: 33,
    videoUrl:
        "https://videos.pexels.com/video-files/7550765/7550765-sd_540_960_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1755385/pexels-photo-1755385.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "Las Vegas, USA",
    tags: ["gaming", "dancing"], // New field
    caption: "Leveling up in life.", // New field
  ),
  User(
    name: "Courtney Scott",
    age: 20,
    videoUrl:
        "https://videos.pexels.com/video-files/7302975/7302975-sd_540_960_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577009/pexels-photo-1577009.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "Miami, USA",
    tags: ["beach", "skateboarding"], // New field
    caption: "Sun, sand, and skate.", // New field
  ),
  User(
    name: "Arthur Adams",
    age: 31,
    videoUrl:
        "https://videos.pexels.com/video-files/4936970/4936970-sd_540_960_24fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577026/pexels-photo-1577026.jpeg?auto=compress&cs=tinysrgb',
    tags: ["beach", "skateboarding"], // New field
    caption: "Sun, sand, and skate.", location: '',
  ),

  ///
  ///
  User(
    name: "Arthur Smith",
    age: 25,
    videoUrl:
        "https://videos.pexels.com/video-files/2795401/2795401-sd_540_960_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577009/pexels-photo-1577009.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "Phoenix, USA",
    tags: ["gaming", "hiking"], // New field
    caption: "Love the great outdoors!", // New field
  ),
  User(
    name: "Courtney Brown",
    age: 30,
    videoUrl:
        "https://videos.pexels.com/video-files/2791669/2791669-sd_540_960_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/775358/pexels-photo-775358.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "New York, USA",
    tags: ["photography", "skipping"], // New field
    caption: "Capturing life's moments.", // New field
  ),
  User(
    name: "Arthur Jones",
    age: 22,
    videoUrl:
        "https://videos.pexels.com/video-files/4434136/4434136-sd_540_960_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1858175/pexels-photo-1858175.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "Los Angeles, USA",
    tags: ["surfing", "travel"], // New field
    caption: "Always chasing the next wave.", // New field
  ),
  User(
    name: "Arthur Williams",
    age: 28,
    videoUrl:
        "https://videos.pexels.com/video-files/4650486/4650486-hd_720_1366_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577012/pexels-photo-1577012.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "Chicago, USA",
    tags: ["cooking", "music"], // New field
    caption: "Cooking up some beats.", // New field
  ),
  User(
    name: "Courtney Taylor",
    age: 27,
    videoUrl:
        "https://videos.pexels.com/video-files/5353260/5353260-sd_540_960_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577013/pexels-photo-1577013.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "Houston, USA",
    tags: ["dancing", "reading"], // New field
    caption: "Lost in a good book.", // New field
  ),
  User(
    name: "Arthur Lee",
    age: 24,
    videoUrl:
        "https://videos.pexels.com/video-files/8044824/8044824-sd_540_960_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577014/pexels-photo-1577014.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "San Diego, USA",
    tags: ["gaming", "tech"], // New field
    caption: "Tech geek at heart.", // New field
  ),
  User(
    name: "Arthur Clark",
    age: 32,
    videoUrl:
        "https://videos.pexels.com/video-files/8233934/8233934-hd_720_1366_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577015/pexels-photo-1577015.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "Austin, USA",
    tags: ["hiking", "photography"], // New field
    caption: "Exploring new heights.", // New field
  ),
  User(
    name: "Courtney Walker",
    age: 29,
    videoUrl:
        "https://videos.pexels.com/video-files/7505763/7505763-sd_540_960_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577016/pexels-photo-1577016.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "Dallas, USA",
    tags: ["music", "travel"], // New field
    caption: "Journey through sound.", // New field
  ),
  User(
    name: "Arthur Harris",
    age: 21,
    videoUrl:
        "https://videos.pexels.com/video-files/6586074/6586074-sd_540_960_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1362724/pexels-photo-1362724.jpeg?auto=compress&cs=tinysrgb&w=600',
    location: "San Francisco, USA",
    tags: ["skateboarding", "tech"], // New field
    caption: "Riding the tech wave.", // New field
  ),
];
