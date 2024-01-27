import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_customer/core/requests/add_booking/add_booking_request.dart';
import 'package:mobile_customer/core/requests/add_booking/add_booking_validation.dart';

import 'package:mobile_customer/core/utilities/app_helper.dart';
import 'package:mobile_customer/core/utilities/enums/snackbar_enum.dart';
import 'package:mobile_customer/core/utilities/extension.dart';
import 'package:mobile_customer/core/utilities/style.dart';
import 'package:mobile_customer/domain/entities/schedule_entity.dart/schedule_entity/schedule_entity.dart';
import 'package:mobile_customer/feature/add_booking/add_booking_cubit.dart';
import 'package:mobile_customer/feature/home/home_cubit.dart';

import 'package:skeletonizer/skeletonizer.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

@RoutePage()
class AddBookingScreen extends StatelessWidget {
  const AddBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AddBookingCubit(),
        ),
        BlocProvider(
          create: (_) => HomeCubit(),
        )
      ],
      child: const _ContentAddBookingScreen(),
    );
  }
}

class _ContentAddBookingScreen extends StatefulWidget {
  const _ContentAddBookingScreen();

  @override
  State<_ContentAddBookingScreen> createState() =>
      _ContentAddBookingScreenState();
}

class _ContentAddBookingScreenState extends State<_ContentAddBookingScreen> {
  String newDate = '';
  List<int> selectedSchedule = [];
  String date = DateTime.now().toString().toYMD();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<AddBookingCubit>().refetchSchedule({'filter': date});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Pesan Lapang',
          style: Style.title(context).copyWith(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: BackButton(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        actions: [
          IconButton(
            onPressed: () {
              AddBookingRequest addBookingRequest = AddBookingRequest(
                orderDate: newDate,
                productId: selectedSchedule,
                paymentType: 'down_payment',
              );

              var validation = AddBookingValidation.validate(addBookingRequest);

              if (validation.isNotEmpty) {
                AppHelper.customSnackBar(
                  context,
                  validation,
                  SnackBarEnum.error,
                );
                return;
              }

              context
                  .read<AddBookingCubit>()
                  .addBooking(addBookingRequest.toMap());
            },
            icon: Icon(
              Icons.check,
              color: Theme.of(context).scaffoldBackgroundColor,
              size: 28,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: SfDateRangePicker(
                onSelectionChanged: (selectedDate) {
                  newDate = selectedDate.value.toString().toYMD();
                  context.read<AddBookingCubit>().refetchSchedule({
                    "filter": newDate,
                  });
                },
                showNavigationArrow: true,
                minDate: DateTime.now(),
                backgroundColor: Colors.grey[200],
                cellBuilder:
                    (BuildContext context, DateRangePickerCellDetails details) {
                  final bool isToday = isSameDate(details.date, DateTime.now());
                  final bool isBefore = details.date.isBefore(DateTime.now());

                  return Stack(
                    children: isToday
                        ? [
                            Positioned(
                              child: Container(
                                margin: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                child: Center(
                                    child: Text(
                                  details.date.day.toString(),
                                  style: Style.white,
                                )),
                              ),
                            ),
                            Positioned(
                              bottom: -7,
                              left: 25,
                              right: 25,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white),
                                ),
                                child: SizedBox.fromSize(
                                  size: const Size(20, 20),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]
                        : [
                            Positioned(
                              child: Container(
                                margin: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: !isBefore
                                      ? Theme.of(context)
                                          .scaffoldBackgroundColor
                                      : Colors.grey[300],
                                  border: isToday
                                      ? Border.all(
                                          color: Colors.black, width: 2)
                                      : null,
                                ),
                                child: Center(
                                    child: Text(details.date.day.toString())),
                              ),
                            ),
                          ],
                  );
                },
                view: DateRangePickerView.month,
                monthViewSettings:
                    const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Waktu Yang Tersedia',
                style: Style.body1(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                  height: 450,
                  child: BlocBuilder<AddBookingCubit, AddBookingState>(
                    builder: (context, addBookingState) {
                      List<ScheduleEntity> listSchedule =
                          addBookingState.listSchedule;

                      return BlocBuilder<AddBookingCubit, AddBookingState>(
                        builder: (context, addBookingState) {
                          if (addBookingState.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return Skeletonizer(
                            enabled: addBookingState.isLoading,
                            child: GridView.count(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 3 / 2,
                              children: List.generate(
                                listSchedule.length,
                                (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if ((listSchedule[index].orders ?? [])
                                          .isNotEmpty) {
                                        AppHelper.customSnackBar(
                                            context,
                                            "Jadwal sudah dipesan",
                                            SnackBarEnum.error);
                                        return;
                                      }

                                      context
                                          .read<AddBookingCubit>()
                                          .selectSchedule(
                                              listSchedule[index].id!);

                                      selectSchedule(listSchedule[index].id!);
                                    },
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: (listSchedule[index].orders ??
                                                    [])
                                                .isNotEmpty
                                            ? Colors.grey[500]
                                            : addBookingState.selectedSchedule
                                                    .contains(
                                                        listSchedule[index].id)
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          addBookingState
                                              .listSchedule[index].name
                                              .toString(),
                                          style: Style.body2(context).copyWith(
                                              color: addBookingState
                                                      .selectedSchedule
                                                      .contains(
                                                          listSchedule[index]
                                                              .id!)
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }

  bool isSameDate(DateTime date, DateTime dateTime) {
    if (date.year == dateTime.year &&
        date.month == dateTime.month &&
        date.day == dateTime.day) {
      return true;
    }

    return false;
  }

  List<int> selectSchedule(id) {
    selectedSchedule.contains(id)
        ? selectedSchedule.remove(id)
        : selectedSchedule.add(id);
    return selectedSchedule;
  }
}
