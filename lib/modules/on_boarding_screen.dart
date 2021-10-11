import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yalla_hagz/Network/local/cache_helper.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';

import 'login/login_screen.dart';

class OnBoardingScreen extends StatelessWidget{
  var boardingController = PageController();
  bool isLast = false;

  @override
  List<BoardModel> boarding = [
    BoardModel(
      images: defaultCarouselSliderAsset(
          images: [
            "assets/images/random_number_screen.jpeg",
            "assets/images/alert_random_number.jpeg"
          ]
      ),
      title: 'The Random Number',
      body: 'This screen will appear before your 7agz so you have to enter the random number given by the admin at the school',
    ),
    BoardModel(
      images: defaultCarouselSliderAsset(
          images: [
            "assets/images/rating_screen.jpeg",
            "assets/images/alert_rating.jpeg"
          ]
      ),
      title: 'Rate your experience!',
      body: 'After your 7agz, you can rate your experience',
    ),
    BoardModel(
      images: Image.asset(
        "assets/images/cup_and_arrow.jpg",
        // width: double.infinity,
        height: 200,
      ),
      title: 'Tournaments',
      body: 'Tournaments will be available soon. Stay tuned!',
    ),
  ];
  void submit(context) {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value)
    {
      if (value) {
        navigateAndReplace(
          context,
          LoginScreen(),
        );
      }
    });
  }

  Widget buildBoarding(BoardModel model,BuildContext context) => Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        model.images,
        const SizedBox(
            height: 20
        ),
        Text(
          model.title,
          style: TextStyle(
              color: defaultColor,
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(
            height: 20
        ),
        Text(
          model.body,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 20
          ),
          textAlign: TextAlign.center,
        ),

      ],
    ),
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   defaultTextButton(
        //     text: 'Skip',
        //     function: () {
        //       submit(context);
        //     } ,
        //   ),
        // ],
      ),
      body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardingController,
                itemBuilder: (context , index) => buildBoarding(boarding[index],context),
                itemCount: boarding.length,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    isLast = true;
                  }
                  if (index != boarding.length - 1) {
                    isLast = false;
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 30.0
                  ),
                  child: SmoothPageIndicator(
                      effect: WormEffect(
                        activeDotColor: defaultColor,

                      )  ,
                      controller: boardingController,
                      count: boarding.length
                  ),
                ),
              ],
            ),
          ]
      ),
      floatingActionButton: FloatingActionButton(

          child: const Icon(
              Icons.arrow_forward_ios_sharp
          ),
          backgroundColor: defaultColor,
          onPressed: (){
            if (isLast) {
              submit(context);
            } else {
              boardingController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
            }
          }
      ),
    );
  }

}
class BoardModel {
  final Widget images;
  final String title;
  final String body;
  BoardModel({
    required this.images ,
    required this.title ,
    required this.body ,
  });
}
