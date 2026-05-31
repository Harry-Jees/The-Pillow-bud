import 'package:isar/isar.dart';

part 'user_preference.g.dart';

@Collection()
class UserPreference {
  Id isarId = Isar.autoIncrement;

  late String id;

  late String userName;
  late String buddyPersonality;
  late bool isDarkMode;
  late String primaryColor;
  late String secondaryColor;
  late bool onboardingCompleted;
  DateTime? onboardingCompletedAt;
  late bool lockScreenEnabled;
  late String themeName;

  UserPreference({
    required this.id,
    required this.userName,
    required this.buddyPersonality,
    required this.isDarkMode,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onboardingCompleted,
    this.onboardingCompletedAt,
    this.lockScreenEnabled = false,
    this.themeName = 'azureSerenity',
  });

  factory UserPreference.empty() {
    return UserPreference(
      id: 'default',
      userName: '',
      buddyPersonality: 'balanced',
      isDarkMode: true,
      primaryColor: '#64B5F6',
      secondaryColor: '#90CAF9',
      onboardingCompleted: false,
      lockScreenEnabled: false,
      themeName: 'azureSerenity',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userName': userName,
    'buddyPersonality': buddyPersonality,
    'isDarkMode': isDarkMode,
    'primaryColor': primaryColor,
    'secondaryColor': secondaryColor,
    'onboardingCompleted': onboardingCompleted,
    'onboardingCompletedAt': onboardingCompletedAt?.toIso8601String(),
    'lockScreenEnabled': lockScreenEnabled,
    'themeName': themeName,
  };

  factory UserPreference.fromJson(Map<String, dynamic> json) => UserPreference(
    id: json['id'] as String,
    userName: json['userName'] as String,
    buddyPersonality: json['buddyPersonality'] as String,
    isDarkMode: json['isDarkMode'] as bool,
    primaryColor: json['primaryColor'] as String,
    secondaryColor: json['secondaryColor'] as String,
    onboardingCompleted: json['onboardingCompleted'] as bool,
    onboardingCompletedAt: json['onboardingCompletedAt'] != null
        ? DateTime.parse(json['onboardingCompletedAt'] as String)
        : null,
    lockScreenEnabled: json['lockScreenEnabled'] as bool? ?? false,
    themeName: json['themeName'] as String? ?? 'azureSerenity',
  );

  UserPreference copyWith({
    String? id,
    String? userName,
    String? buddyPersonality,
    bool? isDarkMode,
    String? primaryColor,
    String? secondaryColor,
    bool? onboardingCompleted,
    DateTime? onboardingCompletedAt,
    bool? lockScreenEnabled,
    String? themeName,
  }) {
    final copy = UserPreference(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      buddyPersonality: buddyPersonality ?? this.buddyPersonality,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      onboardingCompletedAt: onboardingCompletedAt ?? this.onboardingCompletedAt,
      lockScreenEnabled: lockScreenEnabled ?? this.lockScreenEnabled,
      themeName: themeName ?? this.themeName,
    );
    copy.isarId = isarId;
    return copy;
  }
}
