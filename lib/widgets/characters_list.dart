import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/character.dart';
import '../providers/characters_provider.dart';

class CharactersList extends StatefulWidget {

  final Function onNextPage;

  const CharactersList( {super.key,  required this.onNextPage});

  @override
  State<CharactersList> createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
  List<Character> characters = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
        } else {
          setState(() {});
          await widget.onNextPage();
          _scrollController.animateTo(_scrollController.position.pixels + 50,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final charactersProvider = Provider.of<CharactersProvider>(context);

    characters = charactersProvider.characters;


    return ListView.builder(
        controller: _scrollController,
        itemCount: characters.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading:  CircleAvatar(
                backgroundImage:  NetworkImage(characters[index].image)
              //backgroundColor: AppColors.palette4,

            ),
            title: Text(characters[index].name),
            subtitle: Text(characters[index].species),
            trailing: IconButton(
                onPressed: () {

                },
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                )),
            onTap: () => Navigator.pushNamed(context, 'character_details', arguments: characters[index]),
          );

        });
  }
}
