import 'package:flutter/material.dart';
import 'package:iss_app/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration.zero,
      () {

        homeViewModel.startTimer();
        homeViewModel.getPosition();

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Consumer<HomeViewModel>(
              builder: (context, value, child) {
                print('Home: ${value.toString()}');
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Text('Latitude:${value.long}'),
                    SizedBox(height: 10.0,),
                    Text('Longitude:${value.long}'),
                    SizedBox(height: 10.0,),
                    Text('UTC Time:${value.lastUtcTime}'),
                    SizedBox(height: 10.0,),
                    Text('Local Time:${value.lastLocalTime}'),
                    Text('Country name:${value.countryName}'),
                    SizedBox(height: 20.0,),
                    ElevatedButton(
                      onPressed: () {
                        value.getPosition();
                        value.startTimer();
                      },
                      child: Text('Refresh (${value.countdown})'),
                    ),
                  ],
                );
              },
            ),
          ),
          // Loading Overlay
          Consumer<HomeViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                );
              }
              return SizedBox.shrink(); // No loading UI
            },
          ),
        ],
      ),
    );
  }
}
