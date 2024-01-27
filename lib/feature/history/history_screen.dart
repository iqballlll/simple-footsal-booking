import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_customer/core/components/custom_badge.dart';
import 'package:mobile_customer/core/components/data_not_found.dart';
import 'package:mobile_customer/core/utilities/extension.dart';
import 'package:mobile_customer/core/utilities/style.dart';
import 'package:mobile_customer/domain/entities/history_booking/history_booking_entity/history_booking_entity.dart';
import 'package:mobile_customer/domain/entities/history_booking/history_booking_entity/order_detail.dart';
import 'package:mobile_customer/feature/history/history_cubit.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit(),
      child: const ContentHistoryScreen(),
    );
  }
}

class ContentHistoryScreen extends StatefulWidget {
  const ContentHistoryScreen({super.key});

  @override
  State<ContentHistoryScreen> createState() => _ContentHistoryScreenState();
}

class _ContentHistoryScreenState extends State<ContentHistoryScreen> {
  RefreshController refreshController = RefreshController();
  @override
  void initState() {
    context.read<HistoryCubit>().getHistoryBooking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        header: const MaterialClassicHeader(
          height: kToolbarHeight + 80,
          distance: kToolbarHeight + 50,
          offset: kToolbarHeight,
        ),
        onRefresh: () async {
          refreshController.requestRefresh();

          await context.read<HistoryCubit>().getHistoryBooking();

          await Future.delayed(const Duration(milliseconds: 1000));

          refreshController.refreshCompleted();
        },
        controller: refreshController,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text(
                "Riwayat Penyewaan",
                style: Style.title(context).copyWith(color: Colors.white),
              ),
              leading: const BackButton(
                color: Colors.white,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: BlocBuilder<HistoryCubit, HistoryState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return _Loading(
                      isLoading: state.isLoading,
                    );
                  }
                  if (state.listHistoryBooking.isEmpty) {
                    return const SliverFillRemaining(child: DataNotFound());
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        HistoryBookingEntity data =
                            state.listHistoryBooking[index];
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
                      childCount: state.listHistoryBooking.length,
                    ),
                  );
                },
              ),
            )
          ],
        ),
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
