import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      decoration: const BoxDecoration(
          color: Color(0xff516efb),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      width: MediaQuery.sizeOf(context).width,
      height: 180,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Balance',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  r'$450,933',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  'Monthly Profit',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  r'$12,484',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff748BFC),
                      borderRadius: BorderRadius.circular(30)),
                  margin: const EdgeInsets.symmetric(vertical: 25),
                  height: 30,
                  width: 80,
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.angleUp,
                          color: Colors.green,
                          size: 12,
                        ),
                        Text(
                          "\t 10 %",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
