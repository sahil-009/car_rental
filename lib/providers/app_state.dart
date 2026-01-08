import 'package:flutter_riverpod/flutter_riverpod.dart';

// Simple app state holding login status and selected car ID
class AppState {
  final bool isLoggedIn;
  final String? selectedCarId;
  final String? name;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? location;

  const AppState({
    required this.isLoggedIn,
    this.selectedCarId,
    this.name,
    this.startDate,
    this.endDate,
    this.location,
  });
  AppState copyWith({
    bool? isLoggedIn,
    String? selectedCarId,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    String? location,
  }) {
    return AppState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      selectedCarId: selectedCarId ?? this.selectedCarId,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      location: location ?? this.location,
    );
  }
}

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(const AppState(isLoggedIn: false));

  // Update booking information
  void setBookingInfo({
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required String location,
  }) {
    state = state.copyWith(
      name: name,
      startDate: startDate,
      endDate: endDate,
      location: location,
    );
  }

  // Clear all booking and login info
  void clearAll() {
    state = const AppState(isLoggedIn: false);
  }

  void login() => state = state.copyWith(isLoggedIn: true);

  void logout() => state = state.copyWith(isLoggedIn: false, selectedCarId: null);

  void selectCar(String carId) => state = state.copyWith(selectedCarId: carId);
}

// Provider for the AppStateNotifier
final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) => AppStateNotifier());
