import 'dart:convert';

import 'package:task2_get_api/photo_model.dart';
import 'package:http/http.dart' as http;

class ApiHelper{

Future<List<PhotoModel>> getPhoto() async{
  var url =Uri.parse("https://jsonplaceholder.typicode.com/photos");
  var response = await http.get(url);

  if(response.statusCode == 200){
print(response.body);
List<dynamic> jsonData = jsonDecode(response.body);
List<PhotoModel> photos = [];

for(var item in jsonData){
  PhotoModel photo =PhotoModel.fromJson(item);
  photos.add(photo);
}
return photos;
  }else{
print(response.statusCode);
return [];
  }
}

}