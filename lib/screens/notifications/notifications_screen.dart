import 'package:bebrain/model/notification_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/network/api_url.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/shimmer/shimmer_bubble.dart';
import 'package:bebrain/widgets/shimmer/shimmer_loading.dart';
import 'package:bebrain/widgets/vex/vex_loader.dart';
import 'package:bebrain/widgets/vex/vex_paginator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  Future<NotificationModel> _fetchNotifications(int pageKey) {
    final snapshot = ApiService<NotificationModel>().build(
      url: '${ApiUrl.notification}?page=$pageKey',
      isPublic: false,
      apiType: ApiType.get,
      builder: NotificationModel.fromJson,
    );
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(pinned: true),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Text(
                context.appLocalization.notifications,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          VexPaginator(
            query: (pageKey) async => _fetchNotifications(pageKey),
            onFetching: (snapshot) async => snapshot.data!,
            pageSize: 10,
            sliver: true,
            onLoading: (){
              return ShimmerLoading(
                child: ListView.separated(
                  separatorBuilder:(context, index) => const SizedBox(height: 10) ,
                  itemCount: 10,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return const LoadingBubble(
                       width: double.infinity,
                       height: 90,
                       margin:  EdgeInsets.symmetric(horizontal: 15),
                       radius: MyTheme.radiusSecondary,
                    );
                  },
                  ),
                );
            },
            builder: (context, snapshot) {
              final notification = snapshot.docs as List<NotificationData>;
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                sliver: SliverList.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemCount: snapshot.docs.length + 1,
                  itemBuilder: (context, index) {
                    if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                      snapshot.fetchMore();
                    }

                    if (index == snapshot.docs.length) {
                      return VexLoader(snapshot.isFetchingMore);
                    }
                    return Container(
                      width: double.infinity,
                      // height: 99,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? context.colorPalette.blueE4F
                            : context.colorPalette.greyF2F,
                        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            notification[index].title!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            notification[index].content!,
                            // maxLines: 2,
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: context.colorPalette.grey66,
                            ),
                          ),
                          // const Spacer(),
                          Align(
                            alignment: context.isLTR
                                ? Alignment.bottomRight
                                : Alignment.bottomLeft,
                            child: Text(
                              DateFormat("dd/MM/yyyy - h:mm a").format(notification[index].createdAt!.toUTC(context)),
                              style: TextStyle(
                                color: context.colorPalette.grey66,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
