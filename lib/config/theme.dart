import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    fontFamily: 'San Francisco',
  );
}

const kPrimaryColor = Color.fromARGB(255, 157, 83, 231);
const kPrimaryLightColor = Color(0xFFF1E6FF);

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.grey[500],
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Colors.grey[600],
    ),
  );
}

Color? tealColor = Colors.teal[300];
Color? blueColor = Colors.blue;
Color? whiteColor = Colors.white;
Color? greyColor = Colors.grey;
Color? redColor = Colors.red;
Color? redColor200 = Colors.red[200];
Color? blackColor = Colors.black;
Color? blackCoffeeColor = const Color(0xFF3B2F2F);

const kPurple = Color(0xFF6F51FF);
const kYellow = Color(0xFFFFAD03);
const kGreen = Color(0xFF22B274);
const kPink = Color(0xFFEB1E79);
const kIndigo = Color(0xFF000A45);
const kBlack = Color(0xFF4C4C4C);
const kGrey = Color(0xFFACACAC);

var kTitleStyle = GoogleFonts.roboto(
  color: kBlack,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);
var kSubtitleStyle = GoogleFonts.roboto(
  color: kGrey,
  fontSize: 16.0,
);
var kTitleItem = GoogleFonts.roboto(
  color: kBlack,
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
);
var kSubtitleItem = GoogleFonts.roboto(
  color: kGrey,
  fontSize: 12.0,
);
var kHintStyle = GoogleFonts.roboto(
  color: kGrey,
  fontSize: 12.0,
);
