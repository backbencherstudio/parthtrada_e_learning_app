class BookExpertState {
  int selectedDuration;
  int? selectedSessionTime;
  bool isMorningShift;
  bool isSuccessfullyBooked;
  bool isConfirmLoading;

  BookExpertState({
    this.isConfirmLoading = false,
    this.selectedDuration = 0,
    this.selectedSessionTime,
    this.isMorningShift = true,
    this.isSuccessfullyBooked = false,
  });

  BookExpertState copyWith({
    int? selectedDuration,
    int? selectedSessionTime,
    bool? isMorningShift,
    bool? isSuccessfullyBooked,
    bool? isConfirmLoading,
  }) {
    return BookExpertState(
      isConfirmLoading: isConfirmLoading ?? this.isConfirmLoading,
      selectedDuration: selectedDuration ?? this.selectedDuration,
      selectedSessionTime: selectedSessionTime ?? this.selectedSessionTime,
      isMorningShift: isMorningShift ?? this.isMorningShift,
      isSuccessfullyBooked: isSuccessfullyBooked ?? this.isSuccessfullyBooked,
    );
  }
}
