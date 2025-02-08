import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rickandmortyapp/screens/character_search_delegate.dart';
import '../models/character.dart';
import '../providers/characters_provider.dart';
import '../widgets/characters_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

   bool loading = true;

   List<Character> characters = [];

  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(Duration.zero,() async {

      await getData();
      setState(() {

      });
    });

    super.initState();
  }

   @override
   void dispose() {
     super.dispose();
   }

  Future<void> getData()async {

    loading = true;

    final charactersProvider = Provider.of<CharactersProvider>(context, listen: false);

    await charactersProvider.getCharacters();

    characters = charactersProvider.characters;

    loading = false;

  }

   @override
   Widget build(BuildContext context) {
     super.build(context);

     final charactersProvider = Provider.of<CharactersProvider>(context);

     return Scaffold(
         appBar: AppBar(
           centerTitle: true,
           title: Text('RICK AND MORTY'),
           actions: [
             IconButton(
                 onPressed: () {
                   showSearch(context: context, delegate: CharacterSearchDelegate());
                 },
                 icon: const Icon(
                   Icons.search,
                 )),
           ],
         ),
         body:
             loading
             ? SpinKitThreeBounce( color: Colors.red, size: 30)
             : RefreshIndicator(
               strokeWidth: 2,
               backgroundColor: Colors.white,
               color: Colors.green,
               onRefresh:_handleRefresh,
               child: CharactersList(
                  //characters: characters,
                  onNextPage: ()async {

                    charactersProvider.getCharacters();
               },
               ),
             ));
   }


  Future<void> _handleRefresh() async {

    await Future.delayed(Duration(seconds: 2));

    await getData();

    setState(() {


    });

  }

   @override
   bool get wantKeepAlive => true;
}


