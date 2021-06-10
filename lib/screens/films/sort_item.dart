import 'package:flutter/material.dart';

class SortItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final Function()? onTap;

  const SortItem({
    Key? key,
    required this.label,
    required this.icon,
    this.selected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _wrap(
      child: Column(
        children: [
          Icon(icon, color: selected ? Colors.deepOrange : Colors.black),
          Text(label, style: TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  Widget _wrap({required Widget child}) {
    if (selected) return Container(child: child);

    return InkWell(onTap: onTap, child: child);
  }
}
