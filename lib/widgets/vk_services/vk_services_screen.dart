import 'package:flutter/material.dart';
import 'package:vk_services_flutter/widgets/vk_services/vk_services_screen_model.dart';

class VkServices extends StatefulWidget {
  const VkServices({super.key});

  @override
  State<VkServices> createState() => _VkServicesState();
}

class _VkServicesState extends State<VkServices> {
  final model = VkServicesWidgetModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: VkServicesWidgetModelProvider(
          model: model,
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
    final vkData = VkServicesWidgetModelProvider.watch(context)?.model.vkData;
    return (vkData != null)
        ? RefreshIndicator(
            onRefresh: () async {
              await VkServicesWidgetModelProvider.read(context)
                  ?.model
                  .reloadServices();
            },
            child: ListView.builder(
              itemCount: vkData.body.services.length,
              itemBuilder: (context, index) {
                final vkData =
                    VkServicesWidgetModelProvider.read(context)!.model.vkData;
                return ListTile(
                  title: Text(vkData!.body.services[index].name),
                  subtitle: Text(vkData.body.services[index].description),
                  onTap: () {
                    // _dataService.launchURL(service.link);
                  },
                );
              },
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
