import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_customer/core/components/data_not_found.dart';
import 'package:mobile_customer/core/routes/app_router.dart';
import 'package:mobile_customer/core/utilities/app_helper.dart';
import 'package:mobile_customer/core/utilities/constants/asset_constant.dart';
import 'package:mobile_customer/core/utilities/style.dart';
import 'package:mobile_customer/data/local/local_data_source.dart';
import 'package:mobile_customer/domain/entities/profile/profile_entity.dart';
import 'package:mobile_customer/feature/home/home_cubit.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const _ContentHomeScreen(),
    );
  }
}

class _ContentHomeScreen extends StatefulWidget {
  const _ContentHomeScreen();

  @override
  State<_ContentHomeScreen> createState() => _ContentHomeScreenState();
}

class _ContentHomeScreenState extends State<_ContentHomeScreen> {
  ValueNotifier<String> username = ValueNotifier<String>('');
  final RefreshController refreshController = RefreshController();
  @override
  void initState() {
    context.read<HomeCubit>().getSchedule();
    context.read<HomeCubit>().getCountOrder();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await LocalDataSource.get(key: "profile").then((value) {
        var profileEntity = ProfileEntity.fromJson(jsonDecode(value!));
        username.value = profileEntity.name!;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SmartRefresher(
            onRefresh: () async {
              refreshController.requestRefresh();

              await context.read<HomeCubit>().getSchedule();
              await Future.delayed(const Duration(milliseconds: 1000));
              refreshController.refreshCompleted();
            },
            onLoading: () async {
              await Future.delayed(const Duration(milliseconds: 2000));
              refreshController.loadComplete();
            },
            header: const MaterialClassicHeader(
              height: kToolbarHeight + 150,
              distance: kToolbarHeight + 100,
              offset: kToolbarHeight,
            ),
            controller: refreshController,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  bottom: PreferredSize(
                    preferredSize: const Size(double.infinity, kToolbarHeight),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          SizedBox.fromSize(
                            size: const Size(60, 60),
                            child: CircleAvatar(
                              child: Image.asset(AssetConstant.iconUser),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selamat Datang',
                                style: Style.title2(context)
                                    .copyWith(color: Colors.white),
                              ),
                              const SizedBox(height: 5),
                              ValueListenableBuilder(
                                  valueListenable: username,
                                  builder: (_, __, ___) => Text(
                                        username.value,
                                        style: Style.title2(context).copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return Skeletonizer(
                          enabled: state.isLoading,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              aspectRatio: 3 / 4,
                              viewportFraction: 1,
                              height: 150.0,
                            ),
                            items: [
                              AssetConstant.footsal1,
                              AssetConstant.footsal2,
                              AssetConstant.footsal3
                            ].map((i) {
                              return Container(
                                width: AppHelper.sizeW(context),
                                height: 100,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(i),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state.countOrder['data'] == null ||
                        state.countOrder['data'] <= 7) {
                      return const SliverToBoxAdapter();
                    }
                    return SliverPadding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
                      sliver: SliverToBoxAdapter(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Selamat! 🤩",
                                  style: Style.body1(context)
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Anda mendapatkan bonus karena sudah 7x menyewa lapang futsal kami. ",
                                  textAlign: TextAlign.justify,
                                  style: Style.body2(context),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "*Silakan hubungi admin atau datang ke lapang futsal",
                                  style: Style.caption(context)
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  sliver: SliverToBoxAdapter(
                    child: Text('Jadwal Hari Ini', style: Style.body1(context)),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return SliverGrid.count(
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 3,
                          children: List.generate(
                            15,
                            (index) => Skeletonizer(
                              enabled: state.isLoading,
                              child: const DecoratedBox(
                                decoration: BoxDecoration(color: Colors.grey),
                              ),
                            ),
                          ),
                        );
                      }
                      if (state.listSchedule.isEmpty) {
                        return const SliverFillRemaining(
                          child: DataNotFound(),
                        );
                      }
                      return SliverGrid.count(
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        children: List.generate(
                          state.listSchedule.length,
                          (index) => Skeletonizer(
                            enabled: state.isLoading,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color:
                                    state.listSchedule[index].orders!.isNotEmpty
                                        ? Colors.grey[500]
                                        : Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  state.listSchedule[index].orders!.isNotEmpty
                                      ? "Telah Dibooking"
                                      : state.listSchedule[index].name ?? '',
                                  style: Style.body2(context)
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: SizedBox.fromSize(
            size: const Size(55, 55),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.green,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 35,
                ),
                onPressed: () {
                  context.router.push(const AddBookingRoute());
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
