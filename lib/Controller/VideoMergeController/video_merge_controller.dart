import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_editor/Config/Helper/app_loader.dart';
import 'package:video_player/video_player.dart';

class VideoMergeController extends GetxController{

  BuildContext context = Get.context!;

  RxList<VideoPlayerController> arrVideoController = RxList([]);
  List<PlatformFile> arrfiles = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  //<editor-fold desc = "Click Event">

  Future onTapMergeBtn()async{
    AppLoader(context);

     String command = await _generateCommand();
     print(command);

     // FFmpegKit.execute(command).then((session) async{
     //   RemoveAppLoader(context);
     //   final returnCode = await session.getReturnCode();
     //   print(session.getArguments());
     //   print(returnCode);
     //
     //   if (ReturnCode.isSuccess(returnCode)) {
     //
     //     print("SUCCESS");
     //
     //   } else if (ReturnCode.isCancel(returnCode)) {
     //
     //     print("CANCEL");
     //
     //   } else {
     //
     //     print("Error");
     //
     //   }
     // });

  }

  //</editor_fold>

  Future<String> _generateCommand()async{

    late Directory savedirectory;

    if(Platform.isIOS){
      savedirectory = await getApplicationDocumentsDirectory();

    }else if(Platform.isAndroid){
      savedirectory = Directory("/storage/emulated/0/Download");
    }

    String filename = "video${DateTime.now().millisecondsSinceEpoch}.mp4";
    String savepath = "${savedirectory.path}/$filename";

    String coreCommand = "-filter_complex \"[0:v:0][0:a:0][1:v:0][1:a:0][2:v:0][2:a:0]concat=n=3:v=1:a=1[outv][outa]\" -map \"[outv]\" -map \"[outa]\" $savepath";

    String excutecommand = "";

    arrfiles.forEach((element) {
      excutecommand += "-i ${element.path} ";
    });

    return excutecommand + coreCommand;

  }



}