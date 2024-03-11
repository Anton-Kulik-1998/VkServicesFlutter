import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vk_services_flutter/widgets/components/components.dart';
import 'package:vk_services_flutter/widgets/vk_services/vk_services_screen_model.dart';

class VkServicesWidget extends StatefulWidget {
  const VkServicesWidget({super.key});

  @override
  State<VkServicesWidget> createState() => _VkServicesWidgetState();
}

class _VkServicesWidgetState extends State<VkServicesWidget> {
  final model = VkServicesWidgetModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VkServicesWidgetModelProvider(
        model: model,
        child: const _VkServicesWidgetBody(),
      ),
    );
  }
}

class _VkServicesWidgetBody extends StatelessWidget {
  const _VkServicesWidgetBody();

  @override
  Widget build(BuildContext context) {
    final vkData = VkServicesWidgetModelProvider.watch(context)?.model.vkData;
    return (vkData != null)
        ? const VkRefreshIndicatorWidget(
            child: _VkCustomScrollViewWidget(),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}

class _VkCustomScrollViewWidget extends StatelessWidget {
  const _VkCustomScrollViewWidget();

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <Widget>[
        _VkSliverAppBar(),
        _VkSliverListTileDecoration(),
      ],
    );
  }
}

class _VkSliverListTileDecoration extends StatelessWidget {
  const _VkSliverListTileDecoration();
  @override
  Widget build(BuildContext context) {
    final vkData = VkServicesWidgetModelProvider.read(context)?.model.vkData;
    final ThemeData theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: List.generate(
            vkData!.body.services.length,
            (index) => _VkServiceListTileWidget(index: index),
          ),
        ),
      ),
    );
  }
}

class _VkSliverAppBar extends StatelessWidget {
  const _VkSliverAppBar();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SliverAppBar(
      backgroundColor: theme.colorScheme.background,
      expandedHeight: 90.0,
      titleSpacing: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: theme.colorScheme.background,
        ),
        centerTitle: true,
        titlePadding: const EdgeInsets.symmetric(horizontal: 20),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              textAlign: TextAlign.start,
              'Сервисы VK',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floating: false, // Делаем AppBar "плавающим"
      pinned: false, // Закрепляем AppBar при прокрутке вниз
    );
  }
}

class _VkServiceListTileWidget extends StatelessWidget {
  const _VkServiceListTileWidget({
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    final model = VkServicesWidgetModelProvider.read(context)!.model;
    final service = model.vkData!.body.services[index];
    final ThemeData theme = Theme.of(context);
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
              color: theme.colorScheme.secondary,
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
