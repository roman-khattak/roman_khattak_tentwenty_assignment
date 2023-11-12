import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/button.dart';
import '../widgets/imageText.dart';

class TicketDetailsScreen extends StatelessWidget {
  const TicketDetailsScreen({super.key, required this.movieName, required this.date});

  final String movieName;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap: () {Get.back();},child: const Icon(Icons.arrow_back_ios_new_outlined)),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: height * 0.4,
              width: width,
              color: Colors.grey.shade100,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/ticket_details.png',
                    height: height * 0.35,
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: height * 0.1,
                        width: width * 0.1,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(Icons.add),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Container(
                        height: height * 0.1,
                        width: width * 0.1,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(Icons.remove),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                    ],
                  ),
                  Divider(
                    indent: width * 0.03,
                    endIndent: width * 0.03,
                    thickness: 3,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: height * 0.3,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ImageTextWidget(
                          image: 'assets/images/seat1.png', text: 'Selected'),
                      const ImageTextWidget(
                          image: 'assets/images/seat2.png',
                          text: 'Not available'),
                      SizedBox(
                        width: width * 0.03,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ImageTextWidget(
                          image: 'assets/images/seat3.png',
                          text: 'VIP (150\$)'),
                      const ImageTextWidget(
                          image: 'assets/images/seat4.png',
                          text: 'Regular (50 \$)'),
                      SizedBox(
                        width: width * 0.05,
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: height * 0.06,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text('4/3row  X'),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: height * 0.08,
                        width: width * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                          child: Column(
                            children: [
                              Text(
                                'Total Price',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                '\$ 50',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Button(width: width * 0.6, text: 'Proceed to pay')
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}