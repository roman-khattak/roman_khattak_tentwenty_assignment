import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app_tentwenty/screens/home_screen.dart';

import 'controllers/home_controller.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  HomeStructure(),
    );
  }
}


// This class is named 'HomeStructure' because we are not Showing/Displaying anything in this class, i.e., we are just making a structure for "HomeScreen"

class HomeStructure extends StatelessWidget {
  const HomeStructure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // initializing the "home_controller"
    HomeController homeController = Get.put(HomeController());

    // Creating a List of BottomNavigationBar Items to pass to 'BottomNavigationBar()'
    var navbarItems = [
      BottomNavigationBarItem(icon: Icon(
        Icons.grid_view_rounded, 
        // color: Color(0xFF827D88),
      ), label: "Dashboard",),
      
      BottomNavigationBarItem(
          icon: Icon(
              Icons.slideshow,
              // color: Color(0xFF827D88)
          ), label: "Watch"),
      
      BottomNavigationBarItem(
          icon: Icon(
            Icons.perm_media_rounded, 
            // color: Color(0xFF827D88),
          ), label: "Media Library"),
      
      BottomNavigationBarItem(
          icon: Icon(Icons.list,
            // color: Color(0xFF827D88),
          ), label: "More"),
    ];

    var navBody = { // This list contains the different screens that has to be displayed on the click of each 'BottomNavigationBar Item' as per index of the item

      Container(
        color: Color(0xFFEFEFEF),
        child: const Center(child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: Text("Please click on the Watch button in the Bottom Navigation Bar",style: TextStyle(fontSize: 17),),
        )),
      ),

      const HomeScreen(),

      Container(
        color: Color(0xFFEFEFEF),
        child: const Center(child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: Text("Please click on the Watch button in the Bottom Navigation Bar",style: TextStyle(fontSize: 17),),
        )),
      ),

      Container(
        color: Color(0xFFEFEFEF),
        child: const Center(child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: Text("Please click on the Watch button in the Bottom Navigation Bar",style: TextStyle(fontSize: 17),),
        )),
      ),
    };

    return Scaffold(
      body: Column(
        children: [
          Obx( () => Expanded(
            // based on the index of the current BottomNavigationBarItem clicked the elements from same index will be called from 'navBody' function
            child: navBody.elementAt(homeController.currentNavIndex.value),
          ),
          ),
        ],
      ),

      bottomNavigationBar: Obx( () =>   // wrapping BottomNavigationBar with "Obx" because we have to use the observable variable from home_controller here on 'currentIndex'
      ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
        child: BottomNavigationBar(
          currentIndex: homeController.currentNavIndex.value,  // assigning the initial value of 'currentNavIndex = 0.obs' from home_controller to the current index ie; 'home' screen index
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xFF827D88),
          type: BottomNavigationBarType.fixed,  // will make the alignment of items in Bottom NavigationBar betters and will make the labels visible as well
          backgroundColor: Color(0xFF2E2739).withOpacity(0.9),
          items: navbarItems, // we will pass the "navbarItems" list to 'bottomNavigationBar' for display

          onTap: (value) {   // this 'value' parameter in onTap function takes and store the index of the "BottomNavigationBarItem" which is clicked
            homeController.currentNavIndex.value = value;  // here we are assigning the index of the "BottomNavigationBarItem" clicked to the 'currentNavIndex' so that the 'currentIndex' can be updated to new index and Screen can be changed
          },
        ),
      ),
      ),
    );
  }
}
