import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_editor/Config/Helper/size_config.dart';
import 'package:video_editor/Config/Utils/colors.dart';
import 'package:video_editor/Controller/VideoMergeController/video_merge_controller.dart';
import 'package:video_player/video_player.dart';

import '../../Config/Utils/const.dart';

class VideoMergeScreen extends StatefulWidget {
  List<PlatformFile> files;

  VideoMergeScreen({required this.files});

  @override
  State<VideoMergeScreen> createState() => _VideoMergeScreenState();
}

class _VideoMergeScreenState extends State<VideoMergeScreen> {
  VideoMergeController cnt_screen = Get.put(VideoMergeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cnt_screen.arrfiles = widget.files;
    cnt_screen.arrVideoController.value = List.generate(
        widget.files.length,
        (index) =>
            VideoPlayerController.file(File(widget.files[index].path ?? ""),
                videoPlayerOptions: VideoPlayerOptions(
                  mixWithOthers: false
                )));
    cnt_screen.arrVideoController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _mergeButton(),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: SIDE_PADDING,right:
              SIDE_PADDING),
              child: ListofSelectedVideo(),
            ),
          ),
        ),
      ),
    );
  }

  Widget ListofSelectedVideo() {
    return Obx(() {
      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (_, index) {
          return wd_selectedvideview(index);
        },
        itemCount: cnt_screen.arrVideoController.length,
      );
    });
  }

  Widget wd_selectedvideview(int index) {
    VideoPlayerController cnt_video = cnt_screen.arrVideoController[index];
    return VideoPlayer(cnt_video);
  }

  Widget _mergeButton() {
    return Padding(
      padding: EdgeInsets.all(SIDE_PADDING),
      child: InkWell(
        onTap: (){
          cnt_screen.onTapMergeBtn();
        },
        child: Container(
          width: Get.width,
          height: 45.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: AppColors.APP_THEM_COLOR),
          alignment: Alignment.center,
          child: Text("Merge & Save",
              style: TextStyle(
                color: AppColors.WHITE,
                fontSize: 14.sp,
              )),
        ),
      ),
    );
  }
}
