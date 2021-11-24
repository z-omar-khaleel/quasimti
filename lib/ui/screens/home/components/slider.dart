import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/ui/screens/webView/webView.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Sliders extends StatefulWidget {
  @override
  _SlidersState createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {
  var controller = Get.put(ApiController());
  final scrollController = ScrollController();
  void launchURL() async {}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiController>(
      builder: (controller) {
        return controller.allsliders.isEmpty
            ? Container()
            : Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                child: controller.allsliders == null
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        child: CarouselSlider.builder(
                          itemCount: controller.allsliders.length,
                          itemBuilder: (BuildContext context, int index,
                              int pageViewIndex) {
                            return GestureDetector(
                              onTap: () async {
                                await canLaunch(
                                        controller.allsliders[index].link)
                                    ? await launch(
                                        controller.allsliders[index].link)
                                    : throw Get.to((OfferPage(
                                        controller.allsliders[index].link)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: GFImageOverlay(
                                  colorFilter: new ColorFilter.mode(
                                      Colors.black.withOpacity(.1),
                                      BlendMode.color),
                                  borderRadius: BorderRadius.circular(20),
                                  width: MediaQuery.of(context).size.width,
                                  image: NetworkImage(
                                      controller.allsliders[index].image),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            autoPlayInterval: Duration(seconds: 7),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            viewportFraction: 0.9,
                            aspectRatio: 2.0,
                            initialPage: 0,
                          ),
                        ),
                      ),
              );
      },
    );
  }
}
