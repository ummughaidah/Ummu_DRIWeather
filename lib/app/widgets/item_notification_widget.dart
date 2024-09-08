import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ummu_driweather/app/widgets/utils_widget.dart';

class ItemNotificationWidget extends StatelessWidget {
  final String day;
  final String iconAsset;
  final String subtitle;
  final Function() onTap;
  final int index;
  final int currentIndex;
  const ItemNotificationWidget({
    super.key,
    required this.iconAsset,
    required this.subtitle,
    required this.onTap,
    required this.day,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: currentIndex == index
              ? const Color.fromRGBO(149, 229, 255, 0.28)
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          child: Row(
            children: [
              const SizedBox(height: 5),
              SvgPicture.asset(
                iconAsset,
                fit: BoxFit.cover,
                color: const Color.fromRGBO(68, 78, 114, 1),
              ),
              const SizedBox(
                width: 23,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      day,
                      style: const TextStyle(
                        fontFamily: 'Overpass',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      UtilsWidget.parseHtmlString(subtitle),
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                        fontFamily: 'Overpass',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              const Icon(Icons.expand_more)
            ],
          ),
        ),
      ),
    );
  }
}
