import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
import 'package:get/get.dart';
import 'package:video_editor/Config/Helper/size_config.dart';
import 'package:video_editor/Config/Utils/colors.dart';
import 'package:video_editor/Config/Utils/images.dart';
import 'package:video_editor/Controller/VideoWatermarkController/video_watermark_controller.dart';
import 'package:video_player/video_player.dart';

class VideoWatermarkScreen extends StatefulWidget {
  File videofile;

  VideoWatermarkScreen({required this.videofile});

  @override
  State<VideoWatermarkScreen> createState() => _VideoWatermarkScreenState();
}

class _VideoWatermarkScreenState extends State<VideoWatermarkScreen> {
  VideoWatermarkController cnt_screen = Get.put(VideoWatermarkController());

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      cnt_screen.InitilizeVideoPlayer(widget.videofile);
    });
    super.initState();
  }

  @override
  void dispose() {
    cnt_screen.videoPlayerController.dispose();
   cnt_screen.chewieController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    cnt_screen.RefreshVideo();
    return Scaffold(
      backgroundColor: AppColors.BLACK,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderView(),
            VideoView(),
            BottomPanelView()
          ],
        ),
      ),
    );
  }

  Widget HeaderView() {
    return Container(
      height: 50.w,
      width: Get.width,
      padding: EdgeInsets.only(left: 10.w, right: 10.w,),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: Container(
              height: 30.w,
              width: 30.w,
              child: Center(
                child: SvgPicture.asset(ICON_BACK_ARROW, color: AppColors.GREY,
                    height: 25.w, width: 25.w),
              ),
            ),
          ),
          Container(
            height: 30.w,
            width: 30.w,
            child: Center(
              child: SvgPicture.asset(ICON_DOWNLOAD, color: AppColors.GREY,
                  height: 25.w, width: 25.w),
            ),
          )
        ],
      ),
    );
  }

  Widget VideoView() {
    return Stack(
      children: [
        GetBuilder(
          init: VideoWatermarkController(),
          builder: (controller) {
            return cnt_screen.chewieController != null
                ? Container(
              width: Get.width,
              height: Get.width,
              child: Chewie(
                controller: cnt_screen.chewieController!,
              ),
            )
                : Container();
          },
          id: "refreshvideo",
        ),

        Positioned(
          bottom: 10.w,
          left: 10.w,
          child: InkWell(
              onTap: () =>cnt_screen.onTapPlayPauseBtn(),
              child: Container(
                height: 40.w,
                width: 40.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.w / 2),
                    color: Colors.black.withOpacity(0.6)
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 3.w),
                    child: Obx(() {
                      return cnt_screen.isPause.value ? SvgPicture.asset(
                      ICON_PLAY ,
                          color:
                          AppColors.GREY,
                          height: 17.w, width: 17.w) : SvgPicture.asset(
                          ICON_PAUSE ,
                          color:
                          AppColors.GREY,
                          height: 17.w, width: 17.w);
                    }),
                  ),
                ),
              )
          ),
        )

        // Obx((){
        //   return Positioned(
        //     top: cnt_screen.offset.value.dy,
        //     left: cnt_screen.offset.value.dx,
        //     child: XGestureDetector(
        //         onMoveUpdate: cnt_screen.UpdatePosition,
        //         //onPanUpdate: cnt_screen.UpdatePosition,
        //         onScaleUpdate: cnt_screen.UpdateScale,
        //         child: Obx((){
        //           return SizedBox.fromSize(
        //             size: cnt_screen.boxSize.value,
        //             child: Material(color: Colors.green,),
        //           );
        //         })
        //     ),
        //   );
        // })

      ],
    );
  }

  Widget BottomPanelView() {
    return Container(
      padding: EdgeInsets.only(bottom: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50.w,
            width: 50.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.w / 2),
                border: Border.all(color: AppColors.GREY, width: 1)
            ),
            child: Center(
              child: SvgPicture.asset(ICON_TYPE, color: AppColors.GREY,
                  height: 25.w, width: 25.w),
            ),
          ),
          SizedBox(width: 20.w,),
          Container(
            height: 50.w,
            width: 50.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.w / 2),
                border: Border.all(color: AppColors.GREY, width: 1)
            ),
            child: Center(
              child: SvgPicture.asset(ICON_IMAGE, color: AppColors.GREY,
                  height: 25.w, width: 25.w),
            ),
          ),
        ],
      ),
    );
  }


}
