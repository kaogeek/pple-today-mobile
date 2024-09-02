import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlbumCard extends StatelessWidget {
  final List gallery;
  final VoidCallback? onTap;

  const AlbumCard({
    Key? key,
    required this.gallery,
    required this.onTap,
  }) : super(key: key);

  String imageURL(int index) => gallery[index].imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: gallery.length >= 4
          ? Container(
              height: context.isPhone ? 340 : 400,
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: container3(context),
              ),
            )
          : gallery.length >= 2
              ? Container(
                  height: context.isPhone ? 170 : 200,
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: container2(context),
                  ),
                )
              : Container(
                  height: context.isPhone ? 340 : 400,
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: container1(context),
                  ),
                ),
    );
  }

  Widget container1(BuildContext context) {
    return Image.network(
      gallery[0].imageUrl ?? imageURL(0),
      height: context.isPhone ? 340 : 400,
      width: double.infinity,
      fit: BoxFit.fitHeight,
      filterQuality: FilterQuality.low,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
          ),
        );
      },
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
        return Container(
          height: context.isPhone ? 340 : 400,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.error,
                color: Colors.red,
              ),
              Text(
                'Failed to load image',
                style: TextStyle(
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget container2(BuildContext context) {
    List _gallery = gallery.sublist(0, 2);
    return Stack(
      children: [
        Wrap(
          spacing: 2,
          children: _gallery.asMap().entries.map((e) {
            return Image.network(
              gallery[e.key].imageUrl ?? imageURL(e.key),
              height: context.isPhone ? 170 : 200,
              width: (Get.width / 2) - 8,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                  ),
                );
              },
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                return Container(
                  height: context.isPhone ? 170 : 200,
                  width: (Get.width / 2) - 8,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                      Text(
                        'Failed to load image',
                        style: TextStyle(
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        (gallery.length - 2) > 0
            ? Positioned(
                right: 0,
                child: Container(
                  height: context.isPhone ? 170 : 200,
                  width: (Get.width / 2) - 8,
                  color: Colors.black.withOpacity(.5),
                  child: Center(
                    child: Text(
                      '+${gallery.length - 2}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget container3(BuildContext context) {
    List _gallery = gallery.sublist(0, 4);
    return Stack(
      children: [
        Wrap(
          spacing: 2,
          runSpacing: 2,
          children: _gallery.asMap().entries.map((e) {
            return Image.network(
              gallery[e.key].imageUrl ?? imageURL(e.key),
              height: context.isPhone ? 170 : 200,
              width: (Get.width / 2) - 8,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                  ),
                );
              },
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                return Container(
                  height: context.isPhone ? 170 : 200,
                  width: (Get.width / 2) - 8,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                      Text(
                        'Failed to load image',
                        style: TextStyle(
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        (gallery.length - 4) > 0
            ? Positioned(
                bottom: -2,
                right: 0,
                child: Container(
                  height: context.isPhone ? 170 : 200,
                  width: (Get.width / 2) - 8,
                  color: Colors.black.withOpacity(.5),
                  child: Center(
                    child: Text(
                      '+${gallery.length - 4}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
