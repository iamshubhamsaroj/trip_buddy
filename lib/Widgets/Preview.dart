import 'dart:io';
import 'package:flutter/material.dart';

class Preview extends StatelessWidget {

 final String fileName ;
 final String? filePath ;
 final String? fileUrl;

  Preview(this.fileName,this.filePath,this.fileUrl);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:Text(fileName),
        backgroundColor: Color(0xff5458e1)
      ),
      body: Container(
        child: Center(
          child: filePath != null 

          ? Padding(
            padding: const EdgeInsets.all(20),
            child: Image.file(File(filePath!),),
          )
          : Padding(
            padding: const EdgeInsets.all(20),
            child: Image.network(
              fileUrl!,scale: 0.5 ,
              loadingBuilder: (context, child, loadingProgress){
                return loadingProgress == null 
                ? child 
                : CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null 
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null
                );
              },
            ),
          )
        ),
      ),
    );
  }
}