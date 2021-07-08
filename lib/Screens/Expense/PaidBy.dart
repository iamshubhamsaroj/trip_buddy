import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_buddy/ViewModels/AmountSumViewModel.dart';
import 'package:trip_buddy/ViewModels/PaidByViewModel.dart';

class PaidBy extends StatelessWidget {
  final List buddies;
  final double totalAmount;

  PaidBy({
    Key? key,
    required this.buddies,
    required this.totalAmount,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [];

    return GetBuilder<PaidByController>(
      init: PaidByController(),
      builder: (expenseData) {

        var string = expenseData.getPaidBy().map((e) => e['email']).toList().toString().split('[').last.split(']').first;

        return Scaffold(
          appBar: AppBar(
            title: Text('Paid By'),
          ),
          body: DefaultTabController(
            length: 2,
            child: Scaffold(
              
              appBar: TabBar(
                indicatorPadding: EdgeInsets.all(10),
                unselectedLabelColor: Colors.black,
                labelColor: Color(0xff0050bc),
                indicatorColor: Color(0xff0050bc),
                indicatorWeight: 3,
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Single'),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Multiple'),
                    ),
                  ),
                ]
              ),
              body: TabBarView(
                children: [
                  Column(
                    children: [
                      Column(
                        children: List.generate(
                          buddies.length, (index) {
                            return ListTile(
                              title: Text(buddies[index]['name']),
                              subtitle: Text(buddies[index]['email']),
                              trailing: string == buddies[index]['email']
                                ? Icon(Icons.check)
                                : null,
                              onTap: () {
                                expenseData.addPaidBy(
                                  [
                                    {
                                      'name' : buddies[index]['name'],
                                      'email' : buddies[index]['email'],
                                      'amount' : totalAmount
                                    }
                                  ]
                                );
                              },
                            );
                          }
                        )
                      ),

                      ElevatedButton(
                        onPressed: (){
                          Get.back(result: 'true');
                        }, 
                        child: Text('Save')
                      )
                    ],
                  ),
                  
                  GetBuilder<AmountSum>(
                    init: AmountSum(),
                    builder: (amountData) {
                      return Column(
                        children: [
                          Column(
                            children: List.generate(
                              buddies.length, (index) {
                                
                                controllers.add(TextEditingController(text: 0.toString()));

                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(buddies[index]['name']),
                                          Text(
                                            buddies[index]['email'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: SizedBox(
                                        width: 85,
                                        child: Form(
                                          key: formKey,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: controllers[index],
                                            validator: (val){

                                              if(val != null){
                                                if(val.isEmpty){
                                                  return 'Please enter Amount ';
                                                }
                                                if(!val.isNum){
                                                  return 'Please enter amount in numbers only';
                                                }
                                              }
                                            },
                                          ),
                                        )),
                                    ),
                                  ],
                                );
                              } 
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () { 

                                if(formKey.currentState!.validate()){
                                  List<Map<String, dynamic>> paidByList = [];

                                  amountData.setAmount(controllers);

                                  for(int i =0 ; i< controllers.length ; i++){

                                    if(double.parse(controllers[i].text) > 0){
                                      paidByList.add({
                                        'name' : buddies[i]['name'],
                                        'email' : buddies[i]['email'],
                                        'amount' : double.parse(controllers[i].text)
                                      });
                                    }
                                  }
                                  var result = amountData.getAmount();

                                  if(result == totalAmount){

                                    expenseData.addPaidBy(
                                      paidByList
                                    );
                                    Get.back(result: 'true');

                                  }
                                  if(result < totalAmount){

                                    Get.dialog(
                                      SimpleDialog(
                                        contentPadding: EdgeInsets.all(15),
                                        title: Center(child: Text('Whoops')),
                                        children:[
                                          Text('The per person amounts don''t add up to the total amount($totalAmount). You are under by ${totalAmount - result}'),
                                        ] 
                                      )
                                    );
                                  }
                                  if(result > totalAmount){

                                    Get.dialog(
                                      
                                      SimpleDialog(
                                        contentPadding: EdgeInsets.all(15),
                                        title: Center(child: Text('Whoops')),
                                        children:[
                                          Text('The per person amounts don''t add up to the total amount($totalAmount). You are over by ${result - totalAmount}'),
                                        ] 
                                      )
                                    );
                                  }
                                }
                              },
                              child: Text('Save'),
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                ],
              ),
            )
          ),
        );
      }
    );
  }
}