import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vk_services_flutter/domain/entity/entity.dart';

class DataService {
  Future<VKData> fetchVKData(http.Client client) async {
    final url =
        Uri.parse('https://publicstorage.hb.bizmrg.com/sirius/result.json');

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(utf8.decode(response.bodyBytes));
      return VKData.fromJson(jsonData as Map<String, dynamic>);
    } else {
      return throw Exception('Failed to load VK data');
    }
  }

  void launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
