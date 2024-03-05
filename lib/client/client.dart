


import 'dart:convert';
import 'package:web_socket_channel/io.dart';

import '../controllers/mojo_controller.dart';

class MojoClint {
  IOWebSocketChannel? _channel;
  bool isConnected=false;

  connect(){
    _channel = IOWebSocketChannel.connect('ws://192.168.137.1:1245');

    // Listen for incoming messages from the server
    _channel!.stream.listen((message) {
      isConnected=true;
      List<String> data=message.toString().split("/");
      String path=data[0];

      if(path=="record-start"){
        // startRecord();
      }else if(path=="record-run"){
        //
        // List value=jsonDecode(data[1]);
        // List<TouchPoints> points=value.map((e) => TouchPoints.from(e)).toList();
        // print("sdfdsfsdf${points.length}");
        // runRecordings(points);

      }else if(path=="record-stop"){
        // stopRecord();
      } else if(path=="run-case"){
        MojoController.instance.runTestByCase(int.parse(data[1]));
      }
    });
  }

  sendMessage(path,data){
    _channel!.sink.add(path+jsonEncode(data));
  }
}