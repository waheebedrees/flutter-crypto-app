import 'package:flutter/material.dart';

class AppColors {
  // Content Colors
  static const Color contentColorBlack = Color(0xFF333333);
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFF5A266); // Bitcoin Color
  static const Color contentColorOrange = Color(0xFFFF8646);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);

  // Background Colors
  static const Color backgroundColor = Color(0xff1A1E28);
  static const Color primaryColor = Color(0xff262f40);
  static const Color secondaryColor = Color(0xff3C495D);
  static const Color accentColor = Color(0xFFCBCBB1);
  static const Color greyColor = Color(0xFF999999);

  static const thirdColor = Color(0xFF2e2f45);
  static final blackColor = Color(0xFF333333);
  static final orangeColor = Color(0xFFFF8646);
  static const whiteColor = Colors.white;
  static final borderColor = Color(0xFFEAEAEA);

  // Additional Colors (from AppColors)
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  // Cryptocurrency Colors
  static const Color bitcoinColor = Color(0xFFF5A266);
  static const Color ethereumColor = Color(0xFFA7DEFE);
  static const Color tronColor = Color(0xFF950919);

  // Box Colors
  static const Color boxEndColor = Color(0xFF8174CF);
  static const Color walletBackColor = Color(0xFF9E9595);
  static const Color boxStartColor = Color(0xFF5A52AA);
}

Color getColorForSymbol(String symbol) {
  switch (symbol) {
    case 'BTC':
      return AppColors.bitcoinColor;
    case 'ETH':
      return AppColors.boxStartColor;
    case 'USDT':
      return AppColors.contentColorCyan;
    default:
      return AppColors.contentColorCyan;
  }
}

class MyThemeData {
  static ThemeData get lightTheme {
    return ThemeData(
      drawerTheme: DrawerThemeData(
        backgroundColor: AppColors.secondaryColor, // Avoids white background
        scrimColor:
            Colors.black.withOpacity(0.5), // Dim effect when opening drawer
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
        ),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: AppColors.secondaryColor,
        selectedColor: AppColors.primaryColor,
        iconColor: AppColors.mainTextColor1,
        textColor: AppColors.mainTextColor1,
      ),
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.pageBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        titleTextStyle: TextStyle(
          color: AppColors.mainTextColor1,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColors.mainTextColor1),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor:
            const Color(0xFF8B6F47), // Soft brown tone instead of white
        selectedItemColor: AppColors.contentColorYellow,
        unselectedItemColor: AppColors.greyColor,
        showUnselectedLabels: true,
      ),
      cardTheme: CardTheme(
        color:
            AppColors.secondaryColor, // Changed from white to secondary color
        elevation: 4, // Slight shadow for better visibility
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.secondaryColor,
        titleTextStyle: TextStyle(
          color: AppColors.contentColorBlack,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: TextStyle(color: AppColors.mainTextColor2),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.mainTextColor1,
        ),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.mainTextColor2),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.contentColorYellow,
          foregroundColor: AppColors.mainTextColor1,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(GlobalStyle.borderRadius),
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        filled: true,
        fillColor: AppColors.secondaryColor,
        hintStyle: TextStyle(color: AppColors.mainTextColor3),
        labelStyle: TextStyle(color: AppColors.mainTextColor1),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      drawerTheme: DrawerThemeData(
        backgroundColor: AppColors.backgroundColor, // Dark theme background
        scrimColor: Colors.black.withOpacity(0.7),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
        ),
      ),
      listTileTheme: ListTileThemeData(
        selectedColor: AppColors.contentColorYellow,
        iconColor: AppColors.accentColor,
        textColor: AppColors.accentColor,
      ),
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        titleTextStyle: TextStyle(
          color: AppColors.mainTextColor1,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColors.mainTextColor1),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.menuBackground,
        selectedItemColor: AppColors.contentColorYellow,
        unselectedItemColor: AppColors.greyColor,
        showUnselectedLabels: true,
      ),
      cardTheme: CardTheme(
        color: AppColors.gridLinesColor, // Matches dark theme
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.secondaryColor,
        titleTextStyle: TextStyle(
          color: AppColors.accentColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: TextStyle(color: AppColors.mainTextColor2),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.accentColor,
        ),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.mainTextColor2),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.contentColorYellow,
          foregroundColor: AppColors.mainTextColor1,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(GlobalStyle.borderRadius),
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        filled: true,
        fillColor: AppColors.secondaryColor,
        hintStyle: TextStyle(color: AppColors.mainTextColor3),
        labelStyle: TextStyle(color: AppColors.accentColor),
      ),
    );
  }
}

class GlobalStyle {
  static TextStyle textStyle(Color color, double fontSize,
      {bool bold = false}) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'IranSansRegular',
      height: textHeight,
    );
  }

  static const double borderRadius = 10;
  static const double borderThickness = 1;
  static const double textHeight = 1.5;
  static const double paddingInsetAll = 20;

  // Text Styles
  static final textH0Primary = textStyle(AppColors.primaryColor, 12);
  static final textH1Primary = textStyle(AppColors.primaryColor, 14);
  static final textH2Primary = textStyle(AppColors.primaryColor, 16);
  static final textH3Primary = textStyle(AppColors.primaryColor, 18);

  static final textH0BPrimary =
      textStyle(AppColors.primaryColor, 12, bold: true);
  static final textH1BPrimary =
      textStyle(AppColors.primaryColor, 14, bold: true);
  static final textH2BPrimary =
      textStyle(AppColors.primaryColor, 16, bold: true);
  static final textH3BPrimary =
      textStyle(AppColors.primaryColor, 18, bold: true);

  static final textH0Secondary = textStyle(AppColors.secondaryColor, 12);
  static final textH1Secondary = textStyle(AppColors.secondaryColor, 14);
  static final textH2Secondary = textStyle(AppColors.secondaryColor, 16);
  static final textH3Secondary = textStyle(AppColors.secondaryColor, 18);

  static final textH0BSecondary =
      textStyle(AppColors.secondaryColor, 12, bold: true);
  static final textH1BSecondary =
      textStyle(AppColors.secondaryColor, 14, bold: true);
  static final textH2BSecondary =
      textStyle(AppColors.secondaryColor, 16, bold: true);
  static final textH3BSecondary =
      textStyle(AppColors.secondaryColor, 18, bold: true);

  static final textH0BWhite =
      textStyle(AppColors.contentColorWhite, 12, bold: true);
  static final textH1BWhite =
      textStyle(AppColors.contentColorWhite, 14, bold: true);

  static final textH0White = textStyle(AppColors.contentColorWhite, 12);

  static final textH0Grey = textStyle(AppColors.greyColor, 12);
}


const backgroundColor = Color(0xff1A1E28);
const primaryColor = Color(0xff262f40);
const secondaryColor = Color(0xff3C495D);

const backgroundTextColor = Color(0xffeef1f4);
const primaryTextColor = Color(0xffb1bccd);

const backgroundColor2 = Color.fromARGB(255, 30, 37, 55);
