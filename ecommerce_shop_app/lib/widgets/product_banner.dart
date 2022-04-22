import 'package:flutter/material.dart';

class ProductBanner extends StatelessWidget {
  // const ProductBanner({ Key? key }) : super(key: key);

  List<String> images = [
    "https://i.pinimg.com/originals/4a/b9/94/4ab994aa22ef942921a39f48a489ab0d.jpg",
    "https://i.pinimg.com/originals/60/b0/a4/60b0a4ee7e032a6281444a82705a665c.jpg",
    "https://mir-s3-cdn-cf.behance.net/project_modules/fs/2bbcfa99737217.5ef9be3dbb9a9.jpg",
    "https://cdn.dribbble.com/users/3428605/screenshots/7962424/media/fdc104240a8c034c23cfdeaca8240e20.jpg",
    "https://cdna.artstation.com/p/assets/images/images/031/586/906/large/murugendra-hiremath-00001212.jpg?1604034460",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: images.length,
        // pageSnapping: true,
        itemBuilder: (context, pagePosition) {
          return Container(
            margin: const EdgeInsets.all(8),
            child: Image.network(
              images[pagePosition],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
