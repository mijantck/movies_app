import 'package:flutter/material.dart';
import 'package:movies_app/utils/AppColors.dart';

class GenreItem extends StatelessWidget {
  bool isSelected;
  String genre;
  GenreItem(this.isSelected, this.genre);

  @override
  Widget build(BuildContext context) {
    print('dsjhfjs $isSelected');

    return Container(
      margin: EdgeInsets.only(right: 12,top: 8,bottom: 8),
      padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.black : AppColors.gray_item_border,
          width: 1,
        ),
        color: isSelected ? AppColors.black : AppColors.white,
      ),
      child: Center(
        child: Text(
          genre,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500, // Use FontWeight.w600 for SemiBold
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
