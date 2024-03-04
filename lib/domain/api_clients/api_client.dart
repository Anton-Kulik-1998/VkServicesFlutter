import 'dart:convert';
import 'dart:io';

import 'package:vk_services_flutter/domain/entity/vk_data/vk_data.dart';

class ApiClient {
  final client = HttpClient();

  Future<VKData> getCervices() async {
    final url =
        Uri.parse("https://publicstorage.hb.bizmrg.com/sirius/result.json");
        
    final request = await client.getUrl(url);
    final response = await request.close();

    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();

    final json = jsonDecode(jsonString);
    final vkData = VKData.fromJson(json as Map<String, dynamic>);
    return vkData;
  }
}
