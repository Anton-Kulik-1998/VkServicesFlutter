import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vk_services_flutter/repositories/vk_services/models/models.dart';



class DataService {
  Future<VKDataModel> fetchVKData(http.Client client) async {
    final url =
        Uri.parse('https://publicstorage.hb.bizmrg.com/sirius/result.json');

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(utf8.decode(response.bodyBytes));
      return VKDataModel.fromJson(jsonData);
    } else {
      return throw Exception('Failed to load VK data');
    }
  }
}
