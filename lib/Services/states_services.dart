import 'dart:convert';

import 'package:chickenpox/Models/world_states_model.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesModelRecord() async {
    final response = await http.get(
        Uri.parse('https://mocki.io/v1/1dc0f4a1-b36e-40f9-9ac3-b035abb1656b'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print('API Response Data: $data');
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    var data;
    final response = await http.get(
        Uri.parse('https://mocki.io/v1/1e2dc1f1-8ca5-4134-8e5c-3698c96e85e1'));
    print(response.statusCode.toString());
    print(data);

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
