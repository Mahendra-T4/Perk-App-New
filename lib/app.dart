import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perk_app/core/service/device_id.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // @override
  // void initState() {
  //   super.initState();
  //   // Load device ID after first frame
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _loadDeviceInfo();
  //   });
  // }

  // Future<void> _loadDeviceInfo() async {
  //   await DeviceService.getDeviceId();
  // }6

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp.router(
        title: 'Perk',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: ColorTheme.background,
            elevation: 0,
          ),
          scaffoldBackgroundColor: ColorTheme.background,
        ),
        debugShowCheckedModeBanner: false,
        builder: FToastBuilder(),
        routerConfig: AppRoute.router,
      ),
    );
  }
}
