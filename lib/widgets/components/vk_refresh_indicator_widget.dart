import 'package:flutter/material.dart';
import 'package:vk_services_flutter/widgets/vk_services/vk_services_screen_model.dart';

class VkRefreshIndicatorWidget extends StatelessWidget {
  const VkRefreshIndicatorWidget({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: () async {
        await VkServicesWidgetModelProvider.read(context)
            ?.model
            .reloadServices();
      },
      color: theme.colorScheme.inversePrimary,
      backgroundColor: theme.colorScheme.primary,
      displacement: 10,
      edgeOffset: 20,
      child: child,
    );
  }
}