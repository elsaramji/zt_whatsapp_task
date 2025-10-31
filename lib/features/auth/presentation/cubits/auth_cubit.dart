import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zt_whatsapp_task/features/auth/data/repos/auth_repo_impl.dart';
import 'package:zt_whatsapp_task/features/auth/data/source/firebase_data_source.dart';
import 'package:zt_whatsapp_task/features/auth/domain/usecase/sign_in_usecase.dart';

import '../../data/models/user_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase = SignInUseCase(
    AuthRepoImpl(AuthDataSourceImpl()),
  );

  AuthCubit() : super(AuthInitial());

  // This is the function that will be called by the interface
  Future<void> loginUser(String phoneNumber) async {
    // 1. Issue loading state to show Spinner
    emit(AuthLoading());

    // 2. Execute the UseCase
    // The UseCase will call the Repo -> DataSource -> Firebase
    final result = await _signInUseCase.call(phoneNumber);

    // 3. Handle the result (Either)
    result.fold(
      // 3a. In case of failure (Left)
      (exception) {
        // Issue failure state with error message
        emit(AuthFailure(exception.toString()));
      },
      // 3b. In case of success (Right)
      (user) {
        // Issue success state with user data
        _signInUseCase.saveUserId(user as UserModel);
        emit(AuthSuccess(user));
      },
    );
  }
}
