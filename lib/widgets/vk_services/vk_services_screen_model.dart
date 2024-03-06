import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vk_services_flutter/domain/api_clients/api_client.dart';
import 'package:vk_services_flutter/domain/entity/entity.dart';

class VkServicesWidgetModel extends ChangeNotifier {
  VkServicesWidgetModel() {
    reloadServices();
  }
  final apiClient = ApiClient();
  VKData? _vkData;
  VKData? get vkData => _vkData;

  Future<void> reloadServices() async {
    final vkData = await apiClient.getCervices();
    _vkData = vkData;
    notifyListeners();
  }

  Future<void> launchUrl(int indexUrl) async {
    String vkServiceUrl = _vkData!.body.services[indexUrl].link;
    if (await canLaunchUrlString(vkServiceUrl)) {
      await launchUrlString(vkServiceUrl);
    } else {
      throw 'Could not launch $vkServiceUrl';
    }
  }
}

class VkServicesWidgetModelProvider extends InheritedNotifier {
  final VkServicesWidgetModel model;
  const VkServicesWidgetModelProvider({
    super.key,
    required this.model,
    required this.child,
  }) : super(
          child: child,
          notifier: model,
        );

  @override
  final Widget child;

  static VkServicesWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VkServicesWidgetModelProvider>();
  }

  static VkServicesWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            VkServicesWidgetModelProvider>()
        ?.widget;
    return widget is VkServicesWidgetModelProvider ? widget : null;
  }
}
