import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
import 'package:get/get.dart';
import 'package:video_editor/Config/Helper/app_loader.dart';
import 'package:video_editor/Config/Helper/size_config.dart';
import 'package:video_editor/Config/Utils/colors.dart';
import 'package:video_player/video_player.dart';

class VideoWatermarkController extends GetxController{

  BuildContext context = Get.context!;

  late VideoPlayerController videoPlayerController;
   ChewieController? chewieController;

   File? videofile;

  Rx<Offset> offset = Offset(0, 0).obs;
  final initSize = Size.square(100);
  Rx<Size> boxSize = Size.square(100).obs;
  final parentBoxSize = Size(Get.width, Get.width);

  RxBool isPause = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

 InitilizeVideoPlayer(File file)async{

    AppLoader(context);

    videoPlayerController = VideoPlayerController.file(file);
    await videoPlayerController.initialize().then((value){

      Size size = videoPlayerController.value.size;

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        aspectRatio: 1,
        fullScreenByDefault: false,
        looping: false,
        allowedScreenSleep: false,
        allowPlaybackSpeedChanging: false,
        allowFullScreen: true,
        allowMuting: false,
        showControls: false,
        zoomAndPan: true,

      );
      RemoveAppLoader(context);
      update(['refreshvideo']);
    });

  }

 RefreshVideo(){

   update(['refreshvideo']);
 }

 UpdatePosition(MoveEvent details){
   final offsetvalue = details.delta + offset.value;
   final x = offsetvalue.dx.clamp(0.0, parentBoxSize.width - boxSize.value
       .width);
   final y = offsetvalue.dy.clamp(0.0, parentBoxSize.height - boxSize.value
       .height);
   offset.value = Offset(x,y);
   print(offset);
 }

 UpdateScale(ScaleEvent details){
    double maxwidth = 300.w;
    double maxheight = 300.w;
    double width =  initSize.width * details.scale;
    double height = initSize.height * details.scale;

    boxSize.value = Size(width > maxwidth ? maxwidth : width, height > maxheight ?
    maxheight : height);
    boxSize.refresh();
 }

 onTapPlayPauseBtn(){

    if(isPause.value){
      //isPause.value = false;
      isPause.refresh();
      chewieController?.play();
    }else{
      //isPause.refresh();
      chewieController?.pause();
    }
    isPause.value = !isPause.value;
 }



}