import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: SliderBody(),
    );
  }
}

class SliderBody extends StatefulWidget {
  @override
  _SliderBodyState createState() => _SliderBodyState();
}

class _SliderBodyState extends State<SliderBody> {

  CarouselController buttonCarouselController = CarouselController();
  String sliderIndex = sliderData[0].title;
  int currentIndex = 0;

  void onSliderChange(int index, CarouselPageChangedReason changedReason) {
    setState(() {
      sliderIndex = sliderData[index].title;
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Carousel page'),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 10,),

            //Example change text from slider data
            Container(child: Text(sliderIndex, textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),)),

            CarouselSlider(
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                  height: size.height * 0.7,
                  viewportFraction: .8,
                  //размер по ширине 1 - макс
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: Duration(seconds: 1),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),

                  // easeInOutQuad, easeInOut, easeInCubic, easeIn, easeInCirc
                  autoPlayCurve: Curves.easeInOut,

                  //Пример получение индекса текущего слайдера
                  onPageChanged: onSliderChange,

                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal),
                  items: sliderData.map((item) => SliderItemWidget(item: item,)).toList(),
            ),

            // Example doted slider
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...Iterable<int>.generate(sliderData.length).map( (int pageIndex) => GestureDetector(
                    onTap: () => buttonCarouselController.animateToPage(pageIndex),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: currentIndex == pageIndex ? Colors.blue : Colors.red
                      ),
                    ),
                  ),
                  )
                ]
            ),

            SizedBox(height: 10,),


            RaisedButton(
                onPressed: () => buttonCarouselController.nextPage(
                    duration: Duration(microseconds: 800),
                    curve: Curves.easeInOut
                ),
                child: Text('next')
            ),
          ],
        ),
      ),
    );
  }
}

final List<SliderItem> sliderData = [
  SliderItem(
    color: Colors.blue,
    title: 'Lorem Ipsum',
    text:
        'Lorem Ipsum - это текст-"рыба", часто используемый в печати и вэб-дизайне. Lorem Ipsum является стандартной "рыбой" для текстов на латинице с начала XVI века.',
  ),
  SliderItem(
    color: Colors.green,
    title: 'это текст-"рыба"',
    text:
        'Lorem Ipsum - это текст-"рыба", часто используемый в печати и вэб-дизайне. Lorem Ipsum является стандартной "рыбой" для текстов на латинице с начала XVI века.',
  ),
  SliderItem(
    color: Colors.red,
    title: 'часто используемый',
    text:
        'Lorem Ipsum - это текст-"рыба", часто используемый в печати и вэб-дизайне. Lorem Ipsum является стандартной "рыбой" для текстов на латинице с начала XVI века.',
  ),
];

class SliderItem {
  final Color color;
  final String title, text;

  SliderItem({this.color, this.title, this.text});

}

class SliderItemWidget extends StatelessWidget {
  final SliderItem item;

  const SliderItemWidget({Key key, this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.all(15),
      color: item.color,
      child: Column(
        children: [
          Text(
            item.title,
            style: TextStyle(color: Colors.white, fontSize: 24),
            textAlign: TextAlign.center,
          ),
          Text(item.text,
              style: TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
