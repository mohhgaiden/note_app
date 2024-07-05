import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/core/controllers/note_controller.dart';
import 'package:note_app/res/dimens.dart';
import 'package:note_app/res/gaps.dart';
import 'package:note_app/res/styles.dart';
import 'package:note_app/ui/pages/add.dart';

class HomePage extends StatelessWidget {
  final notesController = Get.put(NoteController());
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 150,
          leading: const Row(children: [
            SizedBox(width: 16),
            Icon(Icons.event_note_outlined),
            Text(' Notepad++',style: TextStyle(fontWeight: FontWeight.normal,fontSize: Dimens.font_sp16))
          ]),
          actions: [
            IconButton(
              tooltip: 'Add',
              onPressed: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const AddNote()
                );
              },
              icon: Image.asset(
                'assets/images/add.png',
                width: 24.0,
                height: 24.0,
                color: null
              )
            )
          ]
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            if(notesController.noteList.isNotEmpty){
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: notesController.noteList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => AddNote(isUpdate: true,note: notesController.noteList[index])
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const <BoxShadow> [BoxShadow(color: Color(0x80DCE7FA), offset: Offset(0.0, 2.0), blurRadius: 8.0)] 
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Expanded(child: Text(notesController.noteList[index].title,maxLines: 1)),
                            Gaps.hGap8,
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context, 
                                  builder: (context) => AlertDialog(
                                    content: Text("Are You Sure want to delete this note '${notesController.noteList[index].title}' ?"),
                                    actions: [
                                      TextButton(
                                        onPressed: (){Navigator.pop(context);}, 
                                        child: const Text("non")
                                      ),
                                      TextButton(
                                        onPressed: ()async{await notesController.deleteNote(note: notesController.noteList[index]).then((value) => Navigator.pop(context));}, 
                                        child: const Text("Oui")
                                      )
                                    ]
                                  )
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(shape: BoxShape.circle,color: Theme.of(context).colorScheme.error),
                                child: const Icon(Icons.close,size: Dimens.font_sp14,color: Colors.white)
                              )
                            )
                          ]),
                          Gaps.vGap8,
                          Gaps.line,
                          Gaps.vGap8,
                          RichText(text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: Dimens.font_sp12),
                            children: [
                              const TextSpan(text: ''),
                              TextSpan(text: notesController.noteList[index].text, style: Theme.of(context).textTheme.titleSmall),
                            ]
                          )),
                          Gaps.vGap8,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(children: [
                                Image.asset('assets/images/icon_calendar.png', width: 14.0, height: 14.0),
                                Gaps.hGap4,
                                Text(
                                  notesController.noteList[index].date,
                                  style: TextStyles.textSize12,
                                ),
                              ]),
                            ],
                          ),
                        ]
                      )
                    ),
                  );
                }
              );
            }else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 1,
                    child: Image.asset(
                      'assets/images/empty.png',
                      width: 120,
                    )
                  ),
                  const SizedBox(width: double.infinity, height: Dimens.gap_dp16,),
                  Text(
                    'Note is Empty',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: Dimens.font_sp14),
                  )
                ]
              );
              //const StateLayout(type: StateType.order,hintText: 'Note is Empty');
            }
          })
        )
      )
    );
  }
}