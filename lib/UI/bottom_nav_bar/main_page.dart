import 'package:BeauT_Stylist/Base/AllTranslation.dart';
import 'package:BeauT_Stylist/UI/bottom_nav_bar/hom_page.dart';
import 'package:BeauT_Stylist/UI/component/drawer.dart';
import 'package:BeauT_Stylist/UI/side_menu/services.dart';
import 'package:BeauT_Stylist/helpers/shared_preference_manger.dart';
import 'package:flutter/material.dart';
import 'Beautican_schedule.dart';
import 'more.dart';

class MainPage extends StatefulWidget {
  final int index;

  const MainPage({Key key, this.index}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPageIndex = 0;
  bool isBottomNavigationVisible = true;
  PageController mainPageController = PageController(initialPage: 0);
  List<Widget> pages = [
    HomePage(),
    BeauticanTimes(),
    MyService(),
    More(),
  ];

  String name, image, rate;

  void getFromCash() async {
    String _name, _image, _rate;

    var mSharedPreferenceManager = SharedPreferenceManager();
    _name = await mSharedPreferenceManager.readString(CachingKey.USER_NAME);
    _image = await mSharedPreferenceManager.readString(CachingKey.USER_IMAGE);
    _rate = await mSharedPreferenceManager.readString(CachingKey.RATE);
    setState(() {
      name = _name;
      image = _image;
      rate = "3.5";
    });

    print("Valuee ===>${name}");
    print("Valuee ===>${image}");
    print("Valuee ===>${rate}");
  }

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _onItemTapped(int index) {
    index == 3
        ? _drawerKey.currentState.openEndDrawer()
        : setState(() {
            selectedPageIndex = index;
          });
  }

  @override
  void initState() {
    getFromCash();
    if (widget.index == null) {
      setState(() {
        selectedPageIndex = 0;
      });
    } else {
      selectedPageIndex = widget.index;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: allTranslations.currentLanguage == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
          endDrawer: MyDrawer(
            image: image,
            name: name,
            rate: rate ?? "3.5",
          ),
          key: _drawerKey,
          bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: true,
              selectedIconTheme: IconThemeData(
                  size: 26, color: Theme.of(context).primaryColor),
              unselectedIconTheme: IconThemeData(size: 20, color: Colors.grey),
              showSelectedLabels: true,
              type: BottomNavigationBarType.shifting,
              currentIndex: selectedPageIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: 30,
                      color: Colors.grey,
                    ),
                    activeIcon: Icon(
                      Icons.home,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(allTranslations.text("home"),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ))),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.calendar_today,
                      size: 30,
                      color: Colors.grey,
                    ),
                    activeIcon: Icon(
                      Icons.calendar_today,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(allTranslations.text("appointments"),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ))),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.content_cut,
                      size: 30,
                      color: Colors.grey,
                    ),
                    activeIcon: Icon(
                      Icons.content_cut,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(allTranslations.text("services"),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ))),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                      size: 30,
                      color: Colors.grey,
                    ),
                    activeIcon: Icon(
                      Icons.menu,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(allTranslations.text("more"),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ))),
              ],
              onTap: _onItemTapped),
          body: pages[selectedPageIndex]),
    );
  }
}
