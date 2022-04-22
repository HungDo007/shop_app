import '../../api/api_url.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  // const CategoryItem({
  //   Key? key,
  // }) : super(key: key);

  final String name;
  final String imageUrl;

  CategoryItem(this.name, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
            width: 200,
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                ApiUrls.baseUrl + imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.white70,
            ),
            padding: EdgeInsets.all(10),
            child: Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
