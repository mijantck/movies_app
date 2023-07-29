import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controllers/MovieController.dart';
import 'package:movies_app/models/Movie.dart';
import 'package:movies_app/utils/AppColors.dart';
import 'package:movies_app/utils/AppImages.dart';

class MovieItem extends StatelessWidget {
  List<Movie> filteredMovies;
  int index;
  MovieItem(this.filteredMovies, this.index);

  @override
  Widget build(BuildContext context) {
    final movie = filteredMovies[index];
    return GestureDetector(
      onTap: () => Get.toNamed('/detailed_view', arguments: movie.id),
      child: Container(

        margin: EdgeInsets.only(left:12,right: 12,top: 8,bottom: 8),
        padding: EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.gray_item_border,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 133,
              width: 115,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
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
            )
            ),
            SizedBox(width: 10,),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,maxLines: 2,style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700, // Use FontWeight.w600 for SemiBold
                  fontSize: 18,
                  color: AppColors.text_black
                ),),

                Row(
                  children: [
                    Text('Year: ',style: TextStyle(height: 2.0,color: AppColors.gray)),
                    Text('${movie.year}',style: TextStyle(height: 2.0,color: AppColors.text_black)),
                  ],
                ),
                Text('Derector: ',style: TextStyle(height: 2.0,color: AppColors.gray),),
                Text(movie.director,style: TextStyle(height: 1.0,color: AppColors.text_black),maxLines: 2,),
              ],
            )),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
