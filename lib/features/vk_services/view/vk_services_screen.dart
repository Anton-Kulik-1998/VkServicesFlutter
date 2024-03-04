import 'package:flutter/material.dart';
import 'package:vk_services_flutter/domain/api_clients/api_client.dart';
import 'package:vk_services_flutter/domain/entity/entity.dart';


class HomeScreen extends StatelessWidget {
  final ApiClient _dataService = ApiClient();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<VKData>(
        future: _dataService.getCervices(),
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
                    // _dataService.launchURL(service.link);
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
