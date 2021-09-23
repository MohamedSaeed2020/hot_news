import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hot_news/layout/home_layout.dart';
import 'package:hot_news/network/local/cache_helper.dart';
import 'package:hot_news/network/remote/dio_helper.dart';
import 'package:hot_news/shared/bloc_observer.dart';
import 'package:hot_news/shared/cubit/cubit.dart';
import 'package:hot_news/shared/cubit/states.dart';

Future<void> main() async {
  //to make sure that all await function will run first and complete
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await DesktopWindow.setMinWindowSize(Size(350.0, 650.0,));
  }
  //to observe the states of the app.
  Bloc.observer = MyBlocObserver();
  //init the dio (baseurl)
  DioHelper.init();
  /*we used wait to ensure that the CacheHelper.init() method,
   will complete before the app start*/
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getBusiness()
        ..getSports()
        ..getScience()
        ..changeThemeMode(fromShared: isDark),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            return MaterialApp(
              //to hide debugCheckedModeBanner
              debugShowCheckedModeBanner: false,
              //light theme for all the app screens
              theme: ThemeData(
                ///text theme
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                ///scaffoldBackgroundColor theme
                scaffoldBackgroundColor: Colors.white,

                ///primarySwatch theme
                primarySwatch: Colors.deepPurple,

                ///appbar theme
                appBarTheme: AppBarTheme(
                  titleSpacing: 16.0,
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  //to enable me to edit status bar options
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                ),

                ///bottom nav bar theme
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepPurple,
                  elevation: 20.0,
                  backgroundColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                ),
              ),
              //dark theme for all the app screens
              darkTheme: ThemeData(
                ///text theme
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),

                ///scaffoldBackgroundColor theme
                scaffoldBackgroundColor: HexColor('333739'),

                ///primarySwatch theme
                primarySwatch: Colors.deepPurple,

                ///appbar theme
                appBarTheme: AppBarTheme(
                  titleSpacing: 16.0,
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  //to enable me to edit status bar options
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                ),

                ///bottom nav bar theme
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepPurple,
                  elevation: 20.0,
                  backgroundColor: HexColor('333739'),
                  unselectedItemColor: Colors.grey,
                ),
              ),
              //toggle between dark and light theme
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: NewsHomeScreen(),
            );
          }),
    );
  }
}
