import 'package:flutter/material.dart';
import 'package:snake_game/app_state/change_notifier.dart';

class InheritedData extends InheritedWidget{
  final AppController appController;
  const InheritedData({super.key, required this.appController, required super.child});


  static InheritedData? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<InheritedData>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedData oldWidget) {
    return oldWidget.appController != appController;
  }

}