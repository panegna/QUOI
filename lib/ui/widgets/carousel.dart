import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';   


class Carousel extends StatefulWidget {
  final Function(int) onIndexChanged;

  Carousel({required this.onIndexChanged});

  @override
  _CarouselState createState() => _CarouselState();
}


class _CarouselState extends State<Carousel> {
  CarouselController buttonCarouselController = CarouselController();
  int _currentIndex = 0;

 @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      CarouselSlider(
        carouselController: buttonCarouselController,
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          height: 350,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
              widget.onIndexChanged(_currentIndex);
            });
          },
        ),
        items: [
          'assets/img/food.png',
          'assets/img/bar.png',
        ].map((item) {
          return Container(
            margin:const EdgeInsets.symmetric(horizontal: 5.0),
            child: Image.asset(item, fit: BoxFit.cover),
          );
        }).toList(),
      ),
    //  Text('$_currentIndex'),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 2; i++)
            GestureDetector(
              onTap: () {
                buttonCarouselController.animateToPage(i);
              },
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == i
                    ? Colors.black
                    : Colors.grey,
                ),
              ),
            ),
        ],
      ),
    ]
  );
}
