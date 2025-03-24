import 'package:flutter/material.dart';

class colors {
  //HSLColor color = new HSLColor.fromAHSL(alpha, hue, saturation, lightness)
  static bool darkMode=false;
  static HSLColor Snow = new HSLColor.fromAHSL(1, 348, 1, 0.99);
  static HSLColor TiffanyBlue = new HSLColor.fromAHSL(1, 170, 0.64, 0.69);
  static HSLColor Persiangreen = new HSLColor.fromAHSL(1, 171, 0.50, 0.40);
  static HSLColor Jet = new HSLColor.fromAHSL(1, 75, 0.05, 0.016);
  static HSLColor Night = new HSLColor.fromAHSL(1, 180, 0.05, 0.08);

  static void changeMode()
  {
    if(darkMode==false)
    {
      Snow = new HSLColor.fromAHSL(1, 215, 0.08, 0.09);
      Jet = new HSLColor.fromAHSL(1, 348, 1, 0.99);
      Night = new HSLColor.fromAHSL(1, 75, 0.05, 0.016);
      Persiangreen=Persiangreen.withLightness(0.25);
      darkMode=true;
    }
    else{
      Snow = new HSLColor.fromAHSL(1, 348, 1, 0.99);
      TiffanyBlue = new HSLColor.fromAHSL(1, 170, 0.64, 0.69);
      Persiangreen = new HSLColor.fromAHSL(1, 171, 0.50, 0.40);
      Jet = new HSLColor.fromAHSL(1, 75, 0.05, 0.016);
      Night = new HSLColor.fromAHSL(1, 180, 0.05, 0.08);
      darkMode=false;
    }
    print(Snow.toColor());
  }
}