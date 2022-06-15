import 'package:flutter/material.dart';

abstract class Global {

  static const Color blue = const Color(0xff4a64fe);
  static const Color white = const Color(0xffffffff);

  //For 360*360 img ::::   X & Y: -0.13 : +0.13
  //For 360*360 img ::::   X & Y: -0.13 : +0.13

  static const List lights = [
    {
      // 'location': 'OpenSpace',
      'name': 'OS11',  //tile1 section1
      'status': true,
      'position': [0.11, 0.03],
      'tile': 1,
    },
    {
      // 'location': 'Hallway 1.1',
      'name': 'HW11', //tile2 section1
      'status': true,
      'position': [0.03, 0.02],
      'tile': 2,
    },
    {
      // 'location': 'Hallway 1.2',
      'name': 'HW12', //tile2 section2
      'status': true,
      'position': [0.03, 0.11],
      'tile': 2,
    },
    {
      // 'location': 'Lecture hall 3.1',
      'name': 'LH31',
      'status': true,
      'position': [-0.13, 0.0],
      'tile': 3,
    },
    {
      // 'location': 'Lecture hall 3.2',
      'name': 'LH32',
      'status': true,
      'position': [0.0, 0.12],
      'tile': 3,
    },{
      // 'location': 'Lecture hall 3.3',
      'name': 'LH33',
      'status': true,
      'position': [-0.13, 0.12],
      'tile': 3,
    },

    {
      // 'location': 'Lecture hall 3.4',
      'name': 'LH34',
      'status': true,
      'position': [0.0, 0.0],
      'tile': 3,
    },
    {
      // 'location': 'Hallway 2.1',
      'name': 'HW21',
      'status': true,
      'position': [0.11, -0.11],
      'tile': 4,
    },
    {
      // 'location': 'Hallway 2.2',
      'name': 'HW22',
      'status': true,
      'position': [0.03, -0.11],
      'tile': 5,
    },
    {
      // 'location': 'Hallway 2.3',
      'name': 'HW23',
      'status': true,
      'position': [-0.07, -0.11],
      'tile': 6,
    },
    {
      // 'location': 'TA 1.1',
      'name': 'TA11',
      'status': true,
      'position': [-0.13, -0.04],
      'tile': 5,
    },
    {
      // 'location': 'calibration1.1',
      'name': 'CAL11',
      'status': true,
      'position': [-0.07, -0.04],
      'tile': 6,
    },
    {
      // 'location': 'Electronics lab 1.1',
      'name': 'EL11',
      'status': true,
      'position': [0.02, 0.11],
      'tile': 4,
    },
    {
      // 'location': 'Electronics lab 1.2',
      'name': 'EL12',
      'status': true,
      'position': [-0.13, 0.11],
      'tile': 5,
    },
    {
      // 'location': 'TAMER',
      'name': 'TAMER11',
      'status': true,
      'position': [-0.14, -0.06],
      'tile': 8,
    },

    {
      // 'location': 'Hallway 3.1',
      'name': 'HW31',
      'status': true,
      'position': [0.03, 0.05],
      'tile': 5,
    },
    {
      // 'location': 'Hallway 3.2',
      'name': 'HW32',
      'status': true,
      'position': [0.05, -0.12],
      'tile': 8,
    },
    {
      // 'location': 'Hallway 3.3',
      'name': 'HW33',
      'status': true,
      'position': [0.05, 0.03],
      'tile': 8,
    },

  ];
}
