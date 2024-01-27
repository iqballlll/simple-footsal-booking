import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_customer/core/routes/app_router.dart';
import 'package:mobile_customer/core/utilities/app_helper.dart';
import 'package:mobile_customer/core/utilities/constants/asset_constant.dart';
import 'package:mobile_customer/core/utilities/enums/snackbar_enum.dart';
import 'package:mobile_customer/core/utilities/style.dart';
import 'package:mobile_customer/data/local/local_data_source.dart';
import 'package:mobile_customer/domain/entities/profile/profile_entity.dart';

import 'package:mobile_customer/feature/profile/profile_cubit.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: const _ContentProfileScreen(),
    );
  }
}

class _ContentProfileScreen extends StatefulWidget {
  const _ContentProfileScreen();

  @override
  State<_ContentProfileScreen> createState() => _ContentProfileScreenState();
}

class _ContentProfileScreenState extends State<_ContentProfileScreen> {
  ValueNotifier<String> username = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 900));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await LocalDataSource.get(key: "profile").then((value) {
        var profileEntity = ProfileEntity.fromJson(jsonDecode(value!));
        username.value = profileEntity.name!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.errorMsg.isNotEmpty) {
          AppHelper.customSnackBar(
              context, state.errorMsg.toString(), SnackBarEnum.error);
        }
      },
      listenWhen: (previous, current) => previous.errorMsg != current.errorMsg,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: kToolbarHeight + 200,
            title: const Text('Profil'),
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 200),
              child: SizedBox(
                width: AppHelper.sizeW(context),
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        child: Image.asset(AssetConstant.iconUser),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ValueListenableBuilder(
                      valueListenable: username,
                      builder: (_, __, ___) => Text(
                        username.value,
                        style:
                            Style.title(context).copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _SubMenu(
            title: "Ubah Profil",
            onTap: () async {
              var res = await context.router.push(const ChangeProfileRoute());
              if (res != null) {
                var newRes = res as Map<String, dynamic>;
                username.value = newRes['username'];
              }
            },
            isLogout: false,
          ),
          _SubMenu(
            title: "Ubah Password",
            onTap: () {
              context.router.push(const ChangePasswordRoute());
            },
            isLogout: false,
          ),
          _SubMenu(
            title: "Logout",
            onTap: () {
              context.read<ProfileCubit>().logout();
              // context.router
              //     .popUntil((route) => route.settings.name == 'LoginRoute');
              // context.router.push(const LoginRoute());
            },
            isLogout: true,
          ),
        ],
      ),
    );
  }
}

class _SubMenu extends StatelessWidget {
  const _SubMenu({
    required this.title,
    required this.onTap,
    this.isLogout,
  });

  final String title;
  final bool? isLogout;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: AppHelper.sizeW(context),
            height: 60,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[100],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title),
                    if (isLogout == false)
                      const Icon(Icons.arrow_forward_ios_rounded),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
