import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../config/environment.dart';
import '../../core/di/service_locator.dart';
import '../../core/notifications/cloud_messaging_api.dart';
import '../../core/notifications/local_notification_api.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  print("Handling a background message: ${message.messageId}");
}

Future<void> initFirebase(Environment env) async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );

  await sl<CloudMessagingApi>().initialize();
  await sl<LocalNotificationsApi>().initialize();
}
