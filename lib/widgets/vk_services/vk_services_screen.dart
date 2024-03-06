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
        ? const _VkServicesRefreshIndicatorWidget()
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}

class _VkServicesRefreshIndicatorWidget extends StatelessWidget {
  const _VkServicesRefreshIndicatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await VkServicesWidgetModelProvider.read(context)
            ?.model
            .reloadServices();
      },
      child: const _VkServicesListViewWidget(),
    );
  }
}

class _VkServicesListViewWidget extends StatelessWidget {
  const _VkServicesListViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vkData = VkServicesWidgetModelProvider.read(context)?.model.vkData;
    return ListView.builder(
      itemCount: vkData!.body.services.length,
      itemBuilder: (context, index) {
        return _VkServicesListTileWidget(index: index);
      },
    );
  }
}

class _VkServicesListTileWidget extends StatelessWidget {
  const _VkServicesListTileWidget({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    final vkData = VkServicesWidgetModelProvider.read(context)!.model.vkData;
    return ListTile(
      leading: Image.network(
        vkData!.body.services[index].iconURL,
      ),
      title: Text(vkData.body.services[index].name),
      subtitle: Text(vkData.body.services[index].description),
      onTap: () {
        // _dataService.launchURL(service.link);
      },
    );
  }
}
