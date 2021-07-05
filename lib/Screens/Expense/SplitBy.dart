import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_buddy/ViewModels/ExpenseViewModel.dart';

class SplitBy extends StatelessWidget {

  final List buddies;
  final int totalAmount;

  const SplitBy({
    Key? key,
    required this.buddies,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<TextEditingController> controllers = [];
    var amount;

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Split By')
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
                  child: Text('Split Equally'),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Split Unequally'),
                ),
              ),
            ]
          ),
          body: TabBarView(
            children: [
              GetBuilder<SplitByController>(
                init: SplitByController(),
                builder:(data){
                  controllers.clear();
                  return Column(
                    children: [
                      Column(
                        children: List.generate(
                          buddies.length, (index) {

                            amount = totalAmount/buddies.length;
                            controllers.add(TextEditingController(text: amount.toString() ));

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
                                      controller: controllers[index],
                                      readOnly: true,
                                      keyboardType: TextInputType.number,
                                    )),
                                ),
                              ],
                            );
                          } 
                        )
                      ),

                      ElevatedButton(
                        onPressed: (){

                          List result = [];

                          for(int i = 0; i< buddies.length; i++){
                            result.add({
                              'name' : buddies[i]['name'],
                              'email' : buddies[i]['email'],
                              'amount' : amount
                            });
                          }
                          data.setSplitBy(result);
                          data.setIsEqual(true);
                          Get.back();
                        }, 
                        child: Text('Save')
                      )
                    ],
                  );
                } 
              ),
              GetBuilder<SplitByController>(
                init: SplitByController(),
                builder: (data){

                  controllers.clear();
                  List amountList = data.getSplitBy().map((e) => e['amount']).toList();

                  return Column(
                    children: [
                      Column(
                        children: List.generate(
                          buddies.length, (index) {
                            
                            
                            if(buddies.length == amountList.length){
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
                                      controller: controllers[index],
                                      keyboardType: TextInputType.number,
                                    )),
                                ),
                              ],
                            );
                          } 
                        )
                      ),

                      GetBuilder<AmountSum>(
                        init: AmountSum(),
                        builder: (sumData){
                          return ElevatedButton(

                            onPressed: (){

                              sumData.setAmount(controllers);
                                
                              var result = sumData.getAmount();
                              List<Map<String,dynamic>> splitByList = [];

                              if(result == totalAmount){

                                for(int i = 0; i < buddies.length; i++){
                                  splitByList.add({
                                    'name' : buddies[i]['name'],
                                    'email' : buddies[i]['email'],
                                    'amount' : controllers[i].text
                                  });
                                }

                                data.setSplitBy(splitByList);
                                data.setIsEqual(false);
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
                            child: Text('Save')
                          );
                        } 
                      )
                    ],
                  );
                }
              ),
            ],
          )
        )
      ),
    );
  }
}

