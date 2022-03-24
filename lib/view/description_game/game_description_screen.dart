import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';

class GameDescriptionScreen extends StatefulWidget {
  const GameDescriptionScreen({Key? key}) : super(key: key);

  @override
  _GameDescriptionScreenState createState() => _GameDescriptionScreenState();
}

class _GameDescriptionScreenState extends State<GameDescriptionScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    slides.add(
      Slide(
        title: 'Feed the Cat Game',
        styleTitle: const TextStyle(
          color: Colors.black,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        description:
            "To feed the Cat, press the button \"Feed\". Every 15 points there will be a Cat animation.",
        styleDescription: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
        ),
        marginDescription: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
        pathImage: 'assets/images/first_slide.png',
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      Slide(
        title: 'GuitarHero Game',
        styleTitle: const TextStyle(
          color: Colors.black,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        description: "Click on the buttons of the same color to add points.",
        styleDescription: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
        ),
        marginDescription: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          bottom: 70.0,
        ),
        pathImage: 'assets/images/second_slide.png',
        backgroundColor: Colors.white,
      ),
    );
    super.initState();
  }

  void onDonePress() {
    Navigator.pop(context);
  }

  Widget renderNextBtn() {
    return const Icon(
      Icons.navigate_next,
      color: Colors.black38,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return const Icon(
      Icons.done,
      color: Colors.black38,
    );
  }

  Widget renderSkipBtn() {
    return const Icon(
      Icons.skip_next,
      color: Colors.black38,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: slides,
      renderSkipBtn: renderSkipBtn(),
      renderNextBtn: renderNextBtn(),
      renderDoneBtn: renderDoneBtn(),
      onDonePress: onDonePress,
      colorDot: Colors.black38,
      colorActiveDot: Colors.blue,
      sizeDot: 13.0,
      typeDotAnimation: dotSliderAnimation.DOT_MOVEMENT,
      hideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,
      verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
    );
  }
}
