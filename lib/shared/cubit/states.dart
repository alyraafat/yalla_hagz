abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class AppChangeSearchTextColorState extends AppStates {}

class AppChangeModeState extends AppStates {}

class AppMala3ebSearchState extends AppStates {}

// Get all users:
class AppGetAllUsersLoadingState extends AppStates {}

class AppGetAllUsersSuccessState extends AppStates {}

class AppGetAllUsersErrorState extends AppStates
{
  final String error;
  AppGetAllUsersErrorState(this.error);
}

// Get User:
class AppGetUserLoadingState extends AppStates {}

class AppGetUserSuccessState extends AppStates {}

class AppGetUserErrorState extends AppStates
{
  final String error;
  AppGetUserErrorState(this.error);
}

//Update User:
class AppUpdateUserLoadingState extends AppStates {}

class AppUpdateUserSuccessState extends AppStates {}

class AppUpdateUserErrorState extends AppStates
{
  final String error;
  AppUpdateUserErrorState(this.error);
}

// Get Tournaments:
class AppGetTournamentsLoadingState extends AppStates {}

class AppGetTournamentsSuccessState extends AppStates {}

class AppGetTournamentsErrorState extends AppStates
{
  final String error;
  AppGetTournamentsErrorState(this.error);
}

// Get User Tournaments:
class AppGetUserTournamentsLoadingState extends AppStates {}

class AppGetUserTournamentsSuccessState extends AppStates {}

class AppGetUserTournamentsErrorState extends AppStates
{
  final String error;
  AppGetUserTournamentsErrorState(this.error);
}

//Update Tournaments:
class AppUpdateTournamentsLoadingState extends AppStates {}

class AppUpdateTournamentsSuccessState extends AppStates {}

class AppUpdateTournamentsErrorState extends AppStates
{
  final String error;
  AppUpdateTournamentsErrorState(this.error);
}

// Get Cities:
class AppGetCitiesLoadingState extends AppStates {}

class AppGetCitiesSuccessState extends AppStates {}

class AppGetCitiesErrorState extends AppStates
{
  final String error;
  AppGetCitiesErrorState(this.error);
}

// Get Schools:
class AppGetSchoolsLoadingState extends AppStates {}

class AppGetSchoolsSuccessState extends AppStates {}

class AppGetSchoolsErrorState extends AppStates
{
  final String error;
  AppGetSchoolsErrorState(this.error);
}

// Get One School:
class AppGetOneSchoolLoadingState extends AppStates {}

class AppGetOneSchoolSuccessState extends AppStates {}

class AppGetOneSchoolErrorState extends AppStates
{
  final String error;
  AppGetOneSchoolErrorState(this.error);
}
// Update School
class AppUpdateSchoolLoadingState extends AppStates {}

class AppUpdateSchoolSuccessState extends AppStates {}

class AppUpdateSchoolErrorState extends AppStates
{
  final String error;
  AppUpdateSchoolErrorState(this.error);
}

// Get Offers:
class AppGetOffersLoadingState extends AppStates {}

class AppGetOffersSuccessState extends AppStates {}

class AppGetOffersErrorState extends AppStates
{
  final String error;
  AppGetOffersErrorState(this.error);
}

// Check Data in database:
class AppCheckDataInDatabaseLoadingState extends AppStates {}

class AppCheckDataInDatabaseSuccessState extends AppStates {}

class AppCheckDataInDatabaseErrorState extends AppStates
{
  final String error;
  AppCheckDataInDatabaseErrorState(this.error);
}

// Create BookingTimeModel:
class AppCreateBookingTimeLoadingState extends AppStates {}

class AppCreateBookingTimeSuccessState extends AppStates {}

class AppCreateBookingTimeErrorState extends AppStates
{
  final String error;
  AppCreateBookingTimeErrorState(this.error);
}

// Get One BookingTimeModel:
class AppGetOneBookingTimeLoadingState extends AppStates {}

class AppGetOneBookingTimeSuccessState extends AppStates {}

class AppGetOneBookingTimeErrorState extends AppStates
{
  final String error;
  AppGetOneBookingTimeErrorState(this.error);
}

// Get BookingTimeModel:
class AppGetBookingTimeLoadingState extends AppStates {}

class AppGetBookingTimeSuccessState extends AppStates {}

class AppGetBookingTimeErrorState extends AppStates
{
  final String error;
  AppGetBookingTimeErrorState(this.error);
}

//Update BookingTimeModel:
class AppUpdateBookingTimeLoadingState extends AppStates {}

class AppUpdateBookingTimeSuccessState extends AppStates {}

class AppUpdateBookingTimeErrorState extends AppStates
{
  final String error;
  AppUpdateBookingTimeErrorState(this.error);
}
//PaymentScreen:

class CashState extends AppStates {}

class VodaCashState extends AppStates {}

class WalletState extends AppStates {}

//FriendsScreen:

class MyFriendsState extends AppStates {}

class MyFriendRequestsState extends AppStates {}

class MyFriendsLoadingState extends AppStates {}

class MyFriendsSearchState extends AppStates {}

//SchoolScreen:

class SchoolScreenInitialState extends AppStates {}

class SchoolScreenChangeState extends AppStates {}

class SchoolScreenLoadingState extends AppStates {}

class SchoolScreenNotifyState extends AppStates {}

class SchoolScreenBookedState extends AppStates {}

class SchoolScreenCancelState extends AppStates {}

class SchoolScreenFieldChangeState extends AppStates {}

class SchoolScreenChangeDateState extends AppStates {}

class SchoolScreenChangeCardColorState extends AppStates {}

class SchoolScreenChangeDaySelectedState extends AppStates {}

class SchoolScreenDaySelectedFalseState extends AppStates {}

class SchoolScreenDayEmptyFalseState extends AppStates {}

class SchoolScreenChangeDayState extends AppStates {}



//ChoosingScreenState:

class ChoosingScreenMala3ebState extends AppStates {}

class ChoosingScreenTournamentsState extends AppStates {}

class ChoosingScreenLoadingState extends AppStates {}

// Mala3ebScreen:

class Mala3ebScreenChangeCityState extends AppStates {}

class Mala3ebScreenLoadingState extends AppStates {}

// CircularProgressIndicator Screen
class CircularProgressIndicatorValueChangeState extends AppStates {}

class CircularProgressIndicatorScreenChangeSureState extends AppStates {}
