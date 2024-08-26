import 'package:denizbank_clone/core/constants/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStatus> {
  AuthCubit(
    this.isAuth,
  ) : super(AuthStatus.unauthenticated) {
    emit(isAuth);
  }

  final AuthStatus isAuth;
}
