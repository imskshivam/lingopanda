import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

final remoteConfigProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  try {
    final FirebaseRemoteConfig remoteConfig =
        await FirebaseRemoteConfig.instance;

    await remoteConfig.fetchAndActivate();

  
    return {
      'mask_email': remoteConfig.getBool('isMask'),
    };
  } catch (e) {
    throw Exception('Failed to fetch remote config: $e');
  }
});
