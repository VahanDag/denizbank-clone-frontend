import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:denizbank_clone/service/auth_service.dart';
import 'package:denizbank_clone/cubit/user/user_cubit.dart';
import 'package:denizbank_clone/cubit/auth/auth_state.dart'; // Yeni state sınıfımızı import edin

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;
  final UserCubit _userCubit;

  AuthCubit({required AuthService authService, required UserCubit userCubit})
      : _authService = authService,
        _userCubit = userCubit,
        super(const AuthInitial()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    emit(const AuthAppLoading());

    try {
      final hasValidToken = await _authService.hasValidToken();
      if (hasValidToken) {
        emit(const AuthAuthenticated());
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login({required int tcNo, required int password}) async {
    emit(const AuthOperationLoading('login'));

    try {
      final success = await _authService.login(tcNo: tcNo, password: password);
      print("is success: $success");
      if (success) {
        await _userCubit.loadUser();
        emit(const AuthAuthenticated());
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(const AuthOperationLoading('logout'));

    try {
      await _authService.logout();
      _userCubit.clearUser();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> refreshToken() async {
    try {
      final success = await _authService.refreshToken();

      if (!success) {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
