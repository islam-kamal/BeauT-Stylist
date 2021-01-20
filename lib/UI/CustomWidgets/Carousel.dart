import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatefulWidget {
  final List img;

  const CustomCarousel({Key key, this.img}) : super(key: key);

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  List empty = [
    "https://www.freeiconspng.com/uploads/warning-error-icon-png-33.png"
  ];

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: widget.img.map((item) {
              return Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(item.photo), fit: BoxFit.cover)),
              );
            }).toList(),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 4,
              aspectRatio: 16 / 9,
              viewportFraction: 0.99,
              initialPage: 0,
              disableCenter: true,
              pageSnapping: true,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.img.map((url) {
            int index = widget.img.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void showImageDialog(String image) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoDialog(
            child: Image.network(image),
          );
        });
  }
}
