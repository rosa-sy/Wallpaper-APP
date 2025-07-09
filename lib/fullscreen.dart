import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';

class Fullscreen extends StatefulWidget {
  const Fullscreen({super.key, required this.imageUrl});
final String imageUrl;



  @override
  State<Fullscreen> createState() => _FullscreenState();
}

class _FullscreenState extends State<Fullscreen> {
    final WallpaperManagerPlus wallpaperManagerPlus = WallpaperManagerPlus();

  Future<void>setwallpaper()async{
  int location= WallpaperManagerPlus.homeScreen;
  final file =await DefaultCacheManager().getSingleFile(widget.imageUrl);
final result=await wallpaperManagerPlus.setWallpaper(file, location);

} 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
            children: [
              Expanded(
                child: Container(
child: Image.network(widget.imageUrl,),
              ),),

               InkWell(
            onTap: (){
              setwallpaper();
            },
            child: Container(
              width: double.infinity,
              height: 60,
              color: Colors.black,
              child: Center(
                child: Text(
                  "Set Wallpaper !!",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
            ],
        ),
      ),
    );
  }
}