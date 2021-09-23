
abstract class AppStates {}

///all states according to order of calling them
class AppInitialState extends AppStates {}

class GetBusinessLoadingNewsState extends AppStates {}

class GetBusinessNewsSuccessState extends AppStates {}
class GetSelectedItemBusinessNewsState extends AppStates {}
class SetDeskTopBusinessNewsState extends AppStates {}

class GetBusinessNewsFailureState extends AppStates {
  final String error;

  GetBusinessNewsFailureState(this.error);
}

class GetSportsLoadingNewsState extends AppStates {}

class GetSportsNewsSuccessState extends AppStates {}

class GetSportsNewsFailureState extends AppStates {
  final String error;

  GetSportsNewsFailureState(this.error);
}

class GetScienceLoadingNewsState extends AppStates {}

class GetScienceNewsSuccessState extends AppStates {}

class GetScienceNewsFailureState extends AppStates {
  final String error;

  GetScienceNewsFailureState(this.error);
}

class ChangeThemeNodeState extends AppStates {}

class ChangeBottomNavBarState extends AppStates {}

class GetSearchLoadingNewsState extends AppStates {}

class GetSearchNewsSuccessState extends AppStates {}

class GetSearchNewsFailureState extends AppStates {
  final String error;

  GetSearchNewsFailureState(this.error);
}

class GetConnectionSuccessState extends AppStates {}
