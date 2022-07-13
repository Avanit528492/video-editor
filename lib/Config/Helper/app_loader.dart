
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_editor/Config/Utils/images.dart';

BuildContext? _appLoaderContex;

AppLoader(BuildContext context){
  showGeneralDialog(context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    pageBuilder: (_, __, ___) {
      _appLoaderContex = context;
      return WillPopScope(
        onWillPop: ()async{
          return Future.value(false);
        },
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: 90,
            height: 90,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox.expand(
                  child: Image.asset(LOADER,
                      height: 80, width: 80)),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(45),
            ),
          ),
        ),
      );
    },);
}

void RemoveAppLoader(BuildContext context) {
  if (_appLoaderContex != null) {
    // Navigator.of(_appLoaderContex!).pop();
    Get.back();
  }
  // Navigator.of(context, rootNavigator: false).pop('dialog');
}