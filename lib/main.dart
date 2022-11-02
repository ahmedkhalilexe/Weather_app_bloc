import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/busines%20logic/bloc/weather_bloc.dart';
import 'package:weather_app/data/weather_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => WeatherBloc(),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final weatherService = WeatherService();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const CircularProgressIndicator(
                    color: Colors.black,
                  );
                } else if (state is WeatherLoaded) {
                  return Text(
                    state.weatherModel.currentWeather!.temperature.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else if (state is WeatherNotLoaded) {
                  return Text(
                    "Unable to get the Weather",
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<WeatherBloc>(context).add(WeatherRequested());
        },
        tooltip: 'Get Weather',
        child: const Icon(Icons.add),
      ),
    );
  }
}
