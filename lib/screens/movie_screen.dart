import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_tentwenty/screens/ticket_booking_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/movie_details_controller.dart';
import '../controllers/video_list_controller.dart';

class MovieScreen extends StatefulWidget {
 final int movieId;

  const MovieScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {

  final MovieDetailsController movieDetailsController = Get.put(MovieDetailsController());
  final VideoListController videoListController = Get.put(VideoListController());


  @override
  void initState() {
    super.initState();
    movieDetailsController.fetchMovieDetails(widget.movieId); // Assuming 'id' is the unique identifier for your movie
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(  // these build Methods are created for clean Coding
        children: [

          ..._buildBackground(context), // this method builds a list of widgets
          //_buildActions(context),    // this method will build the buttons
             _buildMovieInformation(context), // this method builds a single widget


        ],
      )
    );
  }

  List<Widget> _buildBackground(BuildContext context) {
    return [

      Container(
        height: double.infinity,
        color: const Color(0xFF000B49),
      ),

      Obx(
            () {
          if (movieDetailsController.movieDetails.value.backdropPath == null) {
            return Center(child: CircularProgressIndicator(color: Colors.white,));
          }

          return Image.network(
            'https://image.tmdb.org/t/p/w500${movieDetailsController.movieDetails.value.backdropPath}',
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            fit: BoxFit.cover,
          );
        },
      ),


      const Positioned.fill(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
              //  Color(0xFF000B49),
                Colors.white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.3, 0.6],
            ),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(top: 14.0),
        child: Row(children: [
          IconButton(onPressed: () {Get.back();}, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
          Text("Watch",style: TextStyle(color: Colors.white,fontSize: 16),),
        ],),
      ),

    ];
  }


  Positioned _buildMovieInformation(BuildContext context) {
    return Positioned(
      top: 200,
      width: MediaQuery.of(context).size.width,
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 200, //  200 pixels offset is the initial space from the top where the Positioned widget starts. The idea is to allow the content inside the SingleChildScrollView to take the remaining screen space below the top 200 pixels, thus avoiding overlaps of widgets int the screen
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Obx(
                      () {
                    if (movieDetailsController.movieDetails.value.genres == null ||
                        movieDetailsController.movieDetails.value.genres!.isEmpty) {
                      return const Center(child: CircularProgressIndicator(color: Colors.transparent,));
                    }

                    return Column(
                      children: [

                        Text(
                          movieDetailsController.movieDetails.value.title ?? "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          'In Theatres ${movieDetailsController.movieDetails.value.releaseDate != null ? DateFormat('MMMM d, y').format(movieDetailsController.movieDetails.value.releaseDate!) : ""}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),

                        _buildActions(context),

                        const SizedBox(height: 50,),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Genres ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${_getGenres()} ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Divider(),

                        const SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Overview',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${movieDetailsController.movieDetails.value.overview}',
                            maxLines: 8,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                height: 1.75, color: Colors.black
                            ),
                          ),
                        )

                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getGenres() {
    return movieDetailsController.movieDetails.value.genres!
        .map((genre) => genre.name!)
        .join(', ');
  }



  Positioned _buildActions(BuildContext context) {  // this widget returns a Positioned widget
    return Positioned(
      top: 210,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
                style: ElevatedButton.styleFrom(    // styling the button
                  padding: const EdgeInsets.all(15.0),
                  backgroundColor: Colors.lightBlueAccent,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.625, 50),  // width and height respectively provided
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                ),

                onPressed: () async {
                  Get.to(()=> TicketBookingScreen(movieName: '${movieDetailsController.movieDetails.value.title}', date: movieDetailsController.movieDetails.value.releaseDate!,));
                },

                child: Text(
                   'Get Tickets ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )
                ),
            ),

            const SizedBox(height: 5),

            ElevatedButton(
                style: ElevatedButton.styleFrom(    // styling the button
                  padding: const EdgeInsets.all(15.0),
                  backgroundColor: Colors.transparent,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.625, 50),  // width and height respectively provided
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                ),

                onPressed: () async {
                  // Assuming you have already initialized the VideoListController
                  VideoListController videoListController = Get.find<VideoListController>();

                  await videoListController.fetchVideoList(widget.movieId);

                  String? firstVideoKey = videoListController.getFirstVideoKey();
                  if (firstVideoKey != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return WatchVideoScreen(
                          keyValue: firstVideoKey,
                          movId: widget.movieId,
                        );
                      }),
                    );
                  } else {
                    // Handle the case where there are no video results
                    print('No video available');
                  }
                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Icon(Icons.play_arrow_rounded),

                    Text(
                      'Watch Trailer ',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}

//   ... ... ... Creating Movie Player or Video Player ... ... ... //
// ................................................................//



class WatchVideoScreen extends StatefulWidget {
  final String? keyValue;
  final int movId;
  const WatchVideoScreen({
    super.key,
    this.keyValue,
    required this.movId,
    // this.videoTitle,
  });

  @override
  State<WatchVideoScreen> createState() => _WatchVideoScreenState();
}

class _WatchVideoScreenState extends State<WatchVideoScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(
        'https://www.youtube.com/watch?v=${widget.keyValue}' ?? 'this is null');
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? 'this is null',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    )..addListener(listener);
  }

  void listener() {
    if (_controller.value.playerState == PlayerState.ended) {
      // Video playback has ended
      Get.off(() => MovieScreen(movieId: widget.movId));
    }
  }

  @override
  void dispose() {
    _controller.removeListener(listener); // Remove the listener
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            child: Center(
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(
                    isExpanded: true,
                    colors: const ProgressBarColors(
                        playedColor: Colors.red, handleColor: Colors.red),
                  ),
                  const PlaybackSpeedButton()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}