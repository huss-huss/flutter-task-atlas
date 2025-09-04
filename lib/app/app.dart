import 'package:flutter/material.dart';
import 'package:taskatlas_flutter/app/router.dart';
import 'package:taskatlas_flutter/app/theme.dart';

class TaskAtlasApp extends StatelessWidget {
  const TaskAtlasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TaskAtlas',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
