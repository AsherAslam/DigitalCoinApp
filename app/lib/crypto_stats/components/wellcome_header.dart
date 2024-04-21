import 'package:flutter/material.dart';

class WellcomeHeader extends StatelessWidget {
  const WellcomeHeader({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome,',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                username,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ],
          ),
          CircleAvatar(
            child: Text(username[0].toUpperCase()),
          )
        ],
      ),
    );
  }
}
