import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trip_buddy/Screens/Expense/PaidBy.dart';
import 'package:trip_buddy/Screens/Expense/SplitBy.dart';
import 'package:trip_buddy/Services/DataService.dart';
import 'package:trip_buddy/ViewModels/ExpenseViewModel.dart';
import 'package:trip_buddy/ViewModels/PaidByViewModel.dart';
import 'package:trip_buddy/ViewModels/SplitByViewModel.dart';
import 'package:trip_buddy/Widgets/AlertWidget.dart';
import 'package:trip_buddy/Widgets/Preview.dart';
import 'package:trip_buddy/Widgets/UploadingDialog.dart';

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
  late List<String> billList;


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

            GetBuilder<PaidByController>(
              init: PaidByController(),
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
                      Get.to(() => PaidBy(buddies: widget.buddies,totalAmount: int.parse(amountController.text),))?.then((value) => {

                        if(value != null){
                          
                          setState((){
                            paidByController.text = data.getPaidBy().map((e) => e['name']).toList().toString().split('[').last.split(']').first;
                          }),

                          paidByList = data.getPaidBy()
                        },

                        if(value == null){
                          paidByController.text = widget.buddies[0]['name'],
                          paidByList = [
                            {
                              'name' : widget.buddies[0]['name'],
                              'email' : widget.buddies[0]['email'],
                              'amount' : int.parse(amountController.text)
                            }
                          ]
                        }
                        
                        
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

                        if(value != null){
                          splitByList = data.getSplitBy();
                        }

                        if(value == null){

                          List result  = [];

                          for(int i = 0; i< widget.buddies.length; i++){
                            result.add({
                              'name' : widget.buddies[i]['name'],
                              'email' : widget.buddies[i]['email'],
                              'amount' : int.parse(amountController.text)/widget.buddies.length
                            });
                          }

                          splitByList = result;
                        }
                      }
                      );
                    },

                  ),
                );
              } 
            ),

            GetBuilder<ExpenseViewModel>(
              init: ExpenseViewModel(),
              builder: (data) {

                billList = data.getBillList();

                Future filePicker() async {

                  List<String?> overSizedFiles = [];

                  try{
                  
                    FilePickerResult? imageFiles = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true);

                      if(imageFiles != null){

                        if(imageFiles.count <= 5){
                          for(int i = 0; i < imageFiles.count; i++){
                
                            if(imageFiles.files[i].size > 10000000){
                              overSizedFiles.add(imageFiles.files[i].name); 
                            } 
                            else { 
                              data.setBillList(imageFiles.files[i].path);
                            }
                          }
                        }
                      }
                    
                  }catch(e){
                    alertWidget('Storage access permission is denied, please allow it in the settings');
                  }
                }

                return Column(
                  children: [
                    ListTile(
                      title: Text('Add a bill'),
                      leading: Icon(Icons.receipt),
                      onTap: () => filePicker(),
                    ),
            
                    billList.length > 0 

                      ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container( child: selectedFiles(billList),),
                      ) 
                      : Container(),
                  ],
                );
              }
            ),
              

            ElevatedButton(
              onPressed: (){

                if(formKey.currentState!.validate()){

                  uploadingDialog('Uploading...');
                  
                  DataService().addExpense(
                    widget.tripId, descriptionController.text,
                    int.parse(amountController.text), dateController.text, 
                    paidByList, splitByList,billList
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

  

  Widget selectedFiles(List fileList){

    return Column(
      children: List.generate(
        fileList.length,(index){

          double size = num.parse((File(fileList[index]).lengthSync() / 1000).toStringAsFixed(1)).toDouble() ;
          String sizeType;

          if(size > 1000){
            size = num.parse((size / 1000).toStringAsFixed(1)).toDouble(); 
            sizeType = 'MB';
          } 
          else{ 
            sizeType = 'kB';
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(30, 2, 30, 2), 
            child: Card(
              elevation: 5, 
              child: ListTile(  
                leading: Icon(Icons.image),
                title: Text('Bill $index'),
                subtitle: Text('$size $sizeType'),
                trailing: InkWell(
                  child: Icon(Icons.close),
                  onTap: (){
                    setState(() {
                      fileList.removeAt(index);
                    });
                  },
                ), 

                onTap: () => Get.to(() =>  Preview('Bill ${index + 1}', fileList[index],null))
              ),
            )
          );
        }
      )
    ); 
  }
}

