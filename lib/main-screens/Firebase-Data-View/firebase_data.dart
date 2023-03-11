import 'package:blocs_patteren/Firebase-Blocs/Add-Data-Blocs/app_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Firebase-Blocs/Add-Data-Blocs/app_bloc.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

 Future<void> openNoteModal() async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (snapshot) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: "add title",
                      hintStyle: TextStyle(color: Colors.black45),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: "add description",
                      hintStyle: TextStyle(color: Colors.black45),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<ProductBloc>(context).add(
                      Create(nameController.text, int.tryParse(priceController.text))
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> openNoteModal(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
