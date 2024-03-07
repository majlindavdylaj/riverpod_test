import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class RestApi {

  BuildContext? context;

  RestApi({this.context});

  makePostRequest(url, params) async {
    var res = await http.post(
      Uri.parse(url),
      headers: await headers(),
      body: json.encode(params),
    ).catchError((err) {
      String error = err.toString();
      throw Exception(error);
    });
    if(res.statusCode == 200 || res.statusCode == 201){
      try{
        var data = json.decode(res.body);
        return data;
      } catch(e){
        throw Exception('${res.statusCode} - ${e.toString()}');
      }
    } else if(res.statusCode == 401) {
      redirectToStart();
    } else {
      try{
        var data = json.decode(res.body);
        throw Exception('${data['message']}');
      } catch(e){
        throw Exception('${res.statusCode} - ${e.toString()}');
      }
    }
  }

  makeGetRequest(url) async {
    var res = await http.get(
      Uri.parse(url),
      headers: await headers(),
    ).catchError((err) {
      String error = err.toString();
      throw Exception(error);
    });
    if(res.statusCode == 200){
      try{
        var data = json.decode(res.body);
        return data;
      } catch(e){
        throw Exception('${res.statusCode} - ${e.toString()}');
      }
    } else if(res.statusCode == 401) {
      redirectToStart();
    } else {
      try{
        var data = json.decode(res.body);
        throw Exception('${data['message']}');
      } catch(e){
        throw Exception('${res.statusCode} - ${e.toString()}');
      }
    }
  }

  makePutRequest(url, params) async {
    var res = await http.put(
      Uri.parse(url),
      headers: await headers(),
      body: json.encode(params),
    ).catchError((err) {
      String error = err.toString();
      throw Exception(error);
    });
    if(res.statusCode == 200 || res.statusCode == 201){
      try{
        var data = json.decode(res.body);
        return data;
      } catch(e){
        throw Exception('${res.statusCode} - ${e.toString()}');
      }
    } else if(res.statusCode == 401) {
      redirectToStart();
    } else {
      try{
        var data = json.decode(res.body);
        throw Exception('${data['message']}');
      } catch(e){
        throw Exception('${res.statusCode} - ${e.toString()}');
      }
    }
  }

  makeDeleteRequest(url, params) async {
    var res = await http.delete(
      Uri.parse(url),
      headers: await headers(),
      body: json.encode(params),
    ).catchError((err) {
      String error = err.toString();
      throw Exception(error);
    });
    if(res.statusCode == 200 || res.statusCode == 204){
      try{
        if(res.statusCode == 200) {
          var data = json.decode(res.body);
          return data;
        } else {
          return null;
        }
      } catch(e){
        throw Exception('${res.statusCode} - ${e.toString()}');
      }
    } else if(res.statusCode == 401) {
      redirectToStart();
    } else {
      try{
        var data = json.decode(res.body);
        throw Exception('${data['message']}');
      } catch(e){
        throw Exception('${res.statusCode} - ${e.toString()}');
      }
    }
  }

  Future<Map<String, String>> headers() async {
    return <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
  }

  redirectToStart() async {
    context!.go('/');
  }
}