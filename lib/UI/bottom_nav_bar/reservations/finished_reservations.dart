import 'package:butyprovider/Bolcs/canselOrderBloc.dart';
import 'package:butyprovider/Bolcs/get_current_orders_bloc.dart';
import 'package:butyprovider/UI/CustomWidgets/AppLoader.dart';
import 'package:butyprovider/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:butyprovider/UI/CustomWidgets/CustomButton.dart';
import 'package:butyprovider/UI/CustomWidgets/EmptyItem.dart';
import 'package:butyprovider/UI/CustomWidgets/ErrorDialog.dart';
import 'package:butyprovider/UI/CustomWidgets/LoadingDialog.dart';
import 'package:butyprovider/UI/CustomWidgets/on_done_dialog.dart';
import 'package:butyprovider/helpers/appEvent.dart';
import 'package:butyprovider/helpers/appState.dart';
import 'package:butyprovider/models/current_ordera_model.dart';
import 'package:butyprovider/models/general_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:butyprovider/Base/AllTranslation.dart';
class FinishedReservationView extends StatefulWidget {
  @override
  _FinishedReservationViewState createState() =>
      _FinishedReservationViewState();
}

class _FinishedReservationViewState extends State<FinishedReservationView> {
  @override
  void initState() {
    currentOrdersBloc.add(Hydrate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentOrdersBloc, AppState>(
      bloc: currentOrdersBloc,
      listener: (context, state) {},
      child: BlocBuilder(
        bloc: currentOrdersBloc,
        builder: (context, state) {
          var data = state.model as CurrentOrdersResponse;
          return data == null
              ? AppLoader()
              : data.orders == null
                  ? Center(
                      child: EmptyItem(
                      text: data.msg,
                    ))
                  : AnimationLimiter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.orders.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height / 2.6,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                                "${allTranslations.text("section")} "),
                                            Text(
                                              "${data.orders[index].services[0].nameAr}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                "${allTranslations.text("buty_name")}"),
                                            Text(
                                              "${data.orders[index].beautician.beautName}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                "${allTranslations.text("time")} "),
                                            Text(
                                              " ${data.orders[index].time} ",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                "${allTranslations.text("date")}"),
                                            Text(
                                              "${data.orders[index].date}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                "${allTranslations.text("details")}  "),
                                            Text(
                                              "${allTranslations.currentLanguage == "ar" ? data.orders[index].services[0].detailsAr : data.orders[index].services[0].detailsEn}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                "${allTranslations.text("cost")} "),
                                            Text(
                                              "  ${data.orders[index].cost}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            CustomSheet(
                                                context: context,
                                                widget: cansel(
                                                    data.orders[index].id),
                                                hight: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    3.5);
                                          },
                                          child: CustomButton(
                                            text:
                                                "${allTranslations.text("cansel")}",
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey[500]),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              )),
                            ),
                          );
                        },
                      ),
                    );
        },
      ),
    );
  }

  Widget cansel(int id) {
    return BlocListener(
      bloc: canselOrderbloc,
      listener: (context, state) {
        var data = state.model as GeneralResponse;
        if (state is Loading) {
          showLoadingDialog(context);
        } else if (state is ErrorLoading) {
          errorDialog(context: context, text: data.msg);
        } else if (state is Done) {
          Navigator.pop(context);

          onDoneDialog(
              context: context,
              text: data.msg,
              function: () {
                Navigator.pop(context);
                Navigator.pop(context);
                currentOrdersBloc.add(Hydrate());
              });
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              allTranslations.text("validate_cansel"),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              CustomButton(
                onBtnPress: () {
                  canselOrderbloc.updateId(id);
                  canselOrderbloc.updateStatus(3);
                  canselOrderbloc.add(Click());
                },
                width: MediaQuery.of(context).size.width / 2.8,
                text: allTranslations.text("yes"),
              ),
              CustomButton(
                onBtnPress: () {
                  Navigator.pop(context);
                },
                width: MediaQuery.of(context).size.width / 2.8,
                text: allTranslations.text("no"),
                textColor: Colors.black,
                color: Colors.white,
                raduis: 1,
              ),
            ],
          )
        ],
      ),
    );
  }
}
