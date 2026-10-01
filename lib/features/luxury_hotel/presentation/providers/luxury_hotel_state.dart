import '../../domain/entities/hotel_page_data.dart';

class LuxuryHotelState {
  final bool isLoading;
  final HotelPageData? data;
  final String? errorMessage;
  final String selectedCategory;

  const LuxuryHotelState({
    this.isLoading = false,
    this.data,
    this.errorMessage,
    this.selectedCategory = 'all',
  });

  LuxuryHotelState copyWith({
    bool? isLoading,
    HotelPageData? data,
    String? errorMessage,
    String? selectedCategory,
  }) {
    return LuxuryHotelState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
