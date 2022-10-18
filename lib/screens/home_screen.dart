// ignore_for_file: prefer_const_constructors, implementation_imports, unused_import, unnecessary_import

// ignore: unused_import
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/controller/cubit.dart';
import 'package:news_app/controller/states.dart';
import 'package:news_app/styles/colors.dart';
import 'package:news_app/styles/styles.dart';
import 'package:news_app/widgets/build_botton.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var tasks = AppCubit.get(context).tasks;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: cubit.isDark
                  ? Icon(Icons.wb_sunny_outlined)
                  : Icon(
                      EvaIcons.moon,
                    ),
              onPressed: () {
                AppCubit.get(context).changeMode();
              },
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                  backgroundColor: cubit.isDark ? Colors.white : Colors.black,
                  child: Icon(
                    EvaIcons.person,
                    color: cubit.isDark ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              buildTaskBar(context),
              buildDateBar(selectedDate),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.builder(
                    //shrinkWrap: true,
                    //scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: cubit.tasks.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              curve: Curves.bounceInOut,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showBottmSheet(context, tasks[index]);
                                    },
                                    child:
                                        showTasks(context, cubit.tasks[index]),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    }),
              ),
            ],
          ),
        );
      },
    );
  }

  bottomSheetButton(
      {required String label,
      required onTap,
      required Color clr,
      bool isColose = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isColose == true
                ? AppCubit.get(context).isDark
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isColose == true ? Colors.transparent : clr,
        ),
        child: Center(
            child: Text(
          label,
          style: isColose
              ? titleStyle.copyWith(color: Colors.black)
              : titleStyle.copyWith(color: Colors.white),
        )),
      ),
    );
  }

  showBottmSheet(context, Map model) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(top: 4),
            // ignore: unrelated_type_equality_checks
            height: model['isComplete'] == 0
                ? MediaQuery.of(context).size.height * 0.32
                : MediaQuery.of(context).size.height * 0.32,
            color: AppCubit.get(context).isDark ? Colors.grey : Colors.white,
            child: Column(
              children: [
                Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppCubit.get(context).isDark
                        ? Colors.grey[600]
                        : Colors.grey[300],
                  ),
                ),
                Spacer(),
                model['isComplete'] == 1
                    ? Container()
                    : bottomSheetButton(
                        label: 'Task Completed',
                        onTap: () {
                          AppCubit.get(context).updateData(id: model['id']);
                          Navigator.pop(context);
                        },
                        clr: defaultColor,
                        context: context,
                      ),
                SizedBox(
                  height: 5,
                ),
                bottomSheetButton(
                  label: 'Delete Task',
                  onTap: () {
                    AppCubit.get(context).deleteData(id: model['id']);
                    Navigator.pop(context);
                  },
                  clr: Colors.red[300]!,
                  context: context,
                ),
                SizedBox(
                  height: 30,
                ),
                bottomSheetButton(
                  label: 'Close',
                  onTap: () {
                    Navigator.pop(context);
                  },
                  clr: Colors.red,
                  context: context,
                  isColose: true,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  showTasks(context, Map model) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: getColor(model['color']),
            //getColor(model['color']),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      '${model['title']}',
                      style: GoogleFonts.lato(
                        // ignore: prefer_const_constructors
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Icon(
                          EvaIcons.clockOutline,
                          color: Colors.grey[200],
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${model['stime']} - ${model['etime']}',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[100],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${model['note']}',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 0.5,
                height: 60,
                color: Colors.grey[200]!.withOpacity(0.7),
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  // ignore: unnecessary_string_interpolations, unrelated_type_equality_checks
                  model['isComplete'] == 1 ? 'Completed' : 'Todo',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
  getColor(no) {
    switch (no) {
      case 0:
        return defaultColor;
      case 1:
        return pinkColor;
      case 2:
        return yellowColor;
      default:
        return defaultColor;
    }
  }
}
