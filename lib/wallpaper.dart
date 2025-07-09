import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/constant.dart';
import 'package:wallpaper/fullscreen.dart';

class Wallpaper extends StatefulWidget {
  const Wallpaper({super.key});





  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  List images=[];
  int page=1;
@override
void initState(){
  super.initState();
  fetchApi();
}
  fetchApi()async{
  final uri=("https://api.pexels.com/v1/curated?per_page=80");
  await http.get(Uri.parse(uri),
  headers: {
    'Authorization':'${Constant.apikey}'
    }).then((value){
    Map result=jsonDecode(value.body);
setState(() {
  images=result['photos'];
});
print(images.length );
  });
}
loadMore()async{
  setState(() {
    page=page+1;
  });
final String url='https://api.pexels.com/v1/curated?per_page=80&page='+page.toString();

await http.get(Uri.parse(url),
headers: {
    'Authorization':'${Constant.apikey}'
    }).then((value){
Map result=jsonDecode(value.body);
setState(() {
  images.addAll(result['photos']);
});
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                                itemCount:images.length,

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  childAspectRatio: 2/3,
                  mainAxisSpacing: 2
                ),
                itemBuilder:(context,index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (c)=>Fullscreen(imageUrl: images[index]['src']['large2x'])));
                    },
                    child: Container(
                      color:Colors.white,
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          InkWell(
            onTap: (){
              loadMore();
            },
            child: Container(
              width: double.infinity,
              height: 60,
              color: Colors.black,
              child: Center(
                child: Text(
                  "load More !!",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
