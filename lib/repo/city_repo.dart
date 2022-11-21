import 'package:apiaccurate/models/city_model.dart';
import 'package:dio/dio.dart';
import 'package:apiaccurate/repo/api/api.dart';

class CityRepository {
  API api = API();
  Future<List<CityModel>> fetchCities() async {
    try {
      Response response = await api.sendRequest.get("/city");
      List<dynamic> cityMaps = response.data;
      return cityMaps.map((cityMap) => CityModel.fromJson(cityMap)).toList();
    } catch (ex) {
      rethrow;
    }
  }

  List<CityModel> results = [];
  Future<List<CityModel>> getcityList({String? query}) async {
    try {
      Response response = await api.sendRequest.get("/city");
      if (response.statusCode == 200) {
        List<dynamic> cityMaps = response.data;
        results =
            cityMaps.map((cityMap) => CityModel.fromJson(cityMap)).toList();
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
}
