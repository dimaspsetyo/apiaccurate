import 'package:apiaccurate/models/city_model.dart';
import 'package:apiaccurate/repo/city_repo.dart';
import 'package:apiaccurate/logic/cubits/city/city_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit() : super(CityLoadingState()) {
    fetchCities();
  }

  CityRepository cityRepository = CityRepository();

  void fetchCities() async {
    try {
      List<CityModel> cities = await cityRepository.fetchCities();
      emit(CityLoadedState(cities));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.other) {
        emit(CityErrorState("Koneksi Internet tidak ditemukan."));
      } else {
        emit(CityErrorState(ex.type.toString()));
      }
    }
  }
}
