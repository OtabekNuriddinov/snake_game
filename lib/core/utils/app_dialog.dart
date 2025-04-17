import 'package:flutter/material.dart';

sealed class AppDialog {
  static Future<dynamic> showMyDialog({
    required BuildContext context,
    required String mainText,
    required String text,
    required String pressText,
    required void Function() press,
  }) {
    return showDialog(
    barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  mainText,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.center,
                  text,
                  style: TextStyle(
                    color: Colors.grey.shade300,
                      fontSize: 16, letterSpacing: 1),
                )
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: press,
                      child: Text(
                        pressText,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

            ],
          );
        });
  }
}
