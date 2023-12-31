import 'dart:convert';
import 'package:crud_app/Style/Style.dart';
import 'package:http/http.dart' as http;

Future<bool> ProductCreateRequest(FormValues) async {
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
  var PostBody = json.encode(FormValues);
  var PostHeader = {"Content-Type": "application/json"};

  var response = await http.post(URL, headers: PostHeader, body: PostBody);
  var ResultCode = response.statusCode;
  var ResultBody = jsonDecode(response.body);

  if (ResultCode == 200 && ResultBody["status"] == "success") {
    SuccessToast("Request Success!");
    return true;
  } else {
    ErrorToast("Request Failed! Try again.");
    return false;
  }
}

Future<List> ProductGridViewList() async {
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
  var PostHeader = {"Content-Type": "application/json"};

  var response = await http.get(
    URL,
    headers: PostHeader,
  );
  var ResultCode = response.statusCode;
  var ResultBody = jsonDecode(response.body);

  if (ResultCode == 200 && ResultBody["status"] == "success") {
    SuccessToast("Request Success!");
    return ResultBody["data"];
  } else {
    ErrorToast("Request Failed! Try again.");
    return [];
  }
}