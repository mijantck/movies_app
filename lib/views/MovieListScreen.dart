import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/utils/AppImages.dart';
import 'package:movies_app/utils/AppString.dart';
import 'package:movies_app/views/widgets/GenreItemList.dart';
import 'package:movies_app/views/widgets/MovieItem.dart';
import '../controllers/MovieController.dart';
import '../utils/AppColors.dart';

class MovieListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
        GetBuilder<MovieController>(
            builder: (controller) {
              return Column(
                children: [
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(left: 10,right: 10),
                    color: AppColors.white,
                    child: Row(
                      children: [
                        Image.asset(AppImages.menu, width: 24),
                        Expanded(child: Center(
                            child: Text(AppString.APP_NAME,style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600, // Use FontWeight.w600 for SemiBold
                              fontSize: 18,
                            )))),
                        Image.asset(AppImages.avatar, width: 32),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    height: 55,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.genres.length,
                      itemBuilder: (context, index) {

                        return GenreItemList(controller,index,false);
                      },
                    ),
                  ),
                  Expanded(
                    child: Obx(() {
                      final selectedGenre = controller.genres[controller.selectedGenericIndex.value];
                      final filteredMovies = controller.movies.where((movie) => movie.genres.contains(selectedGenre)).toList();
                      final movieCount = filteredMovies.length;
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                              children: [
                                Text('$movieCount $selectedGenre movies',style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400, // Use FontWeight.w600 for SemiBold
                                  fontSize: 14,
                                  height: 2.0
                                )),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Expanded( // Wrap the ListView.builder with Expanded
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: filteredMovies.length,
                              itemBuilder: (context, index) {

                                return MovieItem(filteredMovies, index);
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                  )



                ],
              );
            })



      ),
    );
  }
}
