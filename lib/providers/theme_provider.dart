import 'package:flutter/material.dart';

import '../resources/app_colors.dart';


class ThemeProvider extends ChangeNotifier {

  ThemeData darkTheme = ThemeData.dark().copyWith(appBarTheme: const AppBarTheme());

  ThemeData lightTheme = ThemeData.light().copyWith(

    //ElevatedButton
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(

      backgroundColor: AppColors.palette3, // background (button) color
      foregroundColor: AppColors.palette4, // foreground (text) color
   ),
  ),
  iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(iconColor: MaterialStateProperty.all<Color>(
          AppColors.palette3),)
  ),
  buttonTheme: const ButtonThemeData(

  //  disabledColor: AppColors.palette1,
    buttonColor: AppColors.palette1,
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: AppColors.palette1,
    titleTextStyle: TextStyle(color: AppColors.palette3,fontSize: 20),
    contentTextStyle: TextStyle(color: AppColors.palette4),
    iconColor: AppColors.palette3,

  ),
  dialogBackgroundColor: AppColors.palette1,
  bottomSheetTheme:  const BottomSheetThemeData(backgroundColor: AppColors.palette4),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.white12),
      suffixIconColor: AppColors.palette4,
      prefixIconColor: AppColors.palette4,
      labelStyle: TextStyle(color: AppColors.palette4 ),
      disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.palette2)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.palette4)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.palette4, width: 2),),
    ),
    listTileTheme: const ListTileThemeData(


      textColor: AppColors.palette3
    ),
    tabBarTheme:  const TabBarTheme(labelColor: AppColors.palette1),
    iconTheme:  const IconThemeData(color: AppColors.palette1),
    appBarTheme:  const AppBarTheme(

        titleTextStyle: TextStyle(color: AppColors.palette3),
        iconTheme: IconThemeData(color: AppColors.palette3),
        actionsIconTheme: IconThemeData(color: AppColors.palette3),

        color: AppColors.palette1
    ),
    scaffoldBackgroundColor: AppColors.palette1,

  );

  ThemeData currentTheme = ThemeData.dark();

  ThemeProvider(){





       currentTheme = lightTheme;


  }



  // ThemeProvider({required bool isDarkmode})
  //
  //    : currentTheme = isDarkmode
  //    ? currentTheme = lightTheme
  //    : lightTheme = darkTheme;
  //


  setLightMode() {
    currentTheme = lightTheme;
    notifyListeners();
  }

  setDarkMode() {
    currentTheme = darkTheme;
    notifyListeners();
  }
}
