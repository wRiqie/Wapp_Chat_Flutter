import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wapp_chat/app/data/models/user_model.dart';
import 'package:wapp_chat/app/modules/tabs/tabs_controller.dart';
import 'package:wapp_chat/app/routes/app_pages.dart';

class Search extends SearchDelegate {
  TabsController controller = Get.put(TabsController());

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // controller.saveSuggestion(query);

    return FutureBuilder<List<UserModel>>(
      future: controller.search(query),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const Center(
            child: Icon(
              Icons.signal_wifi_off,
              size: 40,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: Text(snapshot.data[index].name),
                    onTap: () {
                      Get.offAndToNamed(Routes.ABOUTUSER, arguments: {
                        'id': snapshot.data[index].id,
                        'name': snapshot.data[index].name,
                        'status': snapshot.data[index].status,
                        'photoUrl': snapshot.data[index].photoUrl
                      });
                    },
                  );
                });
          } else {
            return Container();
          }
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? [] : controller.suggestionsList;

    return ListView.builder(
          itemCount: suggestionList.length,
          itemBuilder: (context, index) {
            return ListTile(
              trailing: IconButton(
                onPressed: () {
                  // ToDo remover sugestão
                },
                icon: const Icon(Icons.clear),
              ),
              leading: const Icon(Icons.person),
              title:
                  Text(suggestionList.isNotEmpty ? suggestionList[index] : ''),
              onTap: () {
                query = suggestionList[index];
              },
            );
          },
        );
  }
}
