import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Hackathons {
  List<dynamic> hacks;
  int statusCode;
  String errorMessage;
  int total;
  int nItems;

  Hackathons.fromResponse(Response response) {
    this.statusCode = response.statusCode;
    var jsonData = response.data;
    print(jsonData);
    hacks = jsonData['documents'];
    total = jsonData['totalCount'];
    nItems = hacks.length;
  }
  Hackathons.withError(String errorMessage) {
    this.errorMessage = errorMessage;
  }
}