import 'package:flutter/material.dart';
import '../../api/api_url.dart';

class ImageView extends StatelessWidget {
  const ImageView({
    Key? key,
    required this.imageLength,
    required this.imageUrl,
  }) : super(key: key);

  final int imageLength;
  final List<String> imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        itemCount: imageLength,
        // pageSnapping: true,
        itemBuilder: (context, pagePosition) {
          return Container(
            child: Image.network(
              ApiUrls.baseUrl + imageUrl[pagePosition],
              fit: BoxFit.contain,
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
          );
        },
      ),
    );
  }
}
