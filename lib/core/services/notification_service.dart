import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const List<String> _chemFacts = [
    "الماء يتمدد عند تجمده على عكس باقي السوائل!",
    "لون المريخ الأحمر يأتي من أوكسيد الحديد (الصدأ).",
    "عنصر الجاليوم يذوب في درجة حرارة حرارة يدك!",
    "حمض الفلوروأنتيمونيك هو أقوى حمض معروف، أقوى بـ 10 مليار ترليون مرة من حمض الكبريتيك.",
    "جسمك يحتوي على كمية من الكربون تكفي لصنع 9000 قلم رصاص!",
    "الذهب والفضة والبلاتين هي 'معادن نبيلة' لأنها لا تتفاعل بسهولة مع الأكسجين.",
    "الزجاج ليس صلباً ولا سائلاً، بل هو صلب غير متبلور.",
    "البرق ينتج غاز الأوزون الذي يُعطي الرائحة المنعشة بعد العواصف.",
    "الهيليوم أخف من الهواء لذلك يجعل البالونات تطير للأعلى.",
    "حمض المعدة قوي لدرجة أنه قادر على إذابة شفرات الحلاقة المعدنية.",
  ];

  Future<void> init() async {
    if (kIsWeb) return;
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    // flutter_local_notifications 20.x+ requires 'settings' named parameter
    await _notificationsPlugin.initialize(settings: initializationSettings);
  }

  Future<void> scheduleDailyChemFact() async {
    if (kIsWeb) return;
    final int randomIndex = Random().nextInt(_chemFacts.length);
    final String fact = _chemFacts[randomIndex];

    // flutter_local_notifications 20.x+ has strictly named parameters for zonedSchedule
    await _notificationsPlugin.zonedSchedule(
      id: 0,
      title: '🧪 معلومة كيميائية اليوم!',
      body: fact,
      scheduledDate: _nextInstanceOfTime(9, 0),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'chem_daily_facts_channel',
          'Daily Chemistry Facts',
          channelDescription: 'Daily fascinating facts about chemistry',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents:
          DateTimeComponents.time, // Repeat daily at the exact time
    );
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
