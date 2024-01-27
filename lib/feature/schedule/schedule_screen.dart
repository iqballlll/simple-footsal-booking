import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_customer/core/components/custom_badge.dart';
import 'package:mobile_customer/core/components/data_not_found.dart';
import 'package:mobile_customer/core/routes/app_router.dart';
import 'package:mobile_customer/core/utilities/extension.dart';
import 'package:mobile_customer/core/utilities/style.dart';
import 'package:mobile_customer/domain/entities/active_schedule/active_schedule_entity/active_schedule_entity.dart';
import 'package:mobile_customer/domain/entities/active_schedule/active_schedule_entity/order_detail.dart';
import 'package:mobile_customer/feature/schedule/schedule_cubit.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleCubit(),
      child: const ContentScheduleScreen(),
    );
  }
}

class ContentScheduleScreen extends StatefulWidget {
  const ContentScheduleScreen({super.key});

  @override
  State<ContentScheduleScreen> createState() => _ContentScheduleScreenState();
}

class _ContentScheduleScreenState extends State<ContentScheduleScreen> {
  RefreshController refreshController = RefreshController();
  @override
  void initState() {
    context.read<ScheduleCubit>().getActiveSchedule();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      header: const MaterialClassicHeader(
        height: kToolbarHeight + 80,
        distance: kToolbarHeight + 50,
        offset: kToolbarHeight,
      ),
      onRefresh: () async {
        refreshController.requestLoading();

        await context.read<ScheduleCubit>().getActiveSchedule();
        await Future.delayed(const Duration(milliseconds: 1000));
        refreshController.refreshCompleted();
      },
      onLoading: () async {
        await Future.delayed(const Duration(milliseconds: 2000));
        refreshController.loadComplete();
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            automaticallyImplyLeading: false,
            title: Text(
              "Jadwal Main",
              style: Style.title(context).copyWith(color: Colors.white),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    context.router.push(const HistoryRoute());
                  },
                  icon: Icon(
                    Icons.history_sharp,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 35,
                  ),
                ),
              )
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: BlocBuilder<ScheduleCubit, ScheduleState>(
              builder: (context, state) {
                if (state.isLoading.isTrue) {
                  return _Loading(
                    isLoading: state.isLoading,
                  );
                }
                if (state.listActiveSchedule.isEmpty) {
                  return const SliverFillRemaining(child: DataNotFound());
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      ActiveScheduleEntity data =
                          state.listActiveSchedule[index];

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        borderOnForeground: false,
                        elevation: .5,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(data.orderDate
                                      .toString()
                                      .toIndonesianDate()),
                                  CustomBadge(
                                    title: data.status.toString(),
                                    bgColor: CustomBadge.getColor(
                                        data.status.toString()),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "Total : ${data.downPayment.toString().toIDR()}"),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Waktu :"),
                              const SizedBox(
                                height: 10,
                              ),
                              if ((data.orderDetail ?? []).isNotEmpty)
                                Column(
                                  children: List.generate(
                                      data.orderDetail!.length, (index) {
                                    OrderDetail orderDetail =
                                        data.orderDetail![index];
                                    return Text(orderDetail.product!.name!);
                                  }),
                                )
                              else
                                const SizedBox(),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: state.listActiveSchedule.length,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      childAspectRatio: 4 / 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 1,
      children: List.generate(
        15,
        (index) => Skeletonizer(
          enabled: isLoading,
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(5)),
          ),
        ),
      ),
    );
  }
}
