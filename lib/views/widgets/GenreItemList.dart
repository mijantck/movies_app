import 'package:flutter/material.dart';
import 'package:movies_app/views/widgets/GenreItem.dart';

import '../../controllers/MovieController.dart';

class GenreItemList extends StatelessWidget {
  MovieController controller;
  int index;
  bool fromDetails;
  GenreItemList(this.controller,this.index,this.fromDetails);

  @override
  Widget build(BuildContext context) {
    bool isSelected = controller.selectedGenericIndex == index;
    String genre = controller.genres[index];


    return GestureDetector(
      onTap: () {
        controller.selectedGeneric(index);
      },

      child: GenreItem(isSelected,genre),
    );
  }
}
