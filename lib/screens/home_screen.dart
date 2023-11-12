import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/upcoming_movies_controller.dart';
import '../widgets/movie_list_item.dart';
import 'movie_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UpcomingMoviesController upcomingMoviesController =
      Get.put(UpcomingMoviesController());

  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: buildAppBar(),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 120.0,
          ),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Obx(() {
                // Check if the upcomingMovies list is not empty
                if (upcomingMoviesController.filteredMovies.isNotEmpty) {
                  return Column(
                    children: [
                      Visibility(
                        visible: searchController.text.isNotEmpty,
                        child: Text(
                          '${upcomingMoviesController.filteredMovies.length} results found',
                        ),
                      ),
                      SizedBox(height: 10,),
                      ...upcomingMoviesController.filteredMovies.map((movie) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return MovieScreen(movieId: movie.id!);
                                },
                              ),
                            );
                          },
                          child: MovieListItem(
                            imageUrl: movie.posterPath ?? "",
                            name: movie.title ?? "",
                          ),
                        );
                      }).toList(),
                    ],
                  );
                } else if (upcomingMoviesController.isLoading.value) {
                  return const Center(child: Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: CircularProgressIndicator(color: Colors.blue,),
                  ));
                } else {
                  // Show a message when no results are found
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text(
                        'No results found',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      toolbarHeight: 100,
      backgroundColor: Colors.white,
      title: isSearching
          ? buildSearchField()
          : Text(
              'Watch',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
      actions: [
        !isSearching ?
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            // When clicking the search icon, hide the initial AppBar and show the search field
            setState(() {
              isSearching = true;
            });
          },
        ) : SizedBox(),
      ],
    );
  }

  Widget buildSearchField() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          color: Color(0xFFEFEFEF),
        ),
        child: Row(children: [
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: (query) {
                upcomingMoviesController.searchMovies(query);
              },
              autofocus: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                fillColor: Color(0xFFEFEFEF),
                hintText: 'Tv shows, movies and more',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              // Clear the search field and reset the movie list
              searchController.clear();
              upcomingMoviesController.searchMovies('');
              setState(() {
                isSearching = false;
              });
            },
          ),
        ]));
  }
}
