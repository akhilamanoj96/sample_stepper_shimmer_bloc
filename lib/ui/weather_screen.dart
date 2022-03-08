import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_flutter_app/bloc_widget/weather_bloc.dart';
import 'package:sample_flutter_app/models/weather_response.dart';
import 'package:sample_flutter_app/ui/sample_stepper_page.dart';
import 'package:sample_flutter_app/ui/shimmer_list_example.dart';
import 'package:shimmer/shimmer.dart';

class WeatherScreen extends StatefulWidget {
  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {


  bool isLoading = true ;


  @override
  void initState() {
    super.initState();
    weatherBloc.fetchLondonWeather();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: weatherBloc.weather,
        builder: (context, AsyncSnapshot<WeatherResponse> snapshot) {


          Widget child ;

          // if (snapshot.hasData) {
          //   isLoading = false ;
          //   return _buildWeatherScreen(snapshot.data);
          // } else if (snapshot.hasError) {
          //   isLoading = false ;
          //   return Text(snapshot.error.toString());
          // }
          // else{
          //   return CircularProgressIndicator() ;
          // }


          if (snapshot.hasData) {
            // child = ListView.builder(
            //   scrollDirection: Axis.vertical,
            //   itemCount: 5,//snapshot.data.length,
            //   itemBuilder: (context, index) {
            //     return listItem(data: snapshot.data);
            //   },
            // );

            return _buildWeatherScreen(snapshot.data) ;
          } else if (snapshot.hasError) {
            // Return an error message or retry button if it errors, not handled
            // for this example
          } else {
            child = myShimmerList();
          }

          return AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: child,
          );


        });
  }

  Widget _buildWeatherScreen(WeatherResponse data) {


    return ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context,int index){
          return GestureDetector(
            onTap: (){


              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) =>  ShimmerListExample()),
              // );

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  SampleStepperPage()),
              );
            },
            child:  listItem(color: Colors.white)


          );
        });




  }

  Widget shimmerItem() {

    return Container() ;
  }

  listItem({WeatherResponse data, Color color}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
        padding: EdgeInsets.all(8),
        child: data != null ? Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              color: color,
                child: Text("Weather in" + data.name, style: TextStyle( fontSize: 15.0), textAlign: TextAlign.center,)),
            SizedBox(height: 10,),
            Container(
              color: color,
                child: Text("ID" + data.id.toString(), style: TextStyle( fontSize: 15.0),)), SizedBox(height: 10,),
            Container(
              color: color,
                child: Text("Coordinates" + '${data.coord.lat}, ${data.coord.lon}', style: TextStyle( fontSize: 15.0),)),

          ],
        ) :
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
                color: color,
                child: Text("......", style: TextStyle( fontSize: 15.0, color: Colors.white), textAlign: TextAlign.center,)),
            SizedBox(height: 10,),
            Container(
                color: color,
                child: Text(".." , style: TextStyle( fontSize: 15.0,color: Colors.white),)), SizedBox(height: 10,),
            Container(
                color: color,
                child: Text("Coordinates", style: TextStyle( fontSize: 15.0, color: Colors.white),)),

          ],
        ) ,
      ),
    );
  }

  Widget myShimmerList() {
   return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (context, index) {
      return Shimmer.fromColors(
        direction: ShimmerDirection.ttb,
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: listItem(color: Colors.grey.shade300), //color: Colors.grey.shade300
      );
    });
  }
}
