import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // const Text(
            //   "Welcome",
            //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            // ),

            Text.rich(
              TextSpan(
                text: "Welcome \n",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 17),
                children: [
                  TextSpan(
                      text:
                      "Pujan",
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),

            Text(
              "JoJoLaPa",
              style: GoogleFonts.dancingScript(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  color: Colors.yellow),
            ),

            // IconBtnWithCounter(
            //     svgSrc: "assets/icons/Cart Icon.svg",
            //     press: () => Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const CartScreen()),
            //     )),
          ],
        ),
      ),
    );
  }
}
