import 'package:flutter/material.dart';
import 'package:lamie_middle_east_machine_task/util/validation/form_validation.dart';
import 'package:lamie_middle_east_machine_task/widgets/comman/text_feild_widget.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  final TextEditingController searchController = TextEditingController();

  get validator => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.maxFinite,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TextFieldWidget(
              hintText: 'Search messages',
              controller: searchController,
              icon: Icons.search,
              validator: (value) => Validations.emtyValidation(value)),
        ),
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => const SizedBox(
          height: 15,
        ),
        itemBuilder: (context, index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: 60,
            width: double.maxFinite,
            child: Card(
              borderOnForeground: false,
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        child: Icon(Icons.person),
                      )),
                  Expanded(flex: 9, child: Text('Anshif P'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}