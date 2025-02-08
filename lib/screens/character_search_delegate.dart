import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmortyapp/models/character.dart';
import 'package:rickandmortyapp/utils/preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../providers/characters_provider.dart';
import '../resources/app_colors.dart';


class CharacterSearchDelegate extends SearchDelegate{

 @override
  String get searchFieldLabel => 'Character Name';

  @override
    List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null )
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  Widget _EmptySearch() {
    return
      InkWell(
        onTap: () => query = Preferences.lastSearch,
        child: Row(
          children: [
            Ink(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Preferences.lastSearch, style: TextStyle(color: AppColors.palette4),  ),
              ),
            ),
          ],
        ),
      );
  }


  Widget _ShimmerSearch() {
    return Container(
        child: Center(
        child:SizedBox(
          width: 200.0,
          height: 100.0,
          child: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.white54,
            child: Text(
              'Searching...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight:
                FontWeight.bold,
              ),
            ),
          ),
        ),

        ));
  }

 Widget _NothingFound() {
   return Container(
       child: Center(
         child:SizedBox(
           width: 200.0,
           height: 100.0,
           child: Text(
             'Nothing Found...',
             textAlign: TextAlign.center,
             style: TextStyle(
               color: AppColors.palette3,
               fontSize: 30.0,
               fontWeight:
               FontWeight.bold,
             ),
           ),
         ),

       ));
 }

  @override
  Widget buildSuggestions(BuildContext context) {

    if (query.isEmpty) {
      return
        _EmptySearch();
    }


    Preferences.lastSearch = query;

    final moviesProvider = Provider.of<CharactersProvider>(context, listen: false);

    moviesProvider.getSuggestionMovieByQuery(query);

    return StreamBuilder(
        stream: moviesProvider.searchCharacterStream,
        builder: (_, AsyncSnapshot<List<Character>> snapshot) {

           if (!snapshot.hasData) {
             return
               _ShimmerSearch();
           }
           final characters = snapshot.data!;


           return
             characters.isEmpty
              ?  _NothingFound()
              :ListView.builder(
               itemCount: characters.length,
               itemBuilder: ( _, int index) {
                 return
                   _CharacterItem(characters[index] );
               });
        }
    );
  }

 @override
  void showSuggestions(BuildContext context) {

  }
}

class _CharacterItem extends StatefulWidget {

  final Character character;

  const _CharacterItem(this.character);

  @override
  State<_CharacterItem> createState() => _CharacterItemState();
}

class _CharacterItemState extends State<_CharacterItem> {
  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Ink(
        width: double.infinity,
        height: 90,

        child: Card(
          child: InkWell(
            child: Row(
              children: [
                 Container(
                   width: 85,
                   //color: Colors.red,
                   child: ClipRRect(
                         borderRadius: BorderRadius.circular(9),
                         child: FadeInImage(
                           placeholder: AssetImage('assets/no-image.jpg'),
                           image: NetworkImage( widget.character.image ),
                           fit: BoxFit.fill,
                         ),
                 ),),
                 Expanded(
                     child: Container(

                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Flexible(
                                 child: Text(
                                   widget.character.name, style: TextStyle(fontSize: 20),
                                   overflow: TextOverflow.ellipsis,
                                   maxLines: 3,
                                 )
                             ),
                             Text(
                                 widget.character.species

                                 , style: TextStyle(color: Colors.red)),
                           ],
                         ),
                       ),
                     )
                 ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon( Icons.arrow_forward_outlined, ),
                ),

              ],
            ),
            onTap: () => Navigator.pushNamed(context, 'character_details', arguments: widget.character)
          ),
        ),
      ),
    );
  }
}



