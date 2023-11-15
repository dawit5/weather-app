import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/screate.dart';
import 'Additional_information.dart';
import 'hourly_Forcast_Item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

//14:46
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String cityName = 'Addis Ababa';
  Future getCurranetWeather() async {
    try {
      String cityName = 'Addis Ababa';
      final res = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherApiKey"),
      );
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'An Unexpected error  v';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$cityName    Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
        future: getCurranetWeather(),
        builder: (context, Snapshot) {
          print(Snapshot);
          print(Snapshot.runtimeType);
          if (Snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          final data = Snapshot.data!;
          final same = data['list'][0];
          final currantTemp = same["main"]['temp'];
          final currantSky = same['weather'][0]['main'];
          final Currantpressure = same['main']['pressure'];
          final CurrantWindSpeed = same['wind']['speed'];
          final Curranthumudity = same['main']['humidity'];
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                //main chard
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 11,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Column(
                            children: [
                              Text(
                                '$currantTemp k',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32.0),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Icon(
                                currantSky == 'Clouds' || currantSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 64,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "$currantSky",
                                style: TextStyle(fontSize: 24),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Hourly Forecast",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                //weather forcast card
                const SizedBox(
                  height: 10,
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       for (int i = 1; i < 5; i++)
                //         hourlyForcastItem(
                //           time: data['list'][i]['dt'].toString(),
                //           temprature:
                //               data['list'][i]['main']['temp'].toString(),
                //           icon:
                //               data['list'][i]['weather'][0]['main'] == 'Rain' ||
                //                       data['list'][i]['weather'][0]['main'] ==
                //                           'Cloud'
                //                   ? Icons.cloud
                //                   : Icons.sunny,
                //         ),

                //       //the final of the weather forcast
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final time = DateTime.parse(
                          data['list'][index + 1]['dt_txt'].toString());
                      return hourlyForcastItem(
                        time: DateFormat.Hms().format(time),
                        temprature:
                            data['list'][index + 1]['main']['temp'].toString(),
                        icon: data['list'][index + 1]['weather'][0]['main'] ==
                                    'Rain' ||
                                data['list'][index + 1]['weather'][0]['main'] ==
                                    'Cloud'
                            ? Icons.cloud
                            : Icons.sunny,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Additional information
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Aditional Information",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: EdgeInsets.all(19.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Additiona_Information(
                          icon: Icons.water_drop,
                          label: 'Humudity ',
                          num: Curranthumudity.toString()),
                      Additiona_Information(
                          icon: Icons.air,
                          label: 'WindSpeed ',
                          num: CurrantWindSpeed.toString()),
                      Additiona_Information(
                          icon: Icons.beach_access,
                          label: 'Pressure ',
                          num: '$Currantpressure'),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
