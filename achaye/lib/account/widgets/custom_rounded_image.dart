import 'package:flutter/cupertino.dart';

class CustomRoundedImage extends StatelessWidget {
  final String imageUrl;
  const CustomRoundedImage({
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Container(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
