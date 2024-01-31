import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String title;
  final Color color;
  const CategoryWidget({
    super.key, required this.title, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 80,

      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
        ),
        margin: EdgeInsets.zero,
        color: color,
        elevation: 0,
        child:Center(child: Text(title,style: const TextStyle(color: Colors.white),)),
      ),
    );
  }
}