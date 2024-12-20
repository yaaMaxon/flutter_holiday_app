import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/api_service.dart';
import '../services/cache_service.dart';

abstract class HolidayState {}

class HolidayInitial extends HolidayState {}

class HolidayLoading extends HolidayState {}

class HolidayLoaded extends HolidayState {
  final List<Map<String, dynamic>> holidays;

  HolidayLoaded(this.holidays);
}

class HolidayError extends HolidayState {
  final String message;

  HolidayError(this.message);
}

class HolidayCubit extends Cubit<HolidayState> {
  final ApiService apiService;
  final CacheService cacheService;

  HolidayCubit(this.apiService, this.cacheService) : super(HolidayInitial());

  Future<void> fetchHolidays() async {
    emit(HolidayLoading());
    try {
      final holidays = await apiService.fetchHolidays();
      await cacheService.saveHolidays(holidays);
      emit(HolidayLoaded(holidays));
    } catch (error) {
      final cachedHolidays = await cacheService.getHolidays();
      if (cachedHolidays != null) {
        emit(HolidayLoaded(List<Map<String, dynamic>>.from(cachedHolidays)));
      } else {
        emit(HolidayError("Failed to load holidays: $error"));
      }
    }
  }
}
