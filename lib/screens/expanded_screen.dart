import 'widget.dart';
import 'models/models.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ExpandedScreen extends StatelessWidget {
  final DiscipleshipHymnaryModel hymnaryModelExpanded;
  final double fontSize;

  const ExpandedScreen({super.key, required this.hymnaryModelExpanded, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 40, 10, 40),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Text(
                        hymnaryModelExpanded.id.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 60.0,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                hymnaryModelExpanded.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                hymnaryModelExpanded.bibleText,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: fontSize,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              hymnaryModelExpanded.key,
                              style: TextStyle(
                                fontSize: fontSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            tooltip: 'Resize Screen',
                            icon: Icon(
                              Icons.reset_tv_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          HymnTune(hymnMusicPath: hymnaryModelExpanded.hymnMusic),
                          IconButton(
                            onPressed: (){
                              _onShare(context);
                            },
                            icon: Icon(
                                Icons.share,
                                color: Theme.of(context).primaryColor
                            ),
                            tooltip: "Share Hymn",
                          ),
                        ],
                      )
                    ],
                  ),
                  Divider(color: Theme.of(context).primaryColor, thickness: 2),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Text(
                      hymnaryModelExpanded.verses,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          children: [
                            Text(
                              'Text: ${hymnaryModelExpanded.text}',
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'Music: ${hymnaryModelExpanded.music}',
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          children: [
                            Text(
                              hymnaryModelExpanded.hymnTune,
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              hymnaryModelExpanded.meter,
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(hymnaryModelExpanded.verses,
        subject: hymnaryModelExpanded.title,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
