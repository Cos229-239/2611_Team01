import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}



class RollingLetter extends StatefulWidget{
  final String letter;
  final Duration delay;

  const RollingLetter({
    super.key,
    required this.letter,
    required this.delay,

});

  @override
  State<RollingLetter> createState() => _RollingLetterState();

}


class _RollingLetterState extends State<RollingLetter>
    with TickerProviderStateMixin{

  late AnimationController  _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<Offset> _bounceAnimation;
  late AnimationController  _bounceController;

  @override
  void initState() {
    super.initState(); // initState()

    _controller = AnimationController(
      duration: const Duration(seconds: 30),
      // drop speed for logo should be 10 sec
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
        begin: const Offset(-20, 0),
        end: Offset.zero
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ),
    );

    _rotationAnimation = Tween<double>(
      begin: -2.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ),
    );

    _bounceController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _bounceAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.8),
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeOut,
    ),
    );

    _controller.forward().then((_) {
      _bounceController.forward().then((_) {
        _bounceController.reverse();
      });
    });

  }
    @override
    void dispose(){              // disposal()/deconstructor
      _controller.dispose();
      _bounceController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context){
    return SlideTransition(position: _slideAnimation,
      child: SlideTransition(position: _bounceAnimation,
        child: RotationTransition(turns: _rotationAnimation,
          child: Text(widget.letter)
        ),
      ),
    );
  }


  }

class _SplashScreenState extends State<SplashScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: RollingLetter(letter: 'R',delay: Duration(milliseconds: 350))
      )
    );
  }











}
