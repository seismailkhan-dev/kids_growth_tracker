// lib/models/child_model.dart
import 'package:flutter/material.dart';

class ChildModel {
  final String id;
  final String name;
  final String emoji;
  final Color color;
  final DateTime birthDate;
  final String gender;
  final double weightKg;
  final double heightCm;
  final String bloodType;
  final List<String> allergies;

  ChildModel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
    required this.birthDate,
    required this.gender,
    required this.weightKg,
    required this.heightCm,
    required this.bloodType,
    required this.allergies,
  });

  String get age {
    final now = DateTime.now();
    final years = now.year - birthDate.year;
    final months = now.month - birthDate.month;
    if (years == 0) return '${months < 0 ? months + 12 : months} months';
    if (years < 2) {
      final totalMonths = (years * 12) + (months < 0 ? months + 12 : months);
      return '$totalMonths months';
    }
    return '$years years old';
  }
}

class GrowthEntry {
  final DateTime date;
  final double weight;
  final double height;

  GrowthEntry({required this.date, required this.weight, required this.height});
}

class SleepEntry {
  final DateTime date;
  final TimeOfDay bedTime;
  final TimeOfDay wakeTime;
  final double hoursSlept;
  final String quality;

  SleepEntry({
    required this.date,
    required this.bedTime,
    required this.wakeTime,
    required this.hoursSlept,
    required this.quality,
  });
}

class MedicalRecord {
  final String id;
  final String title;
  final String type;
  final DateTime date;
  final String doctor;
  final String notes;
  final String emoji;

  MedicalRecord({
    required this.id,
    required this.title,
    required this.type,
    required this.date,
    required this.doctor,
    required this.notes,
    required this.emoji,
  });
}

class ActivityModel {
  final String id;
  final String title;
  final String emoji;
  final String time;
  final String duration;
  final Color color;
  final bool isCompleted;

  ActivityModel({
    required this.id,
    required this.title,
    required this.emoji,
    required this.time,
    required this.duration,
    required this.color,
    required this.isCompleted,
  });
}

// ─── Mock Data ───────────────────────────────────────────────────────────────
class MockData {
  static final List<ChildModel> children = [
    ChildModel(
      id: '1',
      name: 'Emma Rose',
      emoji: '👧',
      color: const Color(0xFFFFB6C1),
      birthDate: DateTime(2019, 5, 12),
      gender: 'Female',
      weightKg: 18.5,
      heightCm: 112.0,
      bloodType: 'A+',
      allergies: ['Peanuts', 'Dust'],
    ),
    ChildModel(
      id: '2',
      name: 'Liam James',
      emoji: '👦',
      color: const Color(0xFF87CEFA),
      birthDate: DateTime(2021, 9, 3),
      gender: 'Male',
      weightKg: 13.2,
      heightCm: 92.5,
      bloodType: 'O+',
      allergies: ['Milk'],
    ),
    ChildModel(
      id: '3',
      name: 'Zoe Star',
      emoji: '🧒',
      color: const Color(0xFFFFD700),
      birthDate: DateTime(2023, 2, 22),
      gender: 'Female',
      weightKg: 9.8,
      heightCm: 74.0,
      bloodType: 'B+',
      allergies: [],
    ),
  ];

  static final List<GrowthEntry> growthEntries = [
    GrowthEntry(date: DateTime(2024, 1, 1), weight: 16.0, height: 104.0),
    GrowthEntry(date: DateTime(2024, 3, 1), weight: 16.8, height: 106.5),
    GrowthEntry(date: DateTime(2024, 5, 1), weight: 17.5, height: 108.0),
    GrowthEntry(date: DateTime(2024, 7, 1), weight: 17.9, height: 110.0),
    GrowthEntry(date: DateTime(2024, 9, 1), weight: 18.2, height: 111.0),
    GrowthEntry(date: DateTime(2024, 11, 1), weight: 18.5, height: 112.0),
  ];

  static final List<SleepEntry> sleepEntries = [
    SleepEntry(date: DateTime.now().subtract(const Duration(days: 6)), bedTime: const TimeOfDay(hour: 20, minute: 30), wakeTime: const TimeOfDay(hour: 7, minute: 0), hoursSlept: 10.5, quality: 'Great'),
    SleepEntry(date: DateTime.now().subtract(const Duration(days: 5)), bedTime: const TimeOfDay(hour: 21, minute: 0), wakeTime: const TimeOfDay(hour: 7, minute: 15), hoursSlept: 10.25, quality: 'Good'),
    SleepEntry(date: DateTime.now().subtract(const Duration(days: 4)), bedTime: const TimeOfDay(hour: 20, minute: 45), wakeTime: const TimeOfDay(hour: 6, minute: 45), hoursSlept: 10.0, quality: 'Good'),
    SleepEntry(date: DateTime.now().subtract(const Duration(days: 3)), bedTime: const TimeOfDay(hour: 21, minute: 30), wakeTime: const TimeOfDay(hour: 7, minute: 30), hoursSlept: 10.0, quality: 'Fair'),
    SleepEntry(date: DateTime.now().subtract(const Duration(days: 2)), bedTime: const TimeOfDay(hour: 20, minute: 0), wakeTime: const TimeOfDay(hour: 6, minute: 30), hoursSlept: 10.5, quality: 'Great'),
    SleepEntry(date: DateTime.now().subtract(const Duration(days: 1)), bedTime: const TimeOfDay(hour: 21, minute: 15), wakeTime: const TimeOfDay(hour: 7, minute: 0), hoursSlept: 9.75, quality: 'Good'),
    SleepEntry(date: DateTime.now(), bedTime: const TimeOfDay(hour: 20, minute: 30), wakeTime: const TimeOfDay(hour: 7, minute: 15), hoursSlept: 10.75, quality: 'Great'),
  ];

  static final List<MedicalRecord> medicalRecords = [
    MedicalRecord(id: '1', title: 'Annual Checkup', type: 'Checkup', date: DateTime(2024, 11, 15), doctor: 'Dr. Sarah Kim', notes: 'All vitals normal. Growth on track.', emoji: '🩺'),
    MedicalRecord(id: '2', title: 'MMR Vaccine', type: 'Vaccination', date: DateTime(2024, 9, 10), doctor: 'Dr. John Lee', notes: 'Second dose administered.', emoji: '💉'),
    MedicalRecord(id: '3', title: 'Allergy Test', type: 'Lab', date: DateTime(2024, 7, 5), doctor: 'Dr. Maria Chen', notes: 'Confirmed peanut allergy. Prescribed EpiPen.', emoji: '🔬'),
    MedicalRecord(id: '4', title: 'Ear Infection', type: 'Visit', date: DateTime(2024, 4, 22), doctor: 'Dr. Sarah Kim', notes: 'Prescribed amoxicillin for 7 days.', emoji: '👂'),
    MedicalRecord(id: '5', title: 'Flu Vaccine', type: 'Vaccination', date: DateTime(2024, 10, 1), doctor: 'Dr. John Lee', notes: 'Annual flu shot administered.', emoji: '💉'),
  ];

  static final List<ActivityModel> activities = [
    ActivityModel(id: '1', title: 'Morning Stretches', emoji: '🧘', time: '7:30 AM', duration: '15 min', color: const Color(0xFF87CEFA), isCompleted: true),
    ActivityModel(id: '2', title: 'Breakfast Time', emoji: '🥣', time: '8:00 AM', duration: '30 min', color: const Color(0xFFFFD700), isCompleted: true),
    ActivityModel(id: '3', title: 'Reading Time', emoji: '📚', time: '10:00 AM', duration: '20 min', color: const Color(0xFFFFB6C1), isCompleted: true),
    ActivityModel(id: '4', title: 'Outdoor Play', emoji: '🛝', time: '11:00 AM', duration: '45 min', color: const Color(0xFFE0FFE0), isCompleted: false),
    ActivityModel(id: '5', title: 'Afternoon Nap', emoji: '😴', time: '2:00 PM', duration: '90 min', color: const Color(0xFFFFE4E1), isCompleted: false),
    ActivityModel(id: '6', title: 'Art & Craft', emoji: '🎨', time: '4:00 PM', duration: '30 min', color: const Color(0xFFDDA0DD), isCompleted: false),
    ActivityModel(id: '7', title: 'Bath Time', emoji: '🛁', time: '6:30 PM', duration: '20 min', color: const Color(0xFF98FB98), isCompleted: false),
    ActivityModel(id: '8', title: 'Bedtime Story', emoji: '🌙', time: '8:00 PM', duration: '15 min', color: const Color(0xFF87CEFA), isCompleted: false),
  ];

  static final List<Map<String, dynamic>> aiMessages = [
    {'role': 'assistant', 'text': 'Hi! I\'m GrowBuddy AI 🌟 I can help you understand your child\'s development, answer health questions, and provide personalized tips. What would you like to know?'},
    {'role': 'user', 'text': 'Is Emma\'s height normal for her age?'},
    {'role': 'assistant', 'text': 'Based on Emma\'s latest measurements (112 cm at 5 years old), she\'s in the 75th percentile for height — which is excellent! 📊\n\nChildren at this percentile are considered above average height for their age group. Her growth curve has been consistently healthy over the past year. Keep up the great nutrition! 🥦'},
    {'role': 'user', 'text': 'How much sleep should she get?'},
    {'role': 'assistant', 'text': 'For a 5-year-old like Emma, the recommended sleep duration is 10–13 hours per night. 😴\n\nLooking at her recent sleep data, she\'s averaging about 10.4 hours — right within the healthy range!\n\nTip: Consistent bedtime routines (like reading a story) can improve sleep quality significantly. Emma\'s current 8:30 PM bedtime is great! ⭐'},
  ];

  static final List<Map<String, dynamic>> notifications = [
    {'title': 'Vaccination Due', 'subtitle': 'Liam\'s Hepatitis B booster is due this week', 'time': '2h ago', 'emoji': '💉', 'isRead': false},
    {'title': 'Growth Milestone!', 'subtitle': 'Emma has grown 2cm since last month! 🎉', 'time': '1d ago', 'emoji': '📏', 'isRead': false},
    {'title': 'Sleep Goal Met', 'subtitle': 'Zoe hit her sleep goal 5 days in a row!', 'time': '2d ago', 'emoji': '🌟', 'isRead': true},
    {'title': 'Doctor Appointment', 'subtitle': 'Emma\'s checkup is scheduled for Friday', 'time': '3d ago', 'emoji': '🩺', 'isRead': true},
    {'title': 'Activity Reminder', 'subtitle': 'Time for Liam\'s afternoon outdoor play!', 'time': '4d ago', 'emoji': '🛝', 'isRead': true},
  ];
}
