import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// const host = "http://131183204125.ip-dynamic.com:8082";
const host = "http://203.210.84.8:8000";

const colorBlack = Color(0XFF222831);
const colorBlueGrey = Color(0XFF3C5B6F);
const colorBlueLight = Color(0XFF40A2E3);
const colorBlueNavy = Color(0XFF0C2D57);
const colorGreenDark = Color(0XFF50623A);
const colorGreenDarkTeal = Color(0XFF0A6847);
const colorYellow = Color(0XFFFEB941);
const colorGrey1 = Color(0XFFD1D3D4);

// date
var formatDate = DateFormat('yyyy-MM-dd');
var formatDateWithHour = DateFormat('yyyy-MM-dd hh:mm:ss');
var dateNow = DateTime.now().toString().split(' ')[0];