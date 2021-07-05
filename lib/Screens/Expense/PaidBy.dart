import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_buddy/ViewModels/ExpenseViewModel.dart';

class PaidBy extends StatelessWidget {
  final List buddies;
  final int totalAmount;

  const PaidBy({
    Key? key,
    required this.buddies,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [];

    return GetBuilder<ExpenseController>(
      init: ExpenseController(),
      builder: (expenseData) {

        var string = expenseData.getPaidBy().map((e) => e['email']).toList().toString().split('[').last.split(']').first;
        List amountList = expenseData.getPaidBy().map((e) => e['amount']).toList();

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
                                expenseData.addPaidBy([{
                                  'name' : buddies[index]['name'], 'email' : buddies[index]['email'],
                                  'amount' : totalAmount}]);
                                  
                              },
                            );
                          }
                        )
                      ),

                      ElevatedButton(
                        onPressed: (){
                          Get.back();
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
                                
                                if(amountList.length == buddies.length){
                                  controllers.add(TextEditingController(text: amountList[index].toString()));
                                }else{
                                  controllers.add(TextEditingController(text: 0.toString()));
                                }

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
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: SizedBox(
                                        width: 85,
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: controllers[index],
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

                                List<Map<String, dynamic>> paidByList = [];

                                amountData.setAmount(controllers);

                                for(int i =0 ; i< controllers.length ; i++){
                                  if(int.parse(controllers[i].text) > 0){
                                    paidByList.add({
                                      'name' : buddies[i]['name'],
                                      'email' : buddies[i]['email'],
                                      'amount' : int.parse(controllers[i].text)
                                    });
                                  }
                                }
                                var result = amountData.getAmount();

                                if(result == totalAmount){

                                  expenseData.addPaidBy(
                                    paidByList
                                  );
                                  Get.back();

                                }
                                if(result < totalAmount){

                                  Get.dialog(
                                    SimpleDialog(
                                      contentPadding: EdgeInsets.all(15),
                                      title: Text('Whoops'),
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
                                      title: Text('Whoops'),
                                      children:[
                                        Text('The per person amounts don''t add up to the total amount($totalAmount). You are over by ${result - totalAmount}'),
                                      ] 
                                    )
                                  );
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