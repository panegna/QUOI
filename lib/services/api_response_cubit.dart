import 'package:flutter_bloc/flutter_bloc.dart';
import 'google_api.dart';

class ApiResponseCubit extends Cubit<Map<String, dynamic>> {
  ApiResponseCubit() : super({});

  Future<void> fetchAndSaveNearbyPlaces() async {
    try {
      Map<String, dynamic> response = await fetchNearbyPlaces();
      emit(response);
    } catch (error) {
      // Gérer les erreurs, si nécessaire
    }
  }
}
