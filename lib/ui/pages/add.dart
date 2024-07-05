import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/core/controllers/note_controller.dart';
import 'package:note_app/res/dimens.dart';
import 'package:note_app/res/gaps.dart';
import 'package:note_app/ui/widgets/my_button.dart';
import '../../core/models/note_model.dart';
import '../widgets/my_text_field.dart';
import 'home.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, this.isUpdate = false, this.note});
  final bool isUpdate;
  final Note? note;
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController noteTextController = TextEditingController();
  final NoteController noteController = Get.find<NoteController>();

  @override
  void dispose() {
    titleTextController.dispose();
    noteTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.isUpdate) {
      titleTextController.text = widget.note!.title;
      noteTextController.text = widget.note!.text;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedContainer(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInCubic,
        child: Container(
          width: MediaQuery.of(context).size.width *0.75,
          height: MediaQuery.of(context).size.height *0.75,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0)
          ),
          child: Column(children: [
            Stack(children: [
              Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 0.0),
                child: Text(
                  !widget.isUpdate ?'Add':'Edit',
                  style: const TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: Dimens.font_sp16)
                )
              ),
              Positioned(
                top: 0.0,right: 0.0,
                child: Semantics(child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Image.asset('assets/images/icon_dialog_close.png', width: 16.0)
                  )
                ))
              )
            ]),
            Expanded(child: ListView(children: [
              MyTextField(
                controller: titleTextController,
                maxLines: 1,
                maxLength: 300,
                keyboardType: TextInputType.text,
                hintText: "Title",
              ),
              MyTextField(
                controller: noteTextController,
                maxLines: 10,
                maxLength: 300,
                keyboardType: TextInputType.text,
                hintText: "Type something...",
              )
            ])),
            MyButton(
              onPressed: () async{
                if (titleTextController.text.isNotEmpty && noteTextController.text.isNotEmpty && !widget.isUpdate){
                  await noteController.addNote(
                    note: Note(
                      text: noteTextController.text,
                      title: titleTextController.text,
                      date: DateTime.now().toString().substring(0,16),
                    )
                  );
                  Get.back();
                }else if(titleTextController.text.isNotEmpty && noteTextController.text.isNotEmpty && widget.isUpdate){
                  await noteController.updateNote(
                    note: Note(
                      id: widget.note!.id,
                      text: noteTextController.text,
                      title: titleTextController.text,
                      date: DateTime.now().toString().substring(0,16),
                    )
                  );
                  Get.offAll(() => HomePage());
                } else{ }
              },
              text: widget.isUpdate ? "Update" : "Save",
            ),
            Gaps.vGap12
          ])
        )
      )
    );
  }
}