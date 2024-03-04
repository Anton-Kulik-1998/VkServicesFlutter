import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vk_services_flutter/domain/entity/entity.dart';
import 'package:vk_services_flutter/repositories/vk_services/data_example.dart';

class HomeScreen extends StatelessWidget {
  final DataService _dataService = DataService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<VKData>(
        future: _dataService.fetchVKData(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error!: ${snapshot.error}'));
          } else {
            final vkData = snapshot.data!;
            return ListView.builder(
              itemCount: vkData.body.services.length,
              itemBuilder: (context, index) {
                final service = vkData.body.services[index];
                return ListTile(
                  title: Text(service.name),
                  subtitle: Text(service.description),
                  onTap: () {
                    _dataService.launchURL(service.link);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
