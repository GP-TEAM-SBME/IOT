// import 'package:custom_zoomable_floorplan/core/models/models.dart';
// import 'package:custom_zoomable_floorplan/core/viewmodels/floorplan_model.dart';
// import 'package:custom_zoomable_floorplan/view/shared/global.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:provider/provider.dart';
//
// import 'dart:developer';
//
// class GridViewWidget extends StatefulWidget {
//   const GridViewWidget({key}) : super(key: key);
//
//   @override
//   _GridViewWidgetState createState() => _GridViewWidgetState();
// }
//
// class _GridViewWidgetState extends State<GridViewWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final model = Provider.of<FloorPlanModel>(context);
//
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//       ),
//       itemCount: 9,
//       itemBuilder: (context, index) {
//         int currentTile = index + 1;
//
//         List<Light> tileLights = model.lights.where( (item) => item.tile == currentTile ).toList();
//         // log('your message here');
//         // log('tileLight ${tileLights}');
//         // List<Light> tileLightsNew = tileLights[1] as List<Light>;
//
//         return Stack(
//           alignment: Alignment.center,
//           children: <Widget>[
//             Container(
//               color: Global.white,
//               child: Image.asset(
//                 'images/tile_0$currentTile.png',
//               ),
//             ),
//
//             // if history ? list generate : one child update with time (future builder) mapping http request -> pass index
//             Stack(
//               children: List.generate(
//                 tileLights.length, (idx) {
//                 return Transform.translate(
//                   offset: Offset(
//                     size.width * tileLights[idx].position![0],
//                     size.width * tileLights[idx].position![1],
//                   ),
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: <Widget>[
//                       CircleAvatar(
//                         backgroundColor:
//                         // tileLights[idx].status ?
//                          Colors.greenAccent,
//                         // : Colors.white,
//                         radius: 5.0,
//                         child: Center(
//                           child: Icon(
//                             Icons.lightbulb_outline,
//                             color: Global.blue,
//                             size: 7,
//                           ),
//                         ),
//                       ),
//
//                       // Transform(
//                       //   transform: Matrix4.identity()..translate(15.0),
//                       //   child: Text(
//                       //     tileLights[idx].name,
//                       //     style: TextStyle(
//                       //       fontSize: 8.0,
//                       //       color: Colors.green,
//                       //     ),
//                       //   ),
//                       // )
//
//
//                     ],
//                   ),
//                 );
//
//
//
//               },
//               ),
//
//
//             )
//           ],
//         );
//       },
//     );
//   }
// }
//
// //
// // class GridViewWidget extends StatelessWidget {
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //
// //   }
// // }
