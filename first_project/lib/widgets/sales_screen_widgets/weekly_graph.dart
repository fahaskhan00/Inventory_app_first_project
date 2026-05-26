import 'package:flutter/material.dart';

class WeeklyGraph
    extends StatelessWidget {
  final List<double>
  weeklyTotals;

  final double maxValue;

  const WeeklyGraph({
    super.key,
    required this.weeklyTotals,
    required this.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

        crossAxisAlignment:
            CrossAxisAlignment.end,

        children: List.generate(
          7,

          (index) {
            double height =
                (weeklyTotals[index] /
                        maxValue) *
                    90;

            return Column(
              mainAxisAlignment:
                  MainAxisAlignment
                      .end,

              children: [
                Text(
                  weeklyTotals[index] ==
                          0
                      ? "0"
                      : weeklyTotals[index]
                          .toStringAsFixed(
                            0,
                          ),

                  style:
                      const TextStyle(
                        fontSize: 10,

                        color:
                            Colors.grey,

                        fontWeight:
                            FontWeight
                                .w600,
                      ),
                ),

                const SizedBox(
                  height: 8,
                ),

                AnimatedContainer(
                  duration:
                      const Duration(
                        milliseconds:
                            500,
                      ),

                  width: 26,

                  height:
                      height < 10
                          ? 10
                          : height,

                  decoration:
                      BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(
                              18,
                            ),

                        gradient:
                            const LinearGradient(
                              begin:
                                  Alignment
                                      .topCenter,

                              end:
                                  Alignment
                                      .bottomCenter,

                              colors: [
                                Color(
                                  0xFFFFB067,
                                ),

                                Color(
                                  0xFFFF8C42,
                                ),
                              ],
                            ),

                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFFFF8C42,
                            ).withOpacity(
                              .25,
                            ),

                            blurRadius:
                                10,

                            offset:
                                const Offset(
                                  0,
                                  4,
                                ),
                          ),
                        ],
                      ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Text(
                  [
                    "M",
                    "T",
                    "W",
                    "T",
                    "F",
                    "S",
                    "S",
                  ][index],

                  style:
                      const TextStyle(
                        color:
                            Colors.grey,

                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}