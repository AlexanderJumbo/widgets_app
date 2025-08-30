import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

//* Listado de colores inmutables
final colorListProvider = Provider((ref) => colorList); //*Provider es para obj inmutables

//Estado => isDarkModeProvider -> bool
final isDarkModeProvider = StateProvider<bool>((ref) => false);

final selectedColorProvider = StateProvider((ref) => 0);

//* Un obj de tipo AppTheme (custom)
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier() 
);

//*Controller o Notifier
class ThemeNotifier extends StateNotifier<AppTheme>{
  //*Crear la primer instancia del AppTheme con todos los valores inciales/default
  //* STATE: ESTADO = new AppTheme();
  // ThemeNotifier(super.state);
  ThemeNotifier():super(AppTheme());

  void toggleDarkmode(){
    //El nuevo estado va a ser una copia del estado actual con el valor opuesto al state.isDarkMode actual
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }
  void changeColorIndex(int colorIndex){
    state = state.copyWith(selectedColor: colorIndex);
  }

}