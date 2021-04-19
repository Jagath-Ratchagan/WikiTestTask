import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerForSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ListView.builder(
      padding: EdgeInsets.zero,
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: <Widget>[
                    _shimmerChild(context: context, width: 50, height: 50),
                    SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _shimmerChild(
                            context: context, width: width / 2, height: 10),
                        SizedBox(
                          height: 10,
                        ),
                        _shimmerChild(
                            context: context, width: width / 5, height: 10),
                        SizedBox(
                          height: 10,
                        ),
                        _shimmerChild(
                            context: context, width: width / 3, height: 10)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _shimmerChild({BuildContext context, double height, double width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100],
      highlightColor: Colors.grey[200],
      child: Container(
        width: width,
        height: height,
        color: Colors.green,
      ),
    );
  }
}
