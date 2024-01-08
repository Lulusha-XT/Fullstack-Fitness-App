import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:frontend/src/features/core/controllers/workout_plan_controller.dart';
import 'package:frontend/src/features/core/models/workout_model.dart';
import 'package:frontend/src/utils/themes/theme.dart';

class AddWorkoutPlanDialog extends StatefulWidget {
  const AddWorkoutPlanDialog({super.key, required this.onSubmit});
  final void Function(Workout workout) onSubmit;
  @override
  State<AddWorkoutPlanDialog> createState() => _AddWorkoutPlanDialogState();
}

class _AddWorkoutPlanDialogState extends State<AddWorkoutPlanDialog> {
  final WorkoutPlanController workoutPlanController =
      Get.put(WorkoutPlanController());
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  int _selectedColorIndex = 0;
  String workoutType = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("addWorkoutPlan".tr),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: cFormHeigth - 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                fillColor: Colors.black,
                labelText: "workoutType".tr,
                prefixIcon: const Icon(Icons.person_2_outlined),
              ),
              validator: (value) => validate(value, "workoutType".tr),
              onChanged: (value) {
                if (value != null) {
                  workoutType = value;
                }
              },
              onSaved: (value) {
                if (value != null) {
                  workoutType = value;
                }
              },
              items:
                  ['Uper Body', 'Lower Body', "Full Body"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: cFormHeigth - 20),
            TextFormField(
              controller: _noteController,
              decoration: InputDecoration(
                label: Text("workoutNote".tr),
                prefixIcon: const Icon(Icons.phone_outlined),
              ),
              validator: (value) => validate(value, "workoutNote".tr),
            ),
            const SizedBox(height: cFormHeigth - 20),
            TextFormField(
              readOnly: true,
              autofocus: false,
              decoration: InputDecoration(
                label: Text(DateFormat.yMd().format(_selectedDate)),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () async {
                    _getDateFromUser();
                  },
                ),
              ),
              validator: (value) => validate(value, ""),
            ),
            const SizedBox(height: cFormHeigth - 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "startDate".tr,
                        style: titleStyle,
                      ),
                      TextFormField(
                        readOnly: true,
                        autofocus: false,
                        decoration: InputDecoration(
                          label: Text(_startTime),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.access_time_filled_rounded,
                              color: Colors.grey,
                            ),
                            onPressed: () async {
                              _getTimeFromUser(isStartTime: true);
                            },
                          ),
                        ),
                        validator: (value) => validate(value, _startTime),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "endDate".tr,
                        style: titleStyle,
                      ),
                      TextFormField(
                        readOnly: true,
                        autofocus: false,
                        decoration: InputDecoration(
                          label: Text(_endTime),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.access_time_filled_rounded,
                              color: Colors.grey,
                            ),
                            onPressed: () async {
                              _getTimeFromUser(isStartTime: false);
                            },
                          ),
                        ),
                        validator: (value) => validate(value, "endDate".tr),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: cFormHeigth - 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                fillColor: Colors.black,
                labelText: "$_selectedRemind minutes early",
                prefixIcon: const Icon(Icons.person_2_outlined),
              ),
              validator: (value) =>
                  validate(value, "$_selectedRemind minutes early"),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedRemind = int.parse(value);
                  });
                }
              },
              onSaved: (value) {
                if (value != null) {
                  setState(() {
                    _selectedRemind = int.parse(value);
                  });
                }
              },
              items: remindList.map<DropdownMenuItem<String>>(
                (int value) {
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: cFormHeigth - 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                fillColor: Colors.black,
                labelText: "$_selectedRepeat ",
                prefixIcon: const Icon(Icons.person_2_outlined),
              ),
              validator: (value) => validate(value, _selectedRepeat),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedRepeat = value;
                  });
                }
              },
              onSaved: (value) {
                if (value != null) {
                  setState(() {
                    _selectedRepeat = value;
                  });
                }
              },
              items: repeatList.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: cFormHeigth - 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _colorPalette(),
                Expanded(
                  child: ElevatedButton(
                    style: const ButtonStyle(alignment: Alignment.center),
                    onPressed: () async {
                      _validateData();
                    },
                    child: Text(
                      "createWorkout".tr,
                      style: const TextStyle(color: AppColors.cWhiteClr),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("cancel".tr),
        ),
      ],
    );
  }

  Widget _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "colors".tr,
          style: titleStyle,
        ),
        const SizedBox(height: 8.0),
        Wrap(
          children: List<Widget>.generate(
            3,
            (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColorIndex = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? AppColors.cOrange
                        : index == 1
                            ? AppColors.cPinkClr
                            : AppColors.cYellowClr,
                    child: _selectedColorIndex == index
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
      });
    } else {
      print("Picker Date is null");
    }
  }

  Future<void> _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    if (pickedTime == null) {
      print("Time canceled");
    } else {
      // Convert the picked time to 24-hour format
      String formattedTime = _formatTime(pickedTime);

      if (isStartTime) {
        setState(() {
          _startTime = formattedTime;
          print("Start Time is true $_startTime");
        });
      } else {
        setState(() {
          _endTime = formattedTime;
          print("Start Time is false $_endTime");
        });
      }
    }
  }

  String _formatTime(TimeOfDay time) {
    // Format the time in 24-hour format
    final int hour = time.hourOfPeriod == 12 ? 0 : time.hour;
    final String formattedHour = hour < 10 ? '0$hour' : '$hour';
    final String formattedMinute =
        time.minute < 10 ? '0${time.minute}' : '${time.minute}';
    final String period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$formattedHour:$formattedMinute $period';
  }

  Future<TimeOfDay?> _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  void _validateData() {
    if (workoutType.isNotEmpty && _noteController.text.isNotEmpty) {
      final workoutPlan = Workout(
        workoutName: workoutType,
        workoutNote: _noteController.text,
        workoutIsCompleted: 0,
        workoutColor: _selectedColorIndex,
        workoutDate: DateFormat.yMd().format(_selectedDate),
        workoutStartTime: _startTime,
        workoutEndTime: _endTime,
        workoutRemind: _selectedRemind,
        workoutRepeat: _selectedRepeat,
      );
      widget.onSubmit(workoutPlan);
      Get.back();
    } else {
      Get.snackbar(
        "Required",
        "All fields are required!",
        backgroundColor: Colors.white,
        colorText: Colors.black54,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
    }
  }

  String? validate(String? value, String inputName) {
    if (value == null || value.isEmpty) {
      return "$inputName is required";
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}
