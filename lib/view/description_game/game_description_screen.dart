import 'package:feed_the_cat_app/view/description_game/game_description_constants.dart';
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
    slides.add(_descriptionSlide(
      title: GameDescriptionConstants.feedTheCatTitle,
      description: GameDescriptionConstants.feedTheCatDescription,
      image: GameDescriptionConstants.feedTheCatImage,
    ));
    slides.add(_descriptionSlide(
      title: GameDescriptionConstants.guitarHeroTitle,
      description: GameDescriptionConstants.guitarHeroDescription,
      image: GameDescriptionConstants.guitarHeroImage,
    ));
    slides.add(_descriptionSlide(
      title: GameDescriptionConstants.savingResultTitle,
      description: GameDescriptionConstants.savingResultDescription,
      image: GameDescriptionConstants.savingResultImage,
    ));
    slides.add(_descriptionSlide(
      title: GameDescriptionConstants.resultsTitle,
      description: GameDescriptionConstants.resultsDescription,
      image: GameDescriptionConstants.resultsImage,
    ));
    slides.add(_descriptionSlide(
      title: GameDescriptionConstants.progressesTitle,
      description: GameDescriptionConstants.progressesDescription,
      image: GameDescriptionConstants.progressesImage,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: slides,
      renderSkipBtn: _renderSkipBtn(),
      renderNextBtn: _renderNextBtn(),
      renderDoneBtn: _renderDoneBtn(),
      onDonePress: _onDonePress,
      colorDot: Colors.black38,
      colorActiveDot: Colors.blue,
      sizeDot: 13.0,
      typeDotAnimation: dotSliderAnimation.DOT_MOVEMENT,
      hideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,
      verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
    );
  }

  Slide _descriptionSlide(
      {@required title, @required description, @required image}) {
    return Slide(
      title: title,
      styleTitle: const TextStyle(
        color: Colors.black,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
      description: description,
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
      pathImage: image,
      backgroundColor: Colors.white,
    );
  }

  void _onDonePress() {
    Navigator.pop(context);
  }

  Widget _renderNextBtn() {
    return const Icon(
      Icons.navigate_next,
      color: Colors.black38,
      size: 35.0,
    );
  }

  Widget _renderDoneBtn() {
    return const Icon(
      Icons.done,
      color: Colors.black38,
    );
  }

  Widget _renderSkipBtn() {
    return const Icon(
      Icons.skip_next,
      color: Colors.black38,
    );
  }
}
