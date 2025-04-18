import 'package:flutter/material.dart';
import 'package:snake_game/app_state/inherited_data.dart';

import '../core/components/game_controls.dart';
import '../core/components/game_view.dart';

class Home extends StatefulWidget {
  static const id = "/home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double screenWidth;
  late double screenHeight;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    final inheritedData = InheritedData.of(context);
    final controller = inheritedData!.appController;
    return Scaffold(
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _){
          if(controller.isGameOver){
            WidgetsBinding.instance.addPostFrameCallback((_){
              controller.showGameOverDialog(context);
            });
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: GameView(
                    row: controller.row,
                    column: controller.column,
                    fillBoxColor: controller.fillBoxColor,
                  )
              ),
              GameControls(
                  screenWidth: screenWidth,
                  score: controller.score,
                  direction: controller.direction,
                  onDirectionChanged: (newDirection){
                    controller.changeDirection(newDirection);
                  })
            ],
          );
        },
      ),
    );
  }

}


