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

  List<UserModel> results = [];
  Future<List<UserModel>> getuserList({String? query}) async {
    try {
      Response response = await api.sendRequest.get("/user");
      if (response.statusCode == 200) {
        List<dynamic> userMaps = response.data;
        results =
            userMaps.map((userMap) => UserModel.fromJson(userMap)).toList();
        if (query != null) {
          results = results
              .where((element) =>
                  element.name!.toLowerCase().contains((query.toLowerCase())))
              .toList();
        }
      } else {
        // ignore: avoid_print
        print("fetch error");
      }
    } catch (ex) {
      rethrow;
    }
    return results;
  }

  Future postUser(String name, String address, String email, String phoneNumber,
      String city) async {
    try {
      Response response = await api.sendRequest.post("/user", data: {
        "name": name,
        "address": address,
        "email": email,
        "phoneNumber": phoneNumber,
        "city": city
      });

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (ex) {
      rethrow;
    }
  }
}
