// ignore_for_file: prefer_const_constructors

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/controller/cubit.dart';
import 'package:news_app/controller/states.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/styles/colors.dart';
import 'package:news_app/styles/styles.dart';
import 'package:news_app/widgets/build_botton.dart';
import 'package:news_app/widgets/build_form_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  var titleController = TextEditingController();
  var noteController = TextEditingController();
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  var remindController = TextEditingController();
  var repateController = TextEditingController();
  var colorController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String endTime = '09:00 AM';
  String startTime = DateFormat('hh:mm a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var repeatList = AppCubit.get(context).repeatList;
        var reminList = AppCubit.get(context).reminList;
        var selectedRemind = AppCubit.get(context).selectedRemind;
        var selectedRepeat = AppCubit.get(context).selectedRepeat;
        var selectedColor = AppCubit.get(context).selectedColor;
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Task',
                      style: cubit.isDark
                          ? headingStyle
                          : headingStyle.copyWith(color: Colors.black),
                    ),
                    MyFormField(
                      title: 'Title',
                      hint: 'Enter your title',
                      controller: titleController,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'This is required';
                        }
                        //return null;
                      },
                    ),
                    MyFormField(
                      title: 'Note',
                      hint: 'Enter your note',
                      controller: noteController,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'This is required';
                        }
                        return null;
                      },
                    ),
                    MyFormField(
                      title: 'Date',
                      hint: DateFormat.yMd().format(selectedDate),
                      controller: dateController,
                      widget: IconButton(
                        onPressed: () {
                          getDateFromUser(context);
                        },
                        icon:
                            Icon(EvaIcons.calendarOutline, color: Colors.grey),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyFormField(
                            title: 'Start Time',
                            hint: startTime,
                            controller: startTimeController,
                            widget: IconButton(
                              onPressed: () {
                                getStartTimeFromUser(context);
                              },
                              icon: Icon(EvaIcons.clockOutline),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: MyFormField(
                            title: 'End Time',
                            controller: endTimeController,
                            hint: endTime,
                            widget: IconButton(
                              onPressed: () {
                                getEndTimeFromUser(context);
                              },
                              icon: Icon(EvaIcons.clockOutline),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    MyFormField(
                      title: 'Remind',
                      controller: remindController,
                      hint: '$selectedRemind minutes early',
                      widget: DropdownButton(
                        value: selectedRemind,
                        icon: Icon(EvaIcons.arrowDownOutline),
                        style: subTitleStyle,
                        iconSize: 30,
                        elevation: 4,
                        underline: Container(
                          color: Colors.white,
                        ),
                        items: reminList.map((reminList) {
                          return DropdownMenuItem(
                            value: reminList,
                            child: Text('$reminList'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          AppCubit.get(context).changeRemind(value);
                        },
                      ),
                    ),
                    MyFormField(
                      title: 'Repate',
                      controller: repateController,
                      hint: AppCubit.get(context).selectedRepeat,
                      widget: DropdownButton(
                        value: AppCubit.get(context).selectedRepeat,
                        icon: Icon(EvaIcons.arrowDownOutline),
                        style: subTitleStyle,
                        iconSize: 30,
                        elevation: 4,
                        underline: Container(
                          color: Colors.white,
                        ),
                        items:
                            AppCubit.get(context).repeatList.map((repeatList) {
                          return DropdownMenuItem(
                            value: repeatList,
                            child: Text(repeatList.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          AppCubit.get(context).selectRepeat(value);
                        },
                      ),
                    ),
                    SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildColorItem(context),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: myBotton(
                              label: 'Create Task',
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  AppCubit.get(context)
                                      .insertDatabase(
                                    title: titleController.text,
                                    note: noteController.text,
                                    date: dateController.text,
                                    stime: startTimeController.text,
                                    etime: endTimeController.text,
                                    remind: selectedRemind.toString(),
                                    repate: selectedRepeat,
                                    color: selectedColor,
                                  )
                                      .then((value) {
                                    navigateTo(context, HomeScreen());
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                    msg: 'Please Enter All Fields',
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                  );
                                }
                              }),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void getDateFromUser(context) => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.parse('2022-12-31'),
      ).then((value) {
        dateController.text = DateFormat.yMd().format(value!).toString();
      });

  void getStartTimeFromUser(context) => showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      ).then((value) {
        startTimeController.text = value!.format(context).toString();
      });

  void getEndTimeFromUser(context) => showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      ).then((value) {
        endTimeController.text = value!.format(context).toString();
      });

  //Get Color
  buildColorItem(context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Color',
            style: AppCubit.get(context).isDark
                ? titleStyle.copyWith(color: Colors.white)
                : titleStyle,
          ),
          SizedBox(height: 8),
          Wrap(
            children: List.generate(3, (index) {
              return GestureDetector(
                onTap: () {
                  AppCubit.get(context).changeColor(index);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? defaultColor
                        : index == 1
                            ? pinkColor
                            : yellowColor,
                    child: AppCubit.get(context).selectedColor == index
                        ? Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : null,
                  ),
                ),
              );
            }),
          )
        ],
      );
}
