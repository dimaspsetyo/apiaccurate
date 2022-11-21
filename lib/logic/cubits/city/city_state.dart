import 'package:apiaccurate/models/city_model.dart';

abstract class CityState {}

class CityLoadingState extends CityState {}

class CityLoadedState extends CityState {
  final List<CityModel> cities;
  CityLoadedState(this.cities);
}

class CityErrorState extends CityState {
  final String error;
  CityErrorState(this.error);
}
