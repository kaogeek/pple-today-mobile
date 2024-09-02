import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/convert_time_componenet.dart';
import '../../../../component/refresh_load_more_list_view.dart';
import '../../../../controllers/notification_card_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/colors.dart';

class NotifacationCardReadAll extends StatelessWidget {
  const NotifacationCardReadAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationCardController>(
      init: NotificationCardController(),
      initState: (_) {},
      builder: (controller) {
        if (controller.notificationAllModel.data == null) {
          return SizedBox(
            height: Get.height - 150,
            child: const Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            ),
          );
        }

        if ((controller.notificationAllModel.data ?? []).isEmpty) {
          return RefreshIndicator(
            onRefresh: controller.onRefresh,
            color: kPrimaryColor,
            child: SingleChildScrollView(
              child: SizedBox(
                height: Get.height - 150,
                child: const Center(
                  child: Text('ไม่มีข้อมูล'),
                ),
              ),
            ),
          );
        }

        return RefreshLoadMoreListView.builder(
          onRefresh: controller.onRefresh,
          onLoadMore: controller.onLoadMore,
          itemCount: controller.notificationAllModel.data!.length,
          itemBuilder: (context, index) {
            final _data = controller.notificationAllModel.data![index];

            return Card(
              margin: EdgeInsets.zero,
              color: _data.notification!.isRead ?? false ? Colors.white : Colors.grey.shade100,
              child: ListTile(
                leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage:
                        (_data.sender?.imageUrl ?? '').isEmpty ? null : NetworkImage(_data.sender!.imageUrl!),
                    child: (_data.sender?.imageUrl ?? '').isNotEmpty
                        ? null
                        : Text(
                            (_data.sender?.displayName?[0] ?? 'N').toUpperCase(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                title: Text(
                  _data.notification!.title ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: _data.notification!.isRead ?? false ? null : FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  ConvertTimeComponenet.convertToAgo(_data.notification!.createdDate!),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                trailing: _data.notification!.isRead ?? false
                    ? null
                    : Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: kPrimaryColor,
                        ),
                        height: 10,
                        width: 10,
                      ),
                onTap: () async {
                  controller.notificationAllModel.data![index].notification!.isRead = true;
                  controller.update();

                  bool isPost = controller.listType.contains(_data.notification!.type);

                  if (isPost && _data.notification!.toUserType!.toUpperCase() == 'USER') {
                    String postId = _data.notification!.link!.split('/').last;
                    Get.toNamed(
                      AppRoutes.POST_DETAIL,
                      arguments: {'POST_ID': postId},
                    );
                  }

                  await controller.fetchReadNotification(_data.notification!.id!);
                },
              ),
            );
          },
        );
      },
    );
  }
}
