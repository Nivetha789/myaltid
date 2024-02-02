import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myaltid/data/api.dart';
import 'package:myaltid/module/PhotoUploadModel.dart';
import 'package:myaltid/pages/congratulation.dart';
import 'package:myaltid/widget/progressloaded.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../module/AadhaarVerifyModule/FaceRegVerifyModel.dart';
import '../../reasuable/dialogbox.dart';
import '../../reasuable/theme.dart';
import '../../reasuable/background_screen.dart';
import '../../widget/sharedpreference.dart';


class FaceRegScreen extends StatefulWidget {
  var requestId;
  FaceRegScreen(this.requestId);

  @override
  State<FaceRegScreen> createState() => _FaceRegScreenState();
}

class _FaceRegScreenState extends State<FaceRegScreen>
    with SingleTickerProviderStateMixin {

  final _picker = ImagePicker();

  File? _capturedImage;

  bool checkCamera=false;
  String _capturedImagePath="";

  @override
  void initState() {
    super.initState();

    setValue();
  }

  setValue() async{
    await FaceCamera.initialize();
  // _checkPermission(context);
    var token = await SharedPreference().gettoken();
    print("token "+token);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        checkCamera = true;
      });

    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Backgroundscreen(
      ccontainerchild: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const  Column(
                children:  [
                  Text(
                    "",
                    style: TextStyle(
                        fontFamily: "Helvatica",
                        color: whitecolor,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        // fontStyle: FontStyle.italic,
                        fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: ClipOval(
                  child: Material(
                    color: blackcolor, // Button color
                    child: InkWell(
                      splashColor: Colors.red, // Splash color
                      onTap: () async{
                        if (await SharedPreference().getLogin() == "1") {
                          Dialogbox(context);
                        }else {
                          Fluttertoast.showToast(
                              msg: "Complete your stages to use this feature!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              textColor: Colors.white,
                              backgroundColor: buttoncolor,
                              timeInSecForIosWeb: 1);
                        }
                      },
                      child: const SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(
                          Icons.person,
                          color: buttoncolor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body:Container(
          child: Visibility(
            visible: checkCamera,
            child: Builder(builder: (context) {
              if (_capturedImage != null) {
                return Center(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.file(
                        _capturedImage!,
                        width: double.maxFinite,
                        fit: BoxFit.fitWidth,
                      ),
                      ElevatedButton(
                          onPressed: (){

                            final _capturedImage1 =  _capturedImage!.path.split(":");
                            _capturedImagePath=_capturedImage1[0];

                            getPhotoVerifyApi();
                            // Navigator.of(context).pop({_capturedImage!});
                          },
                          child: const Text(
                            'Submit',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ))
                    ],
                  ),
                );
              }
              return SmartFaceCamera(
                  autoCapture: false,
                  defaultCameraLens: CameraLens.front,
                  onCapture: (File? image) {
                    setState(() => _capturedImage = image);
                  },
                  onFaceDetected: (Face? face) {
                    //Do something
                  },
                  messageBuilder: (context, face) {
                    if (face == null) {
                      return _message('Place your face in the camera');
                    }
                    if (!face.wellPositioned) {
                      return _message('Center your face in the square');
                    }
                    return const SizedBox.shrink();
                  });
            }),
          ),
        )
         ),
    );
  }

  //photo verify
  getPhotoVerifyApi() async {
    // try {
    ProgressDialog().showLoaderDialog(context);
    Dio dio = new Dio();

    var token = await SharedPreference().gettoken();
    print("tokentoken " + token.toString());

    // List<String> splitedFile = _capturedImage!.path.toString()
    //     .split(
    //     ":");
    // print("split11111 " + splitedFile.toString());
    // List<String> split0 = splitedFile[0].toString().split(
    //     "{");
    // print("split00 " + split0.toString());
    // List<String> split1 = split0[1].toString().split(
    //     "}");
    // List<String> split2 = split1[0].toString().split("'");
    // print("split2222 " + split2[0].toString());

    String fileName = _capturedImage!.path
        .split('/')
        .last;

    print("fileName " + fileName);

    FormData formData = FormData.fromMap({
      "face_match":
      await MultipartFile.fromFile(_capturedImage!.path, filename: fileName),
    });

    // Map<String, dynamic> formData = {
    //   "face_match":
    //   await MultipartFile.fromFile(_capturedImage!.path, filename: fileName),
    // };

    print("face_matchParam " +formData.boundary);
    print("face_matchParam " + formData.length.toString());
    final response =
    await dio.post(ApiProvider.uploadPhoto,
        options: Options(
          // contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Accept': "application/json",
            // 'Accept': '*/*',
            // "Content-Type": "multipart/form-data; boundary="+formData.boundary,
            //
            // Headers.contentLengthHeader: formData.length,
            // "Host": '*',
            "Authorization": "Bearer "+ token}),
      // data: FormData.fromMap(formData),
      data: formData,
    );

    print("face_match " + response.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.toString());
      PhotoUploadModel photoUploadModel =
      PhotoUploadModel.fromJson(map);

      if (photoUploadModel.status == 1) {
        if (photoUploadModel.message == "Success.") {
          print("photoup "+photoUploadModel.message!);
          ProgressDialog().dismissDialog(context);
          getFaceRegApi();
            } else {
          ProgressDialog().dismissDialog(context);

              Fluttertoast.showToast(
                  msg: "Your photo verification failed. Please try again...",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  textColor: Colors.white,
                  backgroundColor: buttoncolor,
                  timeInSecForIosWeb: 1);

              Navigator.pop(context);
            }

      } else {
        ProgressDialog().dismissDialog(context);
        Fluttertoast.showToast(
            msg: photoUploadModel.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white,
            backgroundColor: buttoncolor,
            timeInSecForIosWeb: 1);

        Navigator.pop(context);
      }
    } else {
      ProgressDialog().dismissDialog(context);
      Fluttertoast.showToast(
          msg: "Bad Network Connection try again..",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: buttoncolor,
          timeInSecForIosWeb: 1);

      Navigator.pop(context);
    }
    // }catch (e) {
    //   ProgressDialog().dismissDialog(context);
    //   Fluttertoast.showToast(
    //       msg: "Bad Network Connection try again..",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       textColor: Colors.white,
    //       backgroundColor: buttoncolor,
    //       timeInSecForIosWeb: 1);
    // }
  }

  //face reg
  getFaceRegApi() async {
    ProgressDialog().showLoaderDialog(context);
    Dio dio = new Dio();

    var token = await SharedPreference().gettoken();
    print("tokeneeee "+token);
    var parameters = {"c_request_id": widget.requestId};
    print("requestIDDD "+parameters.toString());
    dio.options.contentType = Headers.formUrlEncodedContentType;
    final response =
    await dio.post(ApiProvider.faceRegApi,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer "+ token},
        ),
        data: parameters);

    print("faceRegApi "+response.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.toString());
      FaceRegVerifyModel faceRegVerifyModel =
      FaceRegVerifyModel.fromJson(map);

      if (faceRegVerifyModel.status == 1) {
        ProgressDialog().dismissDialog(context);
        Fluttertoast.showToast(
            msg: faceRegVerifyModel.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white,
            backgroundColor:buttoncolor,
            timeInSecForIosWeb: 1);
        await SharedPreference().setLogin("1");
        await SharedPreference().setKycStatus("1");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Congratulations()),
        );
      } else {
        ProgressDialog().dismissDialog(context);
        Fluttertoast.showToast(
            msg: faceRegVerifyModel.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white,
            backgroundColor:buttoncolor,
            timeInSecForIosWeb: 1);
        await SharedPreference().setKycStatus("0");
        Navigator.pop(context);
      }
    } else {
      ProgressDialog().dismissDialog(context);
      Fluttertoast.showToast(
          msg: "Bad Network Connection try again..",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: buttoncolor,
          timeInSecForIosWeb: 1);
    }
  }

  Widget _message(String msg) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
    child: Text(msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
  );
}
