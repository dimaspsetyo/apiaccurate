import 'package:apiaccurate/models/user_model.dart';
import 'package:apiaccurate/repo/user_repo.dart';
import 'package:apiaccurate/logic/cubits/user/user_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserLoadingState()) {
    fetchUsers();
  }

  UserRepository userRepository = UserRepository();

  void fetchUsers() async {
    try {
      List<UserModel> users = await userRepository.fetchUsers();
      emit(UserLoadedState(users));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.other) {
        emit(UserErrorState("Koneksi Internet tidak ditemukan."));
      } else {
        emit(UserErrorState(ex.type.toString()));
      }
    }
  }
}
