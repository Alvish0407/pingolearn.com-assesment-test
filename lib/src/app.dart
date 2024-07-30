import 'package:flutter/material.dart';

import 'routing/app_router.dart';
import 'utils/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp.router(
        title: 'eShop',
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightThemeData(context),
      ),
    );
  }
}
