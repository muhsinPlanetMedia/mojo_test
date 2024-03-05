import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../client/client.dart';
import '../models/test_case_model.dart';
import 'package:flutter_test/flutter_test.dart';

class MojoController{
  // Declare an instance variable similar to WidgetsBinding.instance
  static final MojoController instance = MojoController._instants();
  final MojoClint _mojoClint=MojoClint();
  final List<TestCaseModel> _testCases=[];

  // Private constructor to enforce singleton pattern
  MojoController._instants(){
    if(!_mojoClint.isConnected){
      _mojoClint.connect();
    }
  }

  addTest(String title,{String cases="",required Function function,required int caseId}){
    final testCase=TestCaseModel( title: title, cases:cases,function: function, id: caseId);
    _testCases.add(testCase);
    _mojoClint.sendMessage("addTestCase/", testCase.toMap());
  }

  addLog({required int caseId,required String log,required String status}){
    final logs=LogModel(caseId: caseId,message: log,status: status,);
    _mojoClint.sendMessage("logs/", logs.toMap());
  }

  runTestByCase(int casesId){
    for(TestCaseModel test in _testCases){
      if(test.id==casesId){
        test.function!();
        break;
      }
    }
  }

  Finder findWidget(Key key){
    return find.byKey(key);
  }

  Finder findText(String data){
    return find.text(data);
  }


  Future tapDown(Offset offset) async {
    GestureBinding.instance
        .handlePointerEvent( PointerDownEvent(
      position: offset,
    ));
  }

  Future tapUp(Offset offset) async {
    GestureBinding.instance
        .handlePointerEvent( PointerUpEvent(
      position: offset,
    ));
  }


  Future tap(Offset offset) async {
    GestureBinding.instance
        .handlePointerEvent( PointerDownEvent(
      position: offset,
    ));

    GestureBinding.instance
        .handlePointerEvent( PointerUpEvent(
      position: offset,
    ));
  }

  Future tapWithFinder(Finder finder) async {
    final offset=await getGlobalPositionByKey(finder);
    GestureBinding.instance
        .handlePointerEvent( PointerDownEvent(
      position: offset,
    ));

    GestureBinding.instance
        .handlePointerEvent( PointerUpEvent(
      position: offset,
    ));
  }

  // Function to get the widget and its position using a key
  Future<Offset> getGlobalPositionByKey(Finder finder) async {
    final Iterable<Element> elements = finder.evaluate();
    final Element element = elements.single;

    // Get the global position using the RenderBox
    final RenderBox box = element.renderObject! as RenderBox;
    final Offset globalPosition = box.localToGlobal(Offset.zero);
    return globalPosition;
  }


 Future insertText(String text,[int? inputCount])async{
    await Future.delayed(const Duration(milliseconds: 750));
    WidgetsBinding.instance.defaultBinaryMessenger.
    handlePlatformMessage(
      SystemChannels.textInput.name,
      SystemChannels.textInput.codec.encodeMethodCall(
        MethodCall(
          'TextInputClient.updateEditingState',
          <dynamic>[
            inputCount??1,
            TextEditingValue(
                text: text,
                selection: TextSelection.collapsed(offset: text.length))
                .toJSON()
          ],
        ),
      ),
          (data) {},
    );

    FocusManager.instance.primaryFocus?.unfocus();

    await Future.delayed(const Duration(milliseconds: 750));
  }


}

extension MojoFinder on Finder{
  tap(){
    MojoController controller=MojoController.instance;
    controller.tapWithFinder(this);
  }

  insertText(String text){
    MojoController controller=MojoController.instance;
    controller.insertText(text);
  }
}