import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_news/modules/business/business_screen.dart';
import 'package:hot_news/modules/science/science_screen.dart';
import 'package:hot_news/modules/sports/sports_screen.dart';
import 'package:hot_news/network/local/cache_helper.dart';
import 'package:hot_news/network/remote/dio_helper.dart';
import 'package:hot_news/shared/cubit/states.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AppCubit extends Cubit<AppStates> {
  ///initial state
  AppCubit() : super(AppInitialState());

  //get instance of AppCubit class
  static AppCubit get(context) => BlocProvider.of(context);

  //variables
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: "Science",
    ),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];
 // List<bool> businessSelectedItems = [];
  int businessSelectedItem=0;

  bool isDark = false;
  bool netValue = false;
  bool isDesktop = false;

  //class methods
  ///change currentIndex state
  void changeIndex(int index) {
    currentIndex = index;
    /*    if(currentIndex==1){
      getSports();
    }
    else if(currentIndex==2){
      getScience();
    }*/

    //you can load all data once you open the app
    emit(ChangeBottomNavBarState());
  }

  ///get business news state
  void getBusiness() {
    //loading until data is returned
    emit(GetBusinessLoadingNewsState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '563eef5e6bf64c56b1579a586adf6692',
      },
    ).then((value) {
      business = value.data['articles'];
/*      business.forEach((element) {
        businessSelectedItems.add(false);
      });*/
      print("Data returned successfully: ${business[0]['title']}");
      emit(GetBusinessNewsSuccessState());
    }).catchError((onError) {
      print("Error: ${onError.toString()}");
      emit(GetBusinessNewsFailureState(onError.toString()));
    });
  }

  ///get sports news state
  void getSports() {
    //loading until data is returned
    emit(GetSportsLoadingNewsState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '563eef5e6bf64c56b1579a586adf6692',
        },
      ).then((value) {
        sports = value.data['articles'];
        print("Data returned successfully: ${sports[0]['title']}");
        emit(GetSportsNewsSuccessState());
      }).catchError((onError) {
        print("Error: ${onError.toString()}");
        emit(GetSportsNewsFailureState(onError.toString()));
      });
    } else {
      emit(GetSportsNewsSuccessState());
    }
  }

  ///get science news state
  void getScience() {
    //loading until data is returned
    emit(GetScienceLoadingNewsState());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '563eef5e6bf64c56b1579a586adf6692',
        },
      ).then((value) {
        science = value.data['articles'];
        print("Data returned successfully: ${science[0]['title']}");
        emit(GetScienceNewsSuccessState());
      }).catchError((onError) {
        print("Error: ${onError.toString()}");
        emit(GetScienceNewsFailureState(onError.toString()));
      });
    } else {
      emit(GetScienceNewsSuccessState());
    }
  }

  ///change theme mode state
  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeThemeNodeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeThemeNodeState());
      });
    }
  }

  ///search state
  void getSearch(String value) {
    //loading until data is returned
    emit(GetSearchLoadingNewsState());
    search = [];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '563eef5e6bf64c56b1579a586adf6692',
      },
    ).then((value) {
      search = value.data['articles'];
      print("Data returned successfully: ${search[0]['title']}");
      emit(GetSearchNewsSuccessState());
    }).catchError((onError) {
      print("Error: ${onError.toString()}");
      emit(GetSearchNewsFailureState(onError.toString()));
    });
  }

  ///check network connection state
  bool checkConnection() {
    InternetConnectionChecker().hasConnection.then((value) {
      netValue = value;
      if (value == true) {
        print('YAY! Free cute dog pics!');
        emit(GetConnectionSuccessState());
      } else {
        print('No internet :( Reason:');
      }
    });
    return netValue;
  }


  ///check if item is selected
  void selectBusinessItem(index){
    businessSelectedItem=index;
/*    for(int i=0;i<businessSelectedItems.length;i++){
      if(i==index){
        businessSelectedItems[index]=true;
      }
      else{
        businessSelectedItems[index]=false;
      }
    }*/
    emit(GetSelectedItemBusinessNewsState());
  }

  ///check platform if desktop or mobile or etc..
  void setDesktop(bool value){
    isDesktop=value;
    emit(SetDeskTopBusinessNewsState());
}
}
