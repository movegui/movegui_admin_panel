import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

class CustomDropDown<M extends Model, S extends ModelService<M>>
    extends StatefulWidget {
  const CustomDropDown({
    super.key,
    required this.service,
    required this.onChanged, 
    required this.title,
  });

  final S service;
  final ValueChanged<M> onChanged;
  final String title;

  @override
  State<CustomDropDown<M, S>> createState() => CustomDropDownState<M, S>();
}

class CustomDropDownState<M extends Model, S extends ModelService<M>>
    extends State<CustomDropDown<M, S>> {
  late S service;
  late List<M> myList = [];
  M? dropdownValue;

  @override
  void initState() {
    super.initState();
    service = widget.service; // ✅ CORRECT: Access service from widget
    initList();
  }

  Future<void> initList() async {
    final elems = await service.allModels();
    setState(() {
      myList = elems;
      if (myList.isNotEmpty) {
        dropdownValue = myList[0]; // initialize selected value here
        widget.onChanged(myList[0]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dropdownValue == null) {
      // Data not loaded yet
      return const CircularProgressIndicator();
    }

    return Container(
      color: AppColors.backgroundColor,
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(widget.title, style: TextStyle(color: AppColors.textColor, fontSize: 24),),
             // subtitle: Text('Subtitle goes here'),
            ),
          ),
          DropdownButton<M>(
            style: TextStyle(color: AppColors.textColor, fontSize: 18,),
            dropdownColor: AppColors.backgroundColor,
            iconEnabledColor: AppColors.textColor,
            focusColor: AppColors.textColor,
            value: dropdownValue,
            onChanged: (M? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
              widget.onChanged(newValue!);
            },
            items: myList.map<DropdownMenuItem<M>>((M model) {
              return DropdownMenuItem<M>(value: model, child: Text(model.name));
            }).toList(),
            
          ),
        ],
      ),
    );
  }
}
