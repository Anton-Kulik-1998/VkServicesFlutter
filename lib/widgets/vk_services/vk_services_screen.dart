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
          expandedHeight: 110.0,
          titleSpacing: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Colors.transparent,
            ),
            centerTitle: true,
            titlePadding: const EdgeInsets.all(10),
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return _VkServiceListTileWidget(index: index);
            },
            childCount:
                vkData!.body.services.length, // Количество элементов в списке
          ),
        ),
      ],
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
        return _VkServiceListTileWidget(index: index);
      },
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
      subtitle: Text(service.description),
      onTap: () {
        model.launchUrl(index);
      },
    );
  }
}
