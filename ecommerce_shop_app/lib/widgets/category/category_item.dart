import 'package:flutter/material.dart';

import '../../pages/category_page.dart';

import '../../api/api_url.dart';

class CategoryItem extends StatelessWidget {
  // const CategoryItem({
  //   Key? key,
  // }) : super(key: key);

  final int id;
  final String name;
  final String imageUrl;

  CategoryItem(this.id, this.name, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, CategoryPage.routeName, arguments: id),
        splashColor: Colors.grey.withOpacity(0.7),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              width: 170,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  ApiUrls.baseUrl + imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
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
      ),
    );
  }
}
