import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/model/doctors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider with ChangeNotifier {
  List<ItemForm> kebeles = [];
  late String name;
  late String userdata;
  late String userName;

  Future<Map<String, dynamic>> fetchDataStorage() async {
    const url =
        'https://trying-c4dac-default-rtdb.firebaseio.com/doctors_info.json';
    try {
      http.Response response = await http.get(
        Uri.parse(url),
      );

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      print(response);
      if (response == null) return {'success': false, 'status_code': 0};
      switch (response.statusCode) {
        case 200:
          {
            var data = json.decode(response.body) as Map<String, dynamic>;
            data.forEach((key, value) {
              sharedPreferences.setString(value["email"], key);
            });

            return {'success': true, 'data': utf8.decode(response.bodyBytes)};
          }

        case 201:
          return {'success': true, 'data': utf8.decode(response.bodyBytes)};
        default:
          return {
            'success': false,
            'status_code': response.statusCode.toString() +
                " - message: " +
                response.body.toString()
          };
      }
    } catch (e, _) {
      debugPrint("MFSException: " + e.toString() + " -- " + _.toString());
      return {'success': false};
    }
  }

  /////////////////////////////////////////////
  Future<Map<String, dynamic>> updateData(
      String email, bool availablity) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var res = sharedPreferences.getString(email);

    if (res != null) {
      final url =
          "https://trying-c4dac-default-rtdb.firebaseio.com/doctors_info/$res.json";
      try {
        http.Response response = await http.patch(Uri.parse(url),
            body: json.encode({"availablity": availablity}));
        if (response == null) return {'success': false, 'status_code': 0};
        switch (response.statusCode) {
          case 200:
            {
              var data = json.decode(response.body) as Map<String, dynamic>;
              print("---------------VALUE AS LIST-------------------");
              return {'success': true, 'data': utf8.decode(response.bodyBytes)};
            }

          case 201:
            return {'success': true, 'data': utf8.decode(response.bodyBytes)};
          default:
            return {
              'success': false,
              'status_code': response.statusCode.toString() +
                  " - message: " +
                  response.body.toString()
            };
        }
      } catch (e, _) {
        debugPrint("MFSException: " + e.toString() + " -- " + _.toString());
        return {'success': false};
      }
    } else {
      return {'success': false};
    }
  }

  Future<Map<String, dynamic>> fetchDatauser() async {
    const url =
        'https://trying-c4dac-default-rtdb.firebaseio.com/userpersonal_info.json';
    try {
      http.Response response = await http.get(
        Uri.parse(url),
      );
      print(json.decode(response.body));
      if (response == null) return {'success': false, 'status_code': 0};
      switch (response.statusCode) {
        case 200:
          {
            var data = json.decode(response.body) as Map<String, dynamic>;
            data.forEach((key, value) {
              if (value["name"] == name) {
                userdata = value["info"];
                userName = value["name"];
              }
            });
            return {'success': true, 'data': utf8.decode(response.bodyBytes)};
          }
        case 201:
          return {'success': true, 'data': utf8.decode(response.bodyBytes)};
        default:
          return {
            'success': false,
            'status_code': response.statusCode.toString() +
                " - message: " +
                response.body.toString()
          };
      }
    } catch (e, _) {
      debugPrint("MFSException: " + e.toString() + " -- " + _.toString());
      return {'success': false};
    }
  }

  Future<Map<String, dynamic>> fetchDataUsers() async {
    const url =
        'https://trying-c4dac-default-rtdb.firebaseio.com/doctors_info.json';
    try {
      http.Response response = await http.get(
        Uri.parse(url),
      );
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      print(response);
      if (response == null) return {'success': false, 'status_code': 0};
      switch (response.statusCode) {
        case 200:
          {
            var data = json.decode(response.body) as Map<String, dynamic>;
            var dot = sharedPreferences.getString("emailset");
            data.forEach((key, value) {
              if (value["email"] == dot) {
                name = value["name"];
              }
            });
            return {'success': true, 'data': utf8.decode(response.bodyBytes)};
          }

        case 201:
          return {'success': true, 'data': utf8.decode(response.bodyBytes)};
        default:
          return {
            'success': false,
            'status_code': response.statusCode.toString() +
                " - message: " +
                response.body.toString()
          };
      }
    } catch (e, _) {
      debugPrint("MFSException: " + e.toString() + " -- " + _.toString());
      return {'success': false};
    }
  }

  Future<Map<String, dynamic>> fetchData(String disease) async {
    const url =
        'https://trying-c4dac-default-rtdb.firebaseio.com/doctors_info.json';
    try {
      http.Response response = await http.get(
        Uri.parse(url),
      );
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      print(response);
      if (response == null) return {'success': false, 'status_code': 0};
      switch (response.statusCode) {
        case 200:
          {
            var data = json.decode(response.body) as Map<String, dynamic>;
            data.forEach((key, value) {
              sharedPreferences.setString(value["email"], key);
              kebeles.add(ItemForm(name: value["name"], type: value['type']));
            });
            kebeles.removeWhere((element) => element.type != disease);
            var dot = sharedPreferences.getString("emailset");
            data.forEach((key, value) {
              if (value["email"] == dot) {
                name = value["name"];
              }
            });
            return {'success': true, 'data': utf8.decode(response.bodyBytes)};
          }

        case 201:
          return {'success': true, 'data': utf8.decode(response.bodyBytes)};
        default:
          return {
            'success': false,
            'status_code': response.statusCode.toString() +
                " - message: " +
                response.body.toString()
          };
      }
    } catch (e, _) {
      debugPrint("MFSException: " + e.toString() + " -- " + _.toString());
      return {'success': false};
    }
  }

  Future<Map<String, dynamic>> doctorregistration(bool available, String name,
      String type, String email, String password) async {
    const url =
        'https://trying-c4dac-default-rtdb.firebaseio.com/doctors_info.json';

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: json.encode({
            "name": name,
            "email": email,
            "type": type,
            "availablity": available,
            "password": password,
          }));
      if (response == null) return {'success': false, 'status_code': 0};
      switch (response.statusCode) {
        case 200:
          return {'success': true, 'data': utf8.decode(response.bodyBytes)};
        case 201:
          return {'success': true, 'data': utf8.decode(response.bodyBytes)};
        default:
          return {
            'success': false,
            'status_code': response.statusCode.toString() +
                " - message: " +
                response.body.toString()
          };
      }
    } catch (e, _) {
      debugPrint("MFSException: " + e.toString() + " -- " + _.toString());
      return {'success': false};
    }
  }

  Future<Map<String, dynamic>> userPersonalInfo(
      String name, String info) async {
    const url =
        'https://trying-c4dac-default-rtdb.firebaseio.com/userpersonal_info.json';

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: json.encode({
            "name": name,
            "info": info,
          }));
      if (response == null) return {'success': false, 'status_code': 0};
      switch (response.statusCode) {
        case 200:
          return {'success': true, 'data': utf8.decode(response.bodyBytes)};
        case 201:
          return {'success': true, 'data': utf8.decode(response.bodyBytes)};
        default:
          return {
            'success': false,
            'status_code': response.statusCode.toString() +
                " - message: " +
                response.body.toString()
          };
      }
    } catch (e, _) {
      debugPrint("MFSException: " + e.toString() + " -- " + _.toString());
      return {'success': false};
    }
  }

  Future<Map<String, dynamic>> userLogIn(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCpMajuY0qQxhsJJPszfh_ZPADPOpqmWko';
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));

      if (response == null) return {'success': false, 'status_code': 0};
      switch (response.statusCode) {
        case 200:
          return {'success': true, 'data': utf8.decode(response.bodyBytes)};
        case 201:
          return {'success': true, 'data': utf8.decode(response.bodyBytes)};
        default:
          return {
            'success': false,
            'status_code': response.statusCode.toString() +
                " - message: " +
                response.body.toString()
          };
      }
    } catch (e, _) {
      debugPrint("MFSException: " + e.toString() + " -- " + _.toString());
      return {'success': false};
    }
  }

  Future<Map<String, dynamic>> userSignUp(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCpMajuY0qQxhsJJPszfh_ZPADPOpqmWko';
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));

      print(
          "------------------API RESPONSE-------------------------------------------");
      print(response);
      if (response == null) return {'success': false, 'status_code': 0};
      switch (response.statusCode) {
        case 200:
          return {'success': true, 'data': utf8.decode(response.bodyBytes)};
        case 201:
          return {'success': true, 'data': utf8.decode(response.bodyBytes)};
        default:
          return {
            'success': false,
            'status_code': response.statusCode.toString() +
                " - message: " +
                response.body.toString()
          };
      }
    } catch (e, _) {
      debugPrint("MFSException: " + e.toString() + " -- " + _.toString());
      return {'success': false};
    }
  }
}
