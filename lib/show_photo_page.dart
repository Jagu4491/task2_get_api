import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task2_get_api/api_helper.dart';
import 'package:task2_get_api/photo_model.dart';

class ShowPhotoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_ShowPhotoPageState();

}
class _ShowPhotoPageState extends State<ShowPhotoPage>{

  late Future<List<PhotoModel>> _photoList;

  @override
  void initState() {
    super.initState();
    _photoList = ApiHelper().getPhoto();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Photo List'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<PhotoModel>>(
        future: _photoList,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
                itemBuilder: (context,index){
                return ListTile(
                  leading: CircleAvatar(
                    //child: Image.network(snapshot.data![index].url.toString()),
                    backgroundImage: NetworkImage(snapshot.data![index].thumbnailUrl!),
                  ),
                  title: Text(snapshot.data![index].title!),
                  onTap: (){
                    showComment(context, snapshot.data![index].title!);
                  },
                  //subtitle: Text('ID:${snapshot.data![index].id}'),
                );
              });
          }else if(snapshot.hasError){
            return Center(child: Text('Error:${snapshot.error}'));
          }else{
            return Center(child: CircularProgressIndicator());
          }

        },
      ),

    );
  }

  void showComment(BuildContext context,String comment){
    final snackBar = SnackBar(content: Text(comment));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}