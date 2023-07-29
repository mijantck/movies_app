import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/utils/AppImages.dart';
import 'package:movies_app/views/widgets/GenreItem.dart';

import '../controllers/MovieController.dart';
import '../models/Movie.dart';
import '../utils/AppColors.dart';

class DetailedViewScreen extends StatelessWidget {
  final int movieId;
  DetailedViewScreen({ this.movieId = -1});
  @override
  Widget build(BuildContext context) {
    final int movieId =
        Get.arguments as int;

    final MovieController controller = Get.find<MovieController>();
    final Rx<Movie> movieRx = controller.getMovieById(movieId);
    final Movie? movie =
        movieRx.value;

    if (movie == null || movie.id == -1) {

      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('Movie not found!')),
      );
    }

    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: CachedNetworkImage(
                  imageUrl: movie.posterUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter:
                          ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                      height: 30,
                      width: 30,
                      child: Image.asset(AppImages.plaseholder_image,fit: BoxFit.fill,)),
                  errorWidget: (context, url, error) => Image.asset(AppImages.plaseholder_image,fit: BoxFit.fill,),
                ),
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.45,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    color: AppColors.white),
                child: Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(

                        height: 55,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: movie.genres.length,
                          itemBuilder: (context, index) {
                            return GenreItem(
                              false,
                              movie.genres[index],
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(movie.title,maxLines: 2,style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700, // Use FontWeight.w600 for SemiBold
                                  fontSize: 30,
                                  height: 1.3,
                                  color: AppColors.text_black
                              ),),

                              Row(
                                children: [
                                  Text('Year: ',style: TextStyle(height: 2.0,color: AppColors.gray)),
                                  Text('${movie.year}',style: TextStyle(height: 2.0,color: AppColors.text_black)),
                                ],
                              ),
                              Text('Derector: ',style: TextStyle(height: 2.0,color: AppColors.text_black,fontSize: 16,fontWeight: FontWeight.bold),),
                              Text(movie.director,style: TextStyle(height: 1.5,color: AppColors.text_black),maxLines: 2,),

                              Text('Actors: ',style: TextStyle(height: 2.0,color: AppColors.text_black,fontSize: 16,fontWeight: FontWeight.bold),),
                              Text(movie.actors,style: TextStyle(height: 1.5,color: AppColors.text_black),maxLines: 2,),

                              Text('Plot: ',style: TextStyle(height: 2.0,color: AppColors.text_black,fontSize: 16,fontWeight: FontWeight.bold),),
                              Text(movie.plot,style: TextStyle(height: 1.5,color: AppColors.text_black),maxLines: 2,),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
              top: 20,
              left: 20,
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Image.asset(
                  AppImages.ic_back_button,
                  width: 40,
                  height: 40,
                ),
              )),
        ],
      )),
    );
  }
}
