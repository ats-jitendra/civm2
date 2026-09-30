import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const RoundButton(
      {Key? key,
      required this.title,
      this.loading = false,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.only(left: 40, right: 40, bottom: 10.0),
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration:  BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
            ],
            gradient: const LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
              ],
            )),
        child: Row(children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: loading
                  ? const CircularProgressIndicator(
                      color: AppColors.baseColor,
                    )
                  : Text(
                      title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: AppColors.baseColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
            ),
          ),
        ]),
      ),
    );
  }
}
