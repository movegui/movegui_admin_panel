import 'package:flutter/material.dart';


class CustomButon extends StatelessWidget {
  CustomButon({super.key, this.onTap, required this.text, this.icon,});
  VoidCallback? onTap;
  final IconData? icon;
  String text;
  @override
  Widget build(BuildContext context) {
    var  size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Container(
          decoration: BoxDecoration(
          
            borderRadius: BorderRadius.circular(8),
          ),
          height: 40,
              child :Center(
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icon,),
                          Text(
                            text,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

        ),
      ),
    );
  }
}
