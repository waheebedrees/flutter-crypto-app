import 'package:app/screens/login_screen.dart';
import 'package:app/screens/main_screen.dart';
import 'package:app/utils/const.dart';
import 'package:app/utils/style.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.thirdColor,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) => OnboardingPage(
                      title: onboardingData[index]["title"]!,
                      desc: onboardingData[index]["desc"]!,
                      image: "assets/im${index + 1}.jpg",
                    )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => buildDot(index, context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => MainScreen()));
                  },
                  child: const Text(
                    "Skip",
                    style:
                        TextStyle(color: AppColors.accentColor, fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.walletBackColor,
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    if (_currentPage == onboardingData.length - 1) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => LoginScreen()));
                    } else {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
                    }
                  },
                  child: Text(
                    _currentPage == onboardingData.length - 1
                        ? " Get Started "
                        : "Next",
                    style: GlobalStyle.textH1BWhite,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: _currentPage == index ? 18 : 12,
      decoration: BoxDecoration(
        color:
            _currentPage == index ? AppColors.accentColor : AppColors.greyColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title, desc, image;

  const OnboardingPage(
      {super.key,
      required this.title,
      required this.desc,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 80),
        Image.asset(
          image,
          height: 250,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 30),
        Text(title,
            style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(desc,
              style: TextStyle(color: AppColors.greyColor, fontSize: 16),
              textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
