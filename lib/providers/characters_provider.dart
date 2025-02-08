import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:rickandmortyapp/models/character.dart';
import '../api/rm_api.dart';
import '../helpers/debouncer.dart';


class CharactersProvider extends ChangeNotifier{

  int page = 1;
  bool isLoading = false;
  List<Character> characters = [];

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  final StreamController<List<Character>> _searchCharacterStreamController =
  StreamController<List<Character>>.broadcast();

  Stream<List<Character>> get searchCharacterStream =>  _searchCharacterStreamController.stream;

  getCharacters() async{

    isLoading = true;

    final response = await RmApi.httpGet('/character?page=$page');

    final List charactersTemp = response['results'];

    characters = [...characters, ...charactersTemp.map(
            (character) => Character.fromJson(character)
    )];
    page++;

    isLoading = false;

    notifyListeners();
  }

  Future<List<Character>> searchCharacter(String name) async {

    final response = await RmApi.httpGet('/character/?name=$name');


     if(response != '') {
       final List charactersTemp = response['results'];

       return charactersTemp.map(
               (character) => Character.fromJson(character)
       ).toList();
     }
     return [];

  }

  void getSuggestionMovieByQuery(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final result = await this.searchCharacter(value);
      _searchCharacterStreamController.add(result);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }


}
