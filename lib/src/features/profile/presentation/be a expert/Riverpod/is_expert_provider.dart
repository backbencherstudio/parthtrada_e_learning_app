import 'package:flutter_riverpod/flutter_riverpod.dart';

final isExpertProvider = StateNotifierProvider<ExpertNotifier, bool>(
  (ref){
    return ExpertNotifier();
  }
);

class ExpertNotifier extends StateNotifier<bool>{
  ExpertNotifier():super(true);
  void setExpert(bool value){
    state = value;
  }
}