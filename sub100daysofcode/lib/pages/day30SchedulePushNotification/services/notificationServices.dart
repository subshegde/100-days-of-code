
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sub100daysofcode/pages/day30SchedulePushNotification/utils/utils.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
  print("Initializing notifications...");
  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('flutter_logo');

  var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {});

  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await notificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
    print("Notification clicked: ${notificationResponse.payload}");
  });
  print("Notification initialized");
}


  Future<NotificationDetails> notificationDetails() async {
  // Download large icon and big picture

  String largeIconPath = await Utils.downloadFile(
    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/640px-Google_%22G%22_logo.svg.png', 
    'google_icon'
  );
  String bigPicturePath = await Utils.downloadFile(
    'https://images.pexels.com/photos/145939/pexels-photo-145939.jpeg?cs=srgb&dl=pexels-flickr-145939.jpg&fm=jpg', 
    'big_picture'
  );

  // Define BigPictureStyle
  BigPictureStyleInformation styleInformation = BigPictureStyleInformation(
    FilePathAndroidBitmap(bigPicturePath),
    largeIcon: FilePathAndroidBitmap(largeIconPath),
    contentTitle: 'This is your content',
    summaryText: 'This is your notification!',
  );
  
  // Ensure the sound file is placed in the res/raw folder, and specify it without the extension
  final customSound = 'wrong_answer_sound';  // Use the filename without the extension

  // Android notification details
  AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    'channelId', 
    'channelName',
    enableVibration: true,
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
    sound: RawResourceAndroidNotificationSound(customSound), // Sound file without extension
    styleInformation: styleInformation,
    playSound: false
  );

  // iOS notification details (make sure the custom sound is available for iOS)
  DarwinNotificationDetails iOSNotificationDetails = DarwinNotificationDetails(
    sound: customSound,  // iOS sound file name without extension
  );

  return NotificationDetails(
    android: androidNotificationDetails, 
    iOS: iOSNotificationDetails,
  );
}


Future scheduleNotification({
  int id = 0,
  String? title,
  String? body,
  String? payLoad,
  required DateTime scheduledNotificationDateTime,
}) async {
  tz.TZDateTime scheduledDateTime = tz.TZDateTime.from(
    scheduledNotificationDateTime,
    tz.local,
  );

  return notificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    scheduledDateTime,
    await notificationDetails(),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}

}
