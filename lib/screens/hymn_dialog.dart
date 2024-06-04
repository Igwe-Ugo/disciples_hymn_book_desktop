import 'widget.dart';
import 'common/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'models/discipleship_hymnary_model.dart';

class HymnDialog extends StatelessWidget {
  final DiscipleshipHymnaryModel hymnaryModel;

  const HymnDialog({super.key, required this.hymnaryModel});

  @override
  Widget build(BuildContext context) {
    final fontSizeNotifier = Provider.of<FontSizeNotifier>(context);
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(5.0),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(7, 40, 7, 40),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        hymnaryModel.id.toString(),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                hymnaryModel.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeNotifier.fontSize.toDouble(),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                hymnaryModel.bibleText,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeNotifier.fontSize.toDouble(),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              hymnaryModel.key,
                              style: TextStyle(
                                fontSize: fontSizeNotifier.fontSize.toDouble(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          HymnTune(hymnMusicPath: hymnaryModel.hymnMusic),
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
                      ),
                    ],
                  ),
                  Divider(color: Theme.of(context).primaryColor, thickness: 2,),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Text(
                      hymnaryModel.verses,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSizeNotifier.fontSize.toDouble()
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
                              'Text: ${hymnaryModel.text}',
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'Music: ${hymnaryModel.music}',
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
                              hymnaryModel.hymnTune,
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              hymnaryModel.meter,
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
      )
    );
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(hymnaryModel.verses,
        subject: hymnaryModel.title,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
