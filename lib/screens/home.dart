// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:provider/provider.dart';

import 'widget.dart';
import 'common/widget.dart';
import 'models/models.dart';
import 'package:flutter/material.dart';

late PageController changePageController;

class DesktopScreen extends StatefulWidget {
  const DesktopScreen({super.key});
  @override
  State<DesktopScreen> createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen> {
  int screenIndex = 0;
  final double _height = 60.0;
  bool isDesktopSearch = false;
  List<DiscipleshipHymnaryModel>? desktopHymnFuture;
  int hymnIndex = 0;
  int? selectedSearchResult;

  @override
  void initState() {
    super.initState();
    changePageController = PageController();
    desktopReadJsonData(context).then(
      (value) {
        desktopHymnFuture = value;
        setState(() {});
      },
    );
  }

  void updateHymn(int value) {
    setState(() {
      hymnIndex = value - 1;
    });
    changePageController.jumpToPage(2);
  }

  @override
  Widget build(BuildContext context) {
    final fontSizeNotifier = Provider.of<FontSizeNotifier>(context);
    
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _height,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            radius: 15.0,
            backgroundColor: Colors.grey[200],
            backgroundImage: const AssetImage('assets/images/piano.jpeg'),
          ),
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            "disciples' hymn book".toUpperCase(),
            style: TextStyle(
              letterSpacing: -1.2,
              fontWeight: FontWeight.bold,
              fontSize: fontSizeNotifier.fontSize.toDouble(),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        elevation: 0.0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 20.0,
            onPressed: () async {
              if (desktopHymnFuture != null) {
                final selected = await showSearch(
                  context: context,
                  delegate: SearchHymnary(
                    allHymns: desktopHymnFuture!,
                    onSearchResultSelected: updateHymn, // Pass the updateHymn function
                  ),
                );
                // Do something with selected search result if needed
                if (selected != null){
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.32,
                    child: ListView.builder(
                      itemCount: desktopHymnFuture!.length,
                      itemBuilder: (context, desktopIndex) {
                        final desktopHymns = desktopHymnFuture![desktopIndex];
                        return HymnCard(
                          hymns: desktopHymns,
                          fontSize: fontSizeNotifier.fontSize.toDouble(),
                          fromHome: true,
                          onTap: (value) {
                            updateHymn(value);
                          },
                        );
                      },
                    ),
                  );
                }
              }
            },
            tooltip: 'Search hymnary',
          ),
        ],
      ),
      body: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.22,
            child: DiscipleshipSideBar(fontSize: fontSizeNotifier.fontSize.toDouble(),),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.005),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: PageView(
              controller: changePageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const PrefaceScreen(),
                const Settings(),
                desktopHymnFuture != null ?
                  HymnDialog(
                    hymnaryModel: desktopHymnFuture![hymnIndex],
                  ) : Container(),
              ],
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.005),
          if (desktopHymnFuture != null)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.32,
              child: ListView.builder(
                itemCount: desktopHymnFuture!.length,
                itemBuilder: (context, desktopIndex) {
                  final desktopHymns = desktopHymnFuture![desktopIndex];
                  return HymnCard(
                    hymns: desktopHymns,
                    fontSize: fontSizeNotifier.fontSize.toDouble(),
                    fromHome: true,
                    onTap: (value) {
                      updateHymn(value);
                    },
                  );
                },
              ),
            )
          else
            const Expanded(
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          //const SizedBox.shrink(),
        ],
      )
    );
  }

  Future<List<DiscipleshipHymnaryModel>> desktopReadJsonData(BuildContext context) async {
    final desktopAssetBundle = DefaultAssetBundle.of(context);
    final desktopData = await desktopAssetBundle.loadString('assets/json/discipleship_hymnary.json');
    final desktopList = json.decode(desktopData) as List<dynamic>;
    return desktopList.map((jsonItems) => DiscipleshipHymnaryModel.fromJson(jsonItems)).toList();
  }

  @override
  void dispose() {
    changePageController.dispose();
    super.dispose();
  }
}
