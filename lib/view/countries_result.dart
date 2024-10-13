import 'package:chickenpox/view/world_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CountriesResult extends StatefulWidget {
  final String image;
  final String name;
  final int totalCases;
  final int totalDeaths;
  final int test;
  final int todayRecovered;
  final int totalRecovered;
  final int critical;
  final int active;
  CountriesResult({
    super.key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.test,
    required this.todayRecovered,
    required this.totalRecovered,
    required this.critical,
    required this.active,
  });

  @override
  State<CountriesResult> createState() => _CountriesResultState();
}

class _CountriesResultState extends State<CountriesResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .06),
                        ReusableRow(
                            title: 'CASES',
                            value: widget.totalCases.toString()),
                        ReusableRow(
                            title: 'TOTAL RECOVERED',
                            value: widget.totalRecovered.toString()),
                        ReusableRow(
                            title: 'TOTAL DEATHS',
                            value: widget.totalDeaths.toString()),
                        ReusableRow(
                            title: 'CRITICAL',
                            value: widget.critical.toString()),
                        ReusableRow(
                            title: 'RECOVERED TODAY',
                            value: widget.todayRecovered.toString()),
                        ReusableRow(
                            title: 'TOTAL TESTS CONDUCTED',
                            value: widget.test.toString()),
                        ReusableRow(
                            title: 'ACTIVE CASES',
                            value: widget.active.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
