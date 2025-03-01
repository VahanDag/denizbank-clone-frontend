import 'package:denizbank_clone/core/constants/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:denizbank_clone/models/user_model.dart';

import '../../service/user_service.dart';

class UserState {
  final UserStatus status;
  final User? user;
  final String? errorMessage;
  final bool userLoggedBefore;

  UserState({
    this.status = UserStatus.initial,
    this.user,
    this.errorMessage,
    this.userLoggedBefore = false,
  });

  UserState copyWith({
    UserStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class UserCubit extends Cubit<UserState> {
  final UserService _userService;

  UserCubit({required UserService userService})
      : _userService = userService,
        super(UserState());

  Future<void> loadUser() async {
    emit(state.copyWith(status: UserStatus.loading));

    try {
      final user = await _userService.getCurrentUser();
      print("user $user");
      if (user != null) {
        emit(state.copyWith(status: UserStatus.loaded, user: user));
      } else {
        emit(state.copyWith(
          status: UserStatus.error,
          errorMessage: 'Kullanıcı bilgileri alınamadı',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: UserStatus.error,
        errorMessage: 'Bir hata oluştu: ${e.toString()}',
      ));
    }
  }

  void clearUser() {
    emit(UserState());
  }
}
