import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:video_editor/Config/Helper/size_config.dart';
import 'package:video_editor/Config/Utils/colors.dart';
import 'package:video_editor/Config/Utils/images.dart';
import 'package:video_editor/Controller/VideoSelectionController/video_selection_controller.dart';

class VideoSelectionScreen extends StatefulWidget {
  const VideoSelectionScreen({Key? key}) : super(key: key);

  @override
  State<VideoSelectionScreen> createState() => _VideoSelectionScreenState();
}

class _VideoSelectionScreenState extends State<VideoSelectionScreen> {
  VideoSelectionController cnt_screen = Get.put(VideoSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  cnt_screen.onTapSelectVideoBtn();
                },
                child: Container(
                  width: 150.w,
                  height: 150.w,
                  decoration: BoxDecoration(
                      color: AppColors.WHITE,
                      borderRadius: BorderRadius.circular(10.w),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.SHADOW,
                            blurRadius: 6,
                            spreadRadius: 1,
                            offset: Offset(1, 1))
                      ]),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(ICON_PLUS,
                      color: AppColors.GREY, height: 70.w, width: 70.w),
                ),
              ),
              SizedBox(height: 10.w,),
              Text("* Select Multiple videos",style: TextStyle(
                color: AppColors.GREY,
                fontSize: 12.sp
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
