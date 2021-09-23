import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_news/modules/search/search_screen.dart';
import 'package:hot_news/shared/components/components.dart';
import 'package:hot_news/shared/cubit/cubit.dart';
import 'package:hot_news/shared/cubit/states.dart';

class NewsHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Hot News",
            ),
            actions: [
              IconButton(onPressed: () {
                navigateTo(context, SearchScreen());
              }, icon: Icon(Icons.search)),
              IconButton(onPressed: () {
                cubit.changeThemeMode();
              }, icon: Icon(Icons.brightness_4_outlined)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          ///bottomNavigationBar
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavBarItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
