import 'package:flutter/material.dart';
import 'package:mobile_customer/core/utilities/app_helper.dart';
import 'package:mobile_customer/core/utilities/constants/asset_constant.dart';
import 'package:mobile_customer/core/utilities/style.dart';

class DataNotFound extends StatelessWidget {
  const DataNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AssetConstant.search,
          width: AppHelper.sizeW(context) * .4,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Data tidak ditemukan',
          style: Style.title(context),
        ),
      ],
    );
  }
}
