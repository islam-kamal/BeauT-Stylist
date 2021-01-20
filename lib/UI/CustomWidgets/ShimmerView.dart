//import 'package:flutter/material.dart';
//import 'package:shimmer/shimmer.dart';
//
//class ShimmerView extends StatefulWidget {
//  final double height;
//  final double width;
//  final double radius;
//
//  const ShimmerView({Key key, this.height, this.width, this.radius})
//      : super(key: key);
//
//  @override
//  _ShimmerViewState createState() => _ShimmerViewState();
//}
//
//class _ShimmerViewState extends State<ShimmerView> {
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
//      child: Shimmer.fromColors(
//        baseColor: Colors.grey[300],
//        highlightColor: Colors.white30,
//        child: Container(
//          height: widget.height,
//          width: widget.width,
//          decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(widget.radius),
//              color: Colors.grey[300]),
//        ),
//      ),
//    );
//  }
//}
