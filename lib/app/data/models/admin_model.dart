class AdminModel {
  late int id;

  AdminModel({ required this.id });

  AdminModel.fromJson(Map<String, dynamic> json){
      id = json['id'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = {};
    data['id'] = id;
    return data;
  }
}