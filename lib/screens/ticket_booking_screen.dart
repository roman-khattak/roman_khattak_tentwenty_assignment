import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_tentwenty/screens/ticket_details_screen.dart';

import '../widgets/button.dart';

class TicketBookingScreen extends StatelessWidget {
   const TicketBookingScreen({super.key, required this.movieName, this.date});

  final String movieName;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap: () {Get.back();}, child: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$movieName',
            ),
            Text(
              'In Theatres ${date != null ? DateFormat('MMMM d, y').format(date!) : ""}',
              style: TextStyle(color: Colors.blue, fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 5, bottom: 7),
            child: const Text(
              'Date',
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30,
            width: double.infinity,
            child: ListView.builder(
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 10,
                    width: 60,
                    decoration: BoxDecoration(
                        color: index == 0 ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        '${index + 5} Mar',
                        style: TextStyle(
                            color: index == 0 ? Colors.white : Colors.black,
                            fontSize: 12),
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: height * 0.4,
            width: double.infinity,
            child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Text(
                              '12:30 ',
                              style:
                              TextStyle(fontSize: 12, color: Colors.black),
                            ),
                            Text(
                              ' Cinetch + Hall $index',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Image.asset(
                          'assets/images/ticket.png',
                          height: height * 0.25,
                          // width: 200,
                        ),
                        RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                  text: "From ",
                                  style: TextStyle(color: Colors.grey)),
                              TextSpan(
                                  text: "50\$ ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "or ",
                                  style: TextStyle(color: Colors.grey)),
                              TextSpan(
                                  text: "2500 bonus",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ]))
                      ],
                    ),
                  );
                }),
          ),
          SizedBox(
            height: height * 0.2,
          ),
          Center(
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TicketDetailsScreen(movieName: movieName, date: date,)),
                    );
                  },
                  child: Button(width: width * 0.9, text: 'Select Seats')))
        ],
      ),
    );
  }
}