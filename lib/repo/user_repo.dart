import 'package:apiaccurate/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:apiaccurate/repo/api/api.dart';

class UserRepository {
  API api = API();
  Future<List<UserModel>> fetchUsers() async {
    try {
      Response response = await api.sendRequest.get("/user");
      List<dynamic> userMaps = response.data;
      return userMaps.map((userMap) => UserModel.fromJson(userMap)).toList();
    } catch (ex) {
      rethrow;
    }
  }
}
