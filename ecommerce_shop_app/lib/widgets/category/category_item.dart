import 'package:flutter/material.dart';

import '../../pages/category_page.dart';

import '../../api/api_url.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key, required this.id, required this.name, required this.imageUrl,
  }) : super(key: key);

  final int id;
  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, CategoryPage.routeName, arguments: {"id": id, "name":name}),
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
              padding: const EdgeInsets.all(10),
              child: Text(
                name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
