import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rickandmortyapp/providers/characters_provider.dart';
import 'package:rickandmortyapp/providers/theme_provider.dart';
import 'package:rickandmortyapp/screens/detail_screen.dart';
import 'package:rickandmortyapp/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:rickandmortyapp/utils/preferences.dart';
import 'api/rm_api.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();
  RmApi.configureDio();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) =>
      runApp(
          MultiProvider(
              providers: [
                ChangeNotifierProvider(create: ( _ ) => ThemeProvider(   )),
              ],
              child:AppState())
      )
  );
}

class AppState extends StatelessWidget {
  const AppState({super.key});



  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => CharactersProvider()),
      ],
      child: MyApp(),
    );
  }
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'RICK AND MORTY',
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      routes: {
        'home': (context) => HomeScreen(),
        'character_details': (context) => DetailScreen(),
      },
      initialRoute: 'home',

    );
  }
}
