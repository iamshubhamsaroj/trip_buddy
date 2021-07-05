import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trip_buddy/Screens/Expense/PaidBy.dart';
import 'package:trip_buddy/Screens/Expense/SplitBy.dart';
import 'package:trip_buddy/Services/DataService.dart';
import 'package:trip_buddy/ViewModels/ExpenseViewModel.dart';

class AddExpense extends StatefulWidget {

  final List buddies;
  final String tripId;
  AddExpense({ Key? key, required this.buddies, required this.tripId }) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {

  var formKey = GlobalKey<FormState>();

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController paidByController = TextEditingController();
  final TextEditingController splitByController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController(text: DateTime.now().toString().split(' ').first);

  List paidByList = [];
  List splitByList = [];

  @override
  Widget build(BuildContext context) { 

    return Scaffold( 
      appBar: AppBar(
        title: Text('Add new expense'),
      ),

      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description'
                ),
                validator: (val){
                  if(val != null)
                  return val.isEmpty ? 'Please enter Expense Description' : null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Amount spent'
                ),
                validator: (val){
                  if(val != null)
                  return val.isEmpty ? 'Please enter Amount ' : null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: DateTimeField(

                format: DateFormat("yyyy-MM-dd"),
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                ),
                resetIcon: null,
          
                onShowPicker: (context, currentValue) {
                  return showDatePicker( 
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue! ,
                    lastDate: DateTime(2100));
                },

               
                onChanged: (val){
                  dateController.text = val.toString().split(' ').first;
                },
              ),
            ),

            GetBuilder<ExpenseController>(
              init: ExpenseController(),
              builder: (data){
                paidByController.text = data.getPaidBy().map((e) => e['name']).toList().toString().split('[').last.split(']').first;
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: paidByController,
                    decoration: InputDecoration(
                      labelText: 'Expense Paid By'
                    ),
                    readOnly: true,
                    onTap: (){
                      print('tap');
                      Get.to(PaidBy(buddies: widget.buddies,totalAmount: int.parse(amountController.text),))?.then((value) => {
                        setState((){
                          paidByController.text = data.getPaidBy().map((e) => e['name']).toList().toString().split('[').last.split(']').first;
                        }),
                        paidByList = data.getPaidBy()
                      });
                      
                      
                    },
                  ),
                );
              } 
            ),

            GetBuilder<SplitByController>(
              init: SplitByController(),
              builder:(data){

                bool isEqual = data.getIsEqual();

                isEqual ? splitByController.text = 'Equally' : splitByController.text = 'UnEqually';

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Expense Split By'
                    ),
                    controller: splitByController,
                    readOnly: true,
                    onTap: (){
                      Get.to(() => SplitBy(buddies: widget.buddies, totalAmount: int.parse(amountController.text)))!.then((value){
                        splitByList = data.getSplitBy();
                      }
                      );
                    },

                  ),
                );
              } 
            ),

            ElevatedButton(
              onPressed: (){
                if(formKey.currentState!.validate()){
                  DataService().addExpense(
                    widget.tripId, descriptionController.text,
                    amountController.text, dateController.text, 
                    paidByList, splitByList
                  );
                }
              }, 
              child: Text('Save Expense')
            )
          ],
        ),
      ),
    );
  }
}

