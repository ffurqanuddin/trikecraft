import 'package:flutter/cupertino.dart';

class ItemRowWidget extends StatelessWidget {
  const ItemRowWidget({super.key, required this.label, required this.val});

  final String label;
  final dynamic val;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            val.toString(),
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
