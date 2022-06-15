import 'package:custom_zoomable_floorplan/core/viewmodels/floorplan_model.dart';
import 'package:custom_zoomable_floorplan/view/shared/global.dart';
import 'package:custom_zoomable_floorplan/view/widgets/appbar_widget.dart';
import 'package:custom_zoomable_floorplan/view/widgets/gridview_notifier.dart';

import 'package:custom_zoomable_floorplan/view/widgets/gridview_widget.dart';

import 'package:custom_zoomable_floorplan/view/widgets/overlay_widget.dart';
import 'package:custom_zoomable_floorplan/view/widgets/position_widget.dart';
import 'package:custom_zoomable_floorplan/view/widgets/raw_gesture_detector_widget.dart';
import 'package:custom_zoomable_floorplan/view/widgets/reset_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';



class FloorPlanScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FloorPlanModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(40.0),
      //   child: AppBarWidget(),
      // ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          // color: Global.blue,
          color: Global.white,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                RawGestureDetectorWidget(
                  child: PositionWidget(),
                  // child: GridViewWidget(),
                ),
                model.hasTouched ? ResetButtonWidget() : OverlayWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}


