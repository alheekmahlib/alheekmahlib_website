import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../azkar/screens/azkar_item.dart';

part 'alheekmah_state.dart';

class AlheekmahCubit extends Cubit<AlheekmahState> {
  AlheekmahCubit() : super(AlheekmahInitial());

  static AlheekmahCubit get(context) => BlocProvider.of(context);

  bool opened = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Save & Load Azkar Text Font Size
  saveAzkarFontSize(double fontSizeAzkar) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setDouble("font_azkar_size", fontSizeAzkar);
    emit(SharedPreferencesState());
  }
  loadAzkarFontSize() async {
    SharedPreferences prefs = await _prefs;
    AzkarItem.fontSizeAzkar = prefs.getDouble('font_azkar_size') ?? 18;
    print('get font size ${prefs.getDouble('font_azkar_size')}');
    emit(SharedPreferencesState());
  }
}
