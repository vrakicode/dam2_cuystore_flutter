import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:proyecto_flutter/pages/config_page.dart';
import 'package:proyecto_flutter/pages/dashboard.dart';
import 'package:proyecto_flutter/pages/favorite_page.dart';
import 'package:proyecto_flutter/pages/new_product_page.dart';
import 'package:proyecto_flutter/pages/search.dart';

class IndexPage extends StatefulWidget {
  
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with SingleTickerProviderStateMixin {
  late TabController tabController;
  late int currentPage;
  final List<Color> colors = [Colors.yellow, Colors.red, Colors.green, Colors.blue, Colors.pink];
  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 5, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Color unselectedColor = colors[currentPage].computeLuminance() < 0.5 ? Colors.black : Colors.white;
    return SafeArea(
      child: Scaffold(
        body: BottomBar(
            child: TabBar(
              indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
              controller: tabController,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: currentPage == 0
                        ? colors[0]
                        : currentPage == 1
                            ? colors[1]
                            : currentPage == 2
                                ? colors[2]
                                : currentPage == 3
                                    ? colors[3]
                                    : currentPage == 4
                                        ? colors[4]
                                        : unselectedColor,
                    width: 4
                ),
                insets: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              ),
              tabs: [
                SizedBox(
                  height: 55,
                  width: 40,
                  child: Center(
                      child: Icon(
                    Icons.home,
                    color: currentPage == 0 ? colors[0] : unselectedColor,
                  )),
                ),
                SizedBox(
                  height: 55,
                  width: 40,
                  child: Center(
                      child: Icon(
                    Icons.search,
                    color: currentPage == 1 ? colors[1] : unselectedColor,
                  )),
                ),
                SizedBox(
                  height: 55,
                  width: 40,
                  child: Center(
                      child: Icon(
                    Icons.add,
                    color: currentPage == 2 ? colors[2] : unselectedColor,
                  )),
                ),
                SizedBox(
                  height: 55,
                  width: 40,
                  child: Center(
                      child: Icon(
                    Icons.favorite,
                    color: currentPage == 3 ? colors[3] : unselectedColor,
                  )),
                ),
                SizedBox(
                  height: 55,
                  width: 40,
                  child: Center(
                      child: Icon(
                    Icons.settings,
                    color: currentPage == 4 ? colors[4] : unselectedColor,
                  )),
                ),
              ]
            ),
            fit: StackFit.expand,
            icon: (width, height) => Center(
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: null,
                icon: Icon(
                  Icons.arrow_upward_rounded,
                  color: unselectedColor,
                  size: width,
                ),
              ),
            ),
            borderRadius: BorderRadius.circular(500),
            duration: Duration(seconds: 1),
            curve: Curves.decelerate,
            showIcon: true,
            width: MediaQuery.of(context).size.width * 0.8,
            barColor: colors[currentPage].computeLuminance() > 0.5 ? Colors.black : Colors.white,
            start: 2,
            end: 0,
            offset: 10,
            barAlignment: Alignment.bottomCenter,
            iconHeight: 35,
            iconWidth: 35,
            reverse: false,
            hideOnScroll: true,
            scrollOpposite: false,
            onBottomBarHidden: () {},
            onBottomBarShown: () {},
            body: (context, controller) => TabBarView(
              controller: tabController,
              dragStartBehavior: DragStartBehavior.down,
              physics: const BouncingScrollPhysics(),
              children: [
                Dashboard(), 
                Search(), 
                NewProductPage(), 
                FavoritePage(), 
                ConfigPage()],
              //children: colors.map((e) => InfiniteListPage(controller: controller, color: e)).toList(),
            ),
          ),
          
        /*bottomNavigationBar: NavigationBar(
          indicatorShape: const CircleBorder(),
          selectedIndex: selectedIndex,
          onDestinationSelected: (index){
            setState(() {
              selectedIndex = index;
            });
          },
          backgroundColor: Colors.white,
          elevation: 0,
          destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_sharp,
              color: Colors.redAccent),
              label: 'Deseados',
            ),
        ],),*/
        
          
      )
    );
  }
}