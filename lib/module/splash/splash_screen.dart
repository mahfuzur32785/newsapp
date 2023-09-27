import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/remote_name.dart';
import 'package:newsapp/global_widget/custom_image.dart';
import 'package:newsapp/module/splash/controller/splash_cubit.dart';
import 'package:newsapp/utils/constant.dart';
import 'package:newsapp/utils/k_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final _className = '_SplashScreenState';
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() {
      if (mounted) setState(() {});
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashCubit, SplashState>(
          listener: (context, state) async {
            if (state is SplashStateLoaded){
              print('State Loaded');
              Navigator.pushReplacementNamed(context, RouteNames.homePage);
            }
          },

          builder: (context, state) {
            return AnimationWidget(animation: animation);
          }
      ),
    );
  }
}

class AnimationWidget extends StatelessWidget {
  const AnimationWidget({
    Key? key,
    required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [whiteColor, whiteColor],
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // child: const CustomImage(path: Kimages.backgroundShape),
          child: const SizedBox(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomImage(
              path: Kimages.appLogo,
              width: animation.value * 250,
              height: animation.value * 250,
            ),
            const SizedBox(height: 50),
            const Center(child: CircularProgressIndicator(color: Color(0xFF3F51B5),))
          ],
        ),
      ],
    );
  }
}
