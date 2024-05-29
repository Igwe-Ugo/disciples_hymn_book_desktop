import 'screens/widget.dart';
import 'screens/common/widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Styles.init();
  runApp(const DiscipleHymnBookDesktop());
}

class DiscipleHymnBookDesktop extends StatefulWidget{
  const DiscipleHymnBookDesktop({super.key});
  // ignore: library_private_types_in_public_api
  static _DiscipleHymnBookDesktopState of(BuildContext context) => context.findAncestorStateOfType<_DiscipleHymnBookDesktopState>()!;

  @override
  State<DiscipleHymnBookDesktop> createState() => _DiscipleHymnBookDesktopState();
}

class _DiscipleHymnBookDesktopState extends State<DiscipleHymnBookDesktop>{
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  // ignore: unused_field
  Color _themeColor = Styles.selectedColor ?? Colors.blue;

  void changeTheme(Color color){
    setState(() {
      _themeColor = color;
    });
  }

  @override
  void initState(){
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async{
    themeChangeProvider.darkTheme = await themeChangeProvider.discipleshipHymnaryPreferences.getTheme();
  }

  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_){
            return themeChangeProvider;
          },
        ),
        ChangeNotifierProvider(
          create: (context) => FontSizeNotifier()),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeData, child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Discipleship Hymnary',
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: const DiscipleHymnBookDesktopSplashScreen(),
          );
        }
      ),
    );
  }
}
