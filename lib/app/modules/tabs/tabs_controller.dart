import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:wapp_chat/app/data/models/suggestion_model.dart';
import 'package:wapp_chat/app/data/models/user_model.dart';
import 'package:wapp_chat/app/data/repository/search_repository.dart';

class TabsController extends GetxController with SingleGetTickerProviderMixin {
  final _searchRepository = SearchRepository();
  late TabController tabsController;

  RxList suggestionsList = [].obs;

  final List<Tab> tabs = [
    const Tab(
      text: 'Conversas',
    ),
    const Tab(
      text: 'Status',
    ),
  ];

  Future<List<UserModel>> search(String query) async {
    var users = await _searchRepository.searchUsers(query);
    return users;
  }

  // getSuggestions() async {
  //   var suggestions = await _searchRepository.getSuggestions();
  //   for (var suggestion in suggestions) {
  //     suggestionsList.add(suggestion.name);
  //   }
  // }

  // saveSuggestion(String query) async {
  //   var s = suggestionsList.where((e) => e == query);
  //   if(s.isEmpty){
  //     var uid = Uuid();

  //     await _searchRepository.saveSuggestion(SuggestionModel(id: uid.v1(), name: query));
  //     suggestionsList.add(query);
  //   }
  // }

  // deleteSuggestion(int id) async {
  //   await _searchRepository.deleteSuggestion(id);
  // }

  @override
  void onInit() {
    super.onInit();
    tabsController = TabController(vsync: this, length: tabs.length);
    
    // getSuggestions();
    suggestionsList.addAll(['Teste', 'teste']);
  }

  @override
  void onClose() {
    tabsController.dispose();
    super.onClose();
  }
}
