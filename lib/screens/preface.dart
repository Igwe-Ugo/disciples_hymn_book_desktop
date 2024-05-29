import 'dart:convert';
import 'package:provider/provider.dart';

import 'common/widget.dart';
import 'models/models.dart';
import 'package:flutter/material.dart';

class PrefaceScreen extends StatefulWidget {
  const PrefaceScreen({super.key});
  @override
  State<PrefaceScreen> createState() => _PrefaceScreenState();
}

class _PrefaceScreenState extends State<PrefaceScreen> {
  late Future<List<PrefaceModel>> prefaceFuture;

  @override
  void initState(){
    super.initState();
    prefaceFuture = readPrefaceData(context);
  }

  @override
  Widget build(BuildContext context) {    
    final fontSizeNotifier = Provider.of<FontSizeNotifier>(context);
    
    return Scaffold(
      body: FutureBuilder(
        future: readPrefaceData(context),
        builder: (context, data){
          if (data.hasError){
            return Center(
              child: Text('${data.error}')
            );
          } else if (data.hasData){
            var prefaceItems = data.data as List<PrefaceModel>;
            return SingleChildScrollView(
              child: Card(
                elevation: 10,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(30),
                          child: Column(
                            children: [
                              for (var i in prefaceItems)
                              Text(
                                i.vision,
                                style: TextStyle(
                                  fontSize: fontSizeNotifier.fontSize.toDouble(),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'preface'.toUpperCase(),
                        style: TextStyle(
                          fontSize: fontSizeNotifier.fontSize.toDouble(),
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      for (var i in prefaceItems)
                      Text(
                        i.preface,
                        style: TextStyle(
                          fontSize: fontSizeNotifier.fontSize.toDouble(),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 10,),
                      for (var i in prefaceItems)
                      Text(
                        i.auditor,
                        style: TextStyle(
                          fontSize: fontSizeNotifier.fontSize.toDouble(),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10,),
                      Divider(thickness: 3, color: Theme.of(context).primaryColor),
                      const SizedBox(height: 10),
                      Text(
                        'dedication'.toUpperCase(),
                        style: TextStyle(
                          fontSize: fontSizeNotifier.fontSize.toDouble(),
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      for (var i in prefaceItems)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          i.dedication,
                          style: TextStyle(
                            fontSize: fontSizeNotifier.fontSize.toDouble(),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          }else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
        }
      ),
    );
  }

  Future<List<PrefaceModel>> readPrefaceData(BuildContext context) async{
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/json/preface.json');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => PrefaceModel.fromJson(e)).toList();
  }
}