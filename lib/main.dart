import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_editor/Config/Utils/colors.dart';
import 'package:video_editor/Screens/VideoSelectionScreen/video_selection_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      popGesture: false,
      transitionDuration: Duration.zero,
      title: "Video Editor",
      theme: ThemeData(
        primaryColor: AppColors.APP_THEM_COLOR,
        accentColor: AppColors.LIGHT_BLUE,
        backgroundColor: AppColors.LIGHT_GREY
      ),
      home: VideoSelectionScreen(),
    );
  }
}
