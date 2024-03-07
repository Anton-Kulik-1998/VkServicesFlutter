import 'package:cached_network_image/cached_network_image.dart';
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
      backgroundColor: Colors.grey[100],
      body: VkServicesWidgetModelProvider(
        model: model,
        child: const _VkServicesWidget(),
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
      color: Colors.grey[400],
      displacement: 10,
      edgeOffset: 20,
      child: const _VkServicesCustomScrollViewWidget(),
    );
  }
}

class _VkServicesCustomScrollViewWidget extends StatelessWidget {
  const _VkServicesCustomScrollViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final vkData = VkServicesWidgetModelProvider.read(context)?.model.vkData;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.grey[100],
          expandedHeight: 90.0,
          titleSpacing: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Colors.transparent,
            ),
            centerTitle: true,
            titlePadding: const EdgeInsets.symmetric(horizontal: 20),
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  textAlign: TextAlign.start,
                  'Сервисы VK',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          floating: false, // Делаем AppBar "плавающим"
          pinned: false, // Закрепляем AppBar при прокрутке вниз
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: List.generate(
                vkData!.body.services.length,
                (index) => _VkServiceListTileWidget(index: index),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _VkServiceListTileWidget extends StatelessWidget {
  const _VkServiceListTileWidget({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    final model = VkServicesWidgetModelProvider.read(context)!.model;
    final service = model.vkData!.body.services[index];
    return ListTile(
      leading: Image(
        image: CachedNetworkImageProvider(service.iconURL),
      ),
      title: Text(service.name),
      subtitle: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              service.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: double.infinity,
            height: 2,
            child: Container(
              color: Colors.grey[100],
            ),
          )
        ],
      ),
      onTap: () {
        model.launchUrl(index);
      },
    );
  }
}
