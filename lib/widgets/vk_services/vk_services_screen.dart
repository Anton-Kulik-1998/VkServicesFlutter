import 'package:flutter/material.dart';
import 'package:vk_services_flutter/domain/api_clients/api_client.dart';
import 'package:vk_services_flutter/domain/entity/entity.dart';
import 'package:vk_services_flutter/widgets/vk_services/vk_services_screen_model.dart';

class VkServices extends StatefulWidget {
  const VkServices({super.key});

  @override
  State<VkServices> createState() => _VkServicesState();
}

class _VkServicesState extends State<VkServices> {
  final _model = VkServicesWidgetModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: VkServicesWidgetModelProvider(
          model: _model,
          child: const _VkServicesWidget(),
        ),
      ),
    );
  }
}

class _VkServicesWidget extends StatelessWidget {
  const _VkServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: VkServicesWidgetModelProvider.watch(context)?.model.services.body.services.length ?? 0,
      itemBuilder: (context, index) {
        final vkData =
            VkServicesWidgetModelProvider.read(context)!.model.services;
        return ListTile(
          title: Text(vkData.body.services[index].name),
          subtitle: Text(vkData.body.services[index].description),
          onTap: () {
            // _dataService.launchURL(service.link);
          },
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final ApiClient _dataService = ApiClient();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: VkFutureBuilder(
          dataService: _dataService,
        ),
      ),
    );
  }
}

class VkFutureBuilder extends StatelessWidget {
  const VkFutureBuilder({
    super.key,
    required ApiClient dataService,
  }) : _dataService = dataService;

  final ApiClient _dataService;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VKData>(
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
    );
  }
}
