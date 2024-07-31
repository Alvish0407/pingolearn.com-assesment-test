import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'src/app.dart';
import 'src/features/home/data/remote_home_repository.dart';
import 'src/features/home/presentation/home_provider.dart';
import 'src/services/api_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      minimumFetchInterval: Duration.zero,
      fetchTimeout: const Duration(seconds: 10),
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeProvider(RemoteHomeRepository(apiClient: ApiClient())),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
