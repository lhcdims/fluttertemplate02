// This program 'Template Settings' sets the screen/font height/width etc.

import 'dart:ui';

class clsSettings {
  // Top/Body/Bottom Height Ratio
  static double dblTopHeightRatio = 0.07;
  static double dblBodyHeightRatio = 0.83;
  static double dblBottomHeightRatio = 0.1;
  static double dblDefaultFontSizeRatio = 0.025;

  // No. of space for setting the width of Big Button
  static double gintSpaceBigButton = 25;

  // Screen Height
  static double dblScreenHeight = window.physicalSize.height / window.devicePixelRatio;

  // Screen Width
  static double dblScreenWidth = window.physicalSize.width / window.devicePixelRatio;

  // Smaller of Height & Width
  static double dblScreenSmaller = 0;

  // Larger of Height & Width
  static double dblScreenLarger = 0;


  // Top/Body/Bottom Height
  static double dblTopHeight = 0;
  static double dblBodyHeight = 0;
  static double dblBottomHeight = 0;

  // Default Font Size
  static double dblDefaultFontSize = 0;

  // Default Round Radius
  static double dblDefaultRoundRadius = 0;

  // Init Function
  static void Init() {
    // Set Smaller of Height and Width
    if (dblScreenHeight > dblScreenWidth) {
      dblScreenSmaller = dblScreenWidth;
      dblScreenLarger = dblScreenHeight;
    } else {
      dblScreenSmaller = dblScreenHeight;
      dblScreenLarger = dblScreenWidth;
    }

    // Set Top/Body/Bottom Height
    dblTopHeight = dblScreenHeight * dblTopHeightRatio;
    dblBodyHeight = dblScreenHeight * dblBodyHeightRatio;
    dblBottomHeight = dblScreenHeight * dblBottomHeightRatio;

    // Set Default Font Size
    dblDefaultFontSize = dblScreenLarger * dblDefaultFontSizeRatio;

    // Set Default Round Radius
    dblDefaultRoundRadius = dblDefaultFontSize;
  }
}

