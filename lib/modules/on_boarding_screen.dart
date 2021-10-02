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
      image: 'assets/images/empty_ball.png',
      title: 'Yala 7agz',
      body: 'Your friend in reserving football matches',
    ),
    BoardModel(
      image: 'assets/images/empty_ball.png',
      title: '7agz yala',
      body: 'Your friend in discovering new schools',
    ),
    BoardModel(
      image: 'assets/images/empty_ball.png',
      title: '7agz yala 7agz',
      body: 'Your friend in winning football tournaments',
    ),
  ];
  void submit(context) {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value)
    {
      if (value) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    });
  }

  Widget buildBoarding(BoardModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: 300,
        width: 300,
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
          height: 20
      ),
      Text(
        '${model.title}',
        style: TextStyle(
            color: defaultColor,
            fontSize: 30,
            fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(
          height: 20
      ),
      Text(
        '${model.body}',
      ),

    ],
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            text: 'Skip',
            function: () {
              submit(context);
            } ,
          ),

        ],
      ),
      body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardingController,
                itemBuilder: (context , index) => buildBoarding(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1)
                    isLast = true;
                  if (index != boarding.length - 1)
                    isLast = false;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 30.0),
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

          child: Icon(
              Icons.arrow_forward_ios_sharp
          ),
          backgroundColor: defaultColor,
          onPressed: (){
            if (isLast)
              submit(context);
            else
              boardingController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
          }
      ),
    );
  }

}
class BoardModel {
  final String image;
  final String title;
  final String body;
  BoardModel({
    required this.image ,
    required this.title ,
    required this.body ,
  });
}
