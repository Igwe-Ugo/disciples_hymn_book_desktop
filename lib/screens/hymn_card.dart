import 'models/models.dart';
import 'package:flutter/material.dart';

class HymnCard extends StatelessWidget {
  const HymnCard({
    super.key,
    required this.hymns,
    required double fontSize,
    required this.onTap,
    required this.fromHome,
  }) : _fontSize = fontSize;

  final DiscipleshipHymnaryModel hymns;
  final double _fontSize;
  final void Function(int) onTap;
  final bool fromHome;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(hymns.id);
        if (!fromHome) {
          Navigator.of(context).pop();
        }
      },
      child: Card(
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
          leading: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            constraints: const BoxConstraints(
              minWidth: 30,
              minHeight: 30,
            ),
            child: Text(
              hymns.id.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: _fontSize,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          title: Text(
            hymns.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              fontSize: 15.0,
            ),
          ),
          subtitle: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              hymns.verses,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: _fontSize,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}
