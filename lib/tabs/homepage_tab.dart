import 'package:dhanmanthan_original/functionalities/debt_tracker/debt_homescreen.dart';
import 'package:dhanmanthan_original/functionalities/expense_tracker.dart/expense_homescreen.dart';
import 'package:dhanmanthan_original/functionalities/financial_news/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';

class HomepageTab extends StatefulWidget {
  const HomepageTab({super.key});

  @override
  State<HomepageTab> createState() => _HomepageTabState();
}

class _HomepageTabState extends State<HomepageTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 45),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider(
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: const Color.fromARGB(255, 160, 203, 255),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset((i == 1)
                                  ? 'assets/images/42f915a8-c36a-46ae-9935-73bbd3c6dade.png'
                                  : (i == 2)
                                      ? 'assets/images/613e0e02-33ba-41e2-8502-e200262fe4d5.png'
                                      : (i == 3)
                                          ? 'assets/images/9070e74c-e120-4ae8-a15f-3e8f657f1642.png'
                                          : (i == 4)
                                              ? 'assets/images/7b6f8bdf-b76e-4e95-8b9a-886a13f4acae.png'
                                              : 'assets/images/d964555c-1d0d-47d6-ae8e-e2c36529c9df.png'),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 70,
                                color: Colors.white60,
                                child: Center(
                                  child: (i == 1)
                                      ? const Text(
                                          'Become a mentor',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )
                                      : (i == 2)
                                          ? const Text(
                                              'Earn money with us',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            )
                                          : (i == 3)
                                              ? const Text(
                                                  'Be aware of scams',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                )
                                              : (i == 4)
                                                  ? const Text(
                                                      'Collect points to win goodies',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    )
                                                  : const Text(
                                                      'Play quizz to earn points',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                ),
                              ),
                            )
                          ],
                        ));
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 200,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                //onPageChanged: (){},
                scrollDirection: Axis.horizontal,
              )),
          const SizedBox(
            height: 20,
          ),
          Container(
              height: 200,
              width: 340,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 160, 203, 255),
                  borderRadius: BorderRadius.circular(22)),
              child: LineChart(
                LineChartData(
                    minX: 1,
                    maxX: 12,
                    minY: 0,
                    maxY: 100,
                    lineBarsData: [
                      LineChartBarData(spots: [
                        const FlSpot(1, 50),
                        const FlSpot(2, 30),
                        const FlSpot(3, 60),
                        const FlSpot(4, 40),
                        const FlSpot(5, 20),
                        const FlSpot(6, 10),
                        const FlSpot(7, 80),
                        const FlSpot(8, 90)
                      ])
                    ]),
              )),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.09,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        const ExpenseHomescreen()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 121, 181, 255),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                  'assets/images/bf2b212e-6678-4589-a716-e185f09a030a.png'),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Expense Tracker',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.09,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => const HomeDebt()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 121, 181, 255),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          child: Center(
                            child: Image.asset(
                                'assets/images/8e7e801a-5262-49d2-b691-c92c36a27cbb.png'),
                          ),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Debt Tracker',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.09,
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      const NewsCategoryScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 121, 181, 255),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18))),
                        child: Center(
                          child: Image.asset(
                              'assets/images/ad24f3e4-2a4d-4a1a-ba82-0a82627e208c.png'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'News',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
