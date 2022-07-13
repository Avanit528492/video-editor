
import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_editor/Config/Helper/app_loader.dart';
import 'package:video_editor/Screens/VideoMergeScreen/video_merge_screen.dart';
import 'package:video_editor/Screens/VideoWaterMarkScreen/video_watermark_screen.dart';
import 'package:video_player/video_player.dart';


class VideoSelectionController extends GetxController{

  BuildContext context = Get.context!;

  List<PlatformFile> arrfiles = [];

  List<Size> arrsize = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  //<editor-fold desc = "Click Events">

  Future onTapSelectVideoBtn()async{

    AppLoader(context);

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: true,
    );



    if(result != null){

      arrfiles = result.files;
      //Get.to(VideoMergeScreen(files: result.files));
      String savepath = await _setFilePath();
      print(savepath);
      String command = await _generateCommand(savepath);
      print(command);

      FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();
      flutterFFmpeg.execute(command).then((session) async{

        print("-->$session");
        if(session == 0){
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Video Merge Successfully"))
          );
          Future.delayed(Duration(seconds: 5),(){
            RemoveAppLoader(context);
            Get.to(VideoWatermarkScreen(videofile: File(savepath)));
          });
        }else{
          RemoveAppLoader(context);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Video Merge Unsuccessfully"))
          );
        }
      });

    }else{
      RemoveAppLoader(context);
      // else part
    }

  }

  //</editor-fold>


  Future<String> _setFilePath()async{
    late Directory savedirectory;

    if(Platform.isIOS){
      savedirectory = await getApplicationDocumentsDirectory();

    }else if(Platform.isAndroid){
      savedirectory = await Directory("/storage/emulated/0/Download");
      //savedirectory = await getApplicationDocumentsDirectory();
    }

    String filename = "video${DateTime.now().millisecondsSinceEpoch}.mp4";
    String savepath = "${savedirectory.path}/$filename";

    return savepath;
  }

  Future<String> _generateCommand(String savepath)async{



    String videoaudiocommand = "";

    arrfiles.forEach((files) {
      VideoPlayerController cnt_video = VideoPlayerController.file(File(files
              .path ?? ""));
      cnt_video.value.size;
      arrsize.add(cnt_video.value.size);
    });

    arrfiles.asMap().forEach((i, value) {
      videoaudiocommand+="[$i:v]scale=1920:1920/1.3"
          ":force_original_aspect_ratio"
          "=1:eval=frame,pad=1920:1920/1.3:-1:-1:color=black,fps=30"
          "[v$i]; ";
    });

    String videoid = "";

    arrfiles.asMap().forEach((i, value) {
      videoid+="[v$i][$i:a]";
    });

    String corecommand = "-filter_complex \"$videoaudiocommand $videoid"
        "concat=unsafe=1:n=${arrfiles.length}:v=1:a=1 [v] [a]\" -map "
        "\"[v]\" -map \"[a]\" $savepath";

    String excutecommand = "";

    arrfiles.forEach((element) {
      excutecommand += "-i ${element.path} ";
    });

    return excutecommand + corecommand;

  }



}