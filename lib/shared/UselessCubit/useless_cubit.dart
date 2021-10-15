import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/Network/local/cache_helper.dart';
import 'package:yalla_hagz/shared/UselessCubit/useless_states.dart';

class UselessCubit extends Cubit<UselessStates> {
  UselessCubit() : super(UselessInitialState());

  static UselessCubit get(context) => BlocProvider.of(context);
  bool isDark = true;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(UselessChangeModeState());
    }
    else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) =>
          emit(UselessChangeModeState()));
    }
  }
}