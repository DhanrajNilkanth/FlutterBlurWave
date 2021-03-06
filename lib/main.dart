import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Demo(),
    );
  }
}

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {

  _buildCard({
    Config config,
    Color background = Colors.transparent,
    double height = 150.0,
   }){
    return Container(
      height: height,
      width: double.infinity,
      child: Card(
        elevation: 12.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0),),
        ),
        margin: EdgeInsets.only(right: 16.0,left: 16.0,bottom: 16.0),
        clipBehavior: Clip.antiAlias,
        child: WaveWidget(
            config: config,
            size: Size(double.infinity, double.infinity),
          waveAmplitude: 0.0,
          backgroundColor: background,
        ),
      ),
    );
  }

  MaskFilter blur;

  int indexBlur = 0;

  final List<MaskFilter> blurs = [
    null,
    MaskFilter.blur(BlurStyle.inner, 10.0),
    MaskFilter.blur(BlurStyle.solid, 10.0),
    MaskFilter.blur(BlurStyle.normal, 10.0),
    MaskFilter.blur(BlurStyle.outer, 10.0),
  ];


  MaskFilter _filter (){
    if(indexBlur == blurs.length -1){
      indexBlur = 0;
    }else{
      indexBlur = indexBlur + 1;
    }

    blur = blurs[indexBlur];
    return blurs[indexBlur];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wave Demo'),
        elevation: 14.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(blur == null ? Icons.blur_off : Icons.blur_on),
              onPressed: (){
                setState(() {
                  blur = _filter();
                });
              }
          )
        ],
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: 10.0,
            ),
            _buildCard(
              config: CustomConfig(
                  durations: [30000,16000,10000,6000],
                  heightPercentages: [0.36,0.32,0.25,020],
                blur: blur,
                gradients: [
                  [Colors.red, Colors.red.shade100],
                  [Colors.deepOrange,Colors.deepOrange.shade200],
                  [Colors.yellow, Colors.yellow.shade200],
                  [Colors.orange, Colors.orange.shade200],
                ]
              ),
              background: Colors.pink,
            ),
            _buildCard(
              config: CustomConfig(
                  durations: [36000,30000,25000,10000],
                  heightPercentages: [0.36,0.32,0.25,020],
                  blur: blur,
                 colors: [Colors.blue,
                 Colors.lightBlueAccent,
                 Colors.yellowAccent.shade400,
                 Colors.yellow.shade200]
              ),
              background: Colors.green,
            ),
            _buildCard(
              config: CustomConfig(
                  durations: [36000,30000,25000,10000],
                  heightPercentages: [0.36,0.32,0.25,020],
                  blur: blur,
                colors: [
                  Colors.white70,
                  Colors.white60,
                  Colors.white38,
                  Colors.white12,
                ]
              ),
              background: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}



















