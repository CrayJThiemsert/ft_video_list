import 'dart:io';
import 'dart:ui' as ui show Gradient, TextBox, lerpDouble, Image;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/**
 * String utility class.
 *
 * Created by: Jirachai Thiemsert
 * When: 2020
 * email: cray.j.thiemsert@gmail.com
 */
class StringUtils {

  BuildContext _context;

  /**
   * Verify data is emthy, if yes, return ''
   */
  String verifyString(String src, String defaultReturn) {
    return src.isEmpty ? defaultReturn : src;
  }

  /**
   * Convert raw date string to short date time format
   * 2017-11-18T11:11:15.000Z" => Nov 18, 2017
   */
  String printShortDateTime(String srcDatetime, String defaultReturn) {
    if(srcDatetime.isEmpty) {
      return defaultReturn;
    }
    return DateFormat('MMM dd, yyyy').format(DateTime.parse(srcDatetime));
  }
}