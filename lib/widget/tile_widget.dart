import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TileWidget extends StatelessWidget {
  final String taskname;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final VoidCallback onEdited;
  const TileWidget(
      {super.key,
      required this.deleteFunction,
      required this.onChanged,
      required this.taskCompleted,
      required this.onEdited,
      required this.taskname});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.redAccent,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 75, 75, 75),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                    activeColor: const Color.fromARGB(255, 252, 64, 64),
                  ),
                  Text(
                    taskname,
                    style: TextStyle(
                        color: Colors.white,
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  )
                ],
              ),
              Material(
                shape: const CircleBorder(),
                color: Colors.transparent,
                clipBehavior: Clip.hardEdge,
                child: IconButton(
                    onPressed: onEdited,
                    splashColor: Colors.red,
                    focusColor: Colors.red,
                    icon: Icon(
                      Icons.edit,
                      color: Colors.redAccent,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
