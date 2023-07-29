import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/utils/AppImages.dart';

import '../controllers/MovieController.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controllers/MovieController.dart';
import 'package:movies_app/utils/AppImages.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final controller = Get.find<MovieController>();
  final autoNavigateDelay = 2000;

  @override
  void initState() {
    super.initState();
    // Start the auto navigation process
    controller.fetchMovies().then((value) {
      //print('sdkfjsdlk ${controller.genres.length}');
      if(controller.genres.length > 0){
        autoNavigateToNextPage();
      }
    });
   // autoNavigateToNextPage();
  }

  Future<void> autoNavigateToNextPage() async {
    await Future.delayed(Duration(milliseconds: autoNavigateDelay));
    Get.offNamed('/movie_list');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return CircularProgressIndicator();
          } else if (controller.error.isNotEmpty) {
            return Text(controller.error.value);
          } else {
            return Center(child: Image.asset(AppImages.movie_app_icon, height: 110, width: 110));
          }
        }),
      ),
    );
  }
}
