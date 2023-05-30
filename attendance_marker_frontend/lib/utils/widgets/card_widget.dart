import 'package:attendance_marker_frontend/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../constants/size_constants.dart';

class CardWidget {
  static functionAdminHomeCardWidget(screenHeight, screenWidth, image,
      titleTextValue, subTitleTextValue, context) {
    var cardWidth = screenWidth - (SizeConstants.cardPaddingAll * 2);
    var cardHieght = screenHeight - (SizeConstants.cardPaddingAll);
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(SizeConstants.adminCardBorderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: cardHieght / 4,
                width: cardWidth / 3,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            SizeConstants.adminCardBorderRadius),
                        bottomLeft: Radius.circular(
                            SizeConstants.adminCardBorderRadius)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      image,
                      fit: BoxFit.contain,
                    ),
                  ),
                )),
            SizedBox(
                height: cardHieght / 4,
                width: cardWidth * 2 / 3,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: ColorConstants.primaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                            SizeConstants.adminCardBorderRadius),
                        bottomRight: Radius.circular(
                            SizeConstants.adminCardBorderRadius)),
                  ),
                  child: Center(
                    child: ListTile(
                      title: Text(
                        titleTextValue,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConstants.cardTitleFontSize,
                          color: ColorConstants.adminCardTextColor,
                        ),
                      ),
                      subtitle: Text(
                        subTitleTextValue,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConstants.cardSubTitleFontSize,
                          color: ColorConstants.adminCardTextColor,
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
