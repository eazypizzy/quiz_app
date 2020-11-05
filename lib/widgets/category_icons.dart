import 'package:flutter/material.dart';

class CategoryImage extends StatelessWidget {
  final String category;
  final int index;

  CategoryImage({Key key, @required this.category, this.index})
      : assert(category != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => _mapConditionToImage(category);

  Image _mapConditionToImage(String category) {
    Image image;
    switch (category.toLowerCase()) {
      case 'general knowledge':
        image = Image.asset('assets/icons/book.png');
        break;
      case 'entertainment: books':
        image = Image.asset('assets/icons/ent_books.png');
        break;
      case 'entertainment: film':
        image = Image.asset('assets/icons/camera-film.png');
        break;
      case 'entertainment: music':
        image = Image.asset('assets/icons/musical-notes.png');
        break;
      case 'entertainment: musicals & theatres':
        image = Image.asset('assets/icons/theatre.png');
        break;
      case 'entertainment: television':
        image = Image.asset('assets/icons/television.png');
        break;
      case 'entertainment: video games':
        image = Image.asset('assets/icons/video-game.png');
        break;
      case 'entertainment: board games':
        image = Image.asset('assets/icons/board-game.png');
        break;
      case 'science & nature':
        image = Image.asset('assets/icons/nature.png');
        break;
      case 'science: computers':
        image = Image.asset('assets/icons/computer.png');
        break;
      case 'science: mathematics':
        image = Image.asset('assets/icons/mathematics.png');
        break;
      case 'mythology':
        image = Image.asset('assets/icons/satyr.png');
        break;
      case 'sports':
        image = Image.asset('assets/icons/ball-sports.png');
        break;
      case 'geography':
        image = Image.asset('assets/icons/geography.png');
        break;
      case 'history':
        image = Image.asset('assets/icons/history.png');
        break;
      case 'politics':
        image = Image.asset('assets/icons/politics.png');
        break;
      case 'art':
        image = Image.asset('assets/icons/fine-arts.png');
        break;
      case 'celebrities':
        image = Image.asset('assets/icons/celebrity.png');
        break;
      case 'animals':
        image = Image.asset('assets/icons/animals.png');
        break;
      case 'vehicles':
        image = Image.asset('assets/icons/towing-vehicle.png');
        break;
      case 'entertainment: comics':
        image = Image.asset('assets/icons/comic.png');
        break;
      case 'science: gadgets':
        image = Image.asset('assets/icons/gadget.png');
        break;
      case 'entertainment: japanese anime & manga':
        image = Image.asset('assets/icons/dragon-ball.png');
        break;
      case 'entertainment: cartoon & animations':
        image = Image.asset('assets/icons/animation.png');
        break;
    }
    return image;
  }
}
