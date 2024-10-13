import 'package:chickenpox/Services/states_services.dart';
import 'package:chickenpox/view/countries_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search With Country Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: statesServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    print(snapshot);
                    return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    height: 10,
                                    width: 80,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 80,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available.'));
                  } else {
                    String searchQuery =
                        searchController.text.toLowerCase().trim();

                    List<dynamic> filteredCountries =
                        snapshot.data!.where((country) {
                      String countryName = country['country'].toLowerCase();
                      return searchQuery.isEmpty ||
                          countryName.startsWith(searchQuery);
                    }).toList();

                    if (filteredCountries.isEmpty) {
                      return Center(child: Text('No countries found.'));
                    }
                    return ListView.builder(
                        itemCount: filteredCountries.length,
                        itemBuilder: (context, index) {
                          var countryData = filteredCountries[index];

                          // Log to verify the data
                          print(countryData);
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CountriesResult(
                                                image: filteredCountries[index]
                                                    ['countryInfo']['flag'],
                                                name: filteredCountries[index]
                                                    ['country'],
                                                totalCases:
                                                    filteredCountries[index]
                                                        ['cases'],
                                                totalDeaths:
                                                    filteredCountries[index]
                                                        ['deaths'],
                                                test: filteredCountries[index]
                                                    ['tests'],
                                                todayRecovered:
                                                    filteredCountries[index]
                                                        ['todayRecovered'],
                                                totalRecovered:
                                                    filteredCountries[index]
                                                        ['recovered'],
                                                critical:
                                                    filteredCountries[index]
                                                        ['critical'],
                                                active: filteredCountries[index]
                                                    ['active'],
                                              )));
                                },
                                child: ListTile(
                                  title: Text(countryData['country']),
                                  subtitle:
                                      Text(countryData['cases'].toString()),
                                  leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(
                                        countryData['countryInfo']['flag'],
                                      )),
                                ),
                              )
                            ],
                          );
                        });
                  }
                }),
          ),
        ],
      )),
    );
  }
}
