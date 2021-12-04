class SuggestionModel {

  late String id;
  late String name;

  SuggestionModel({ required this.id, required this.name });

  SuggestionModel.fromJson(Map<String, dynamic> json){
      id = json['id'];
      name = json['name'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}