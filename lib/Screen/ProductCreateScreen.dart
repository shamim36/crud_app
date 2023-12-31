
import 'package:crud_app/RestAPI/RestClient.dart';
import 'package:crud_app/Style/Style.dart';
import 'package:flutter/material.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  Map<String, String> FormValues = {
    "Img": "",
    "ProductCode": "",
    "ProductName": "",
    "Qty": "",
    "TotalPrice": "",
    "UnitPrice": "",
  };
  bool Loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
      ),
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            child: Loading
                ? createCircularProgressIndicator()
                : createProductFillupForm(),
          ),
        ],
      ),
    );
  }

  Center createCircularProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  SingleChildScrollView createProductFillupForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              InputOnChange("Img", value);
            },
            decoration: AppInputDecoration('Product Image'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) {
              InputOnChange("ProductName", value);
            },
            decoration: AppInputDecoration('Product Name'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) {
              InputOnChange("ProductCode", value);
            },
            decoration: AppInputDecoration('Product Code'),
          ),
          const SizedBox(
            height: 20,
          ),
          AppDropDownStyle(
            _dropDownMenuItem(),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) {
              InputOnChange("UnitPrice", value);
            },
            decoration: AppInputDecoration('Unit Price'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) {
              InputOnChange("TotalPrice", value);
            },
            decoration: AppInputDecoration('Total Price'),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                FormOnSubmit();
              },
              child: SuccessButtonChild('Submit'),
              style: ApplyButtonStyle(),
            ),
          ),
        ],
      ),
    );
  }

  InputOnChange(key, value) {
    FormValues[key] = value;
    setState(() {});
  }

  FormOnSubmit() async {
    print(FormValues['img']);

    if (FormValues['img'] == '') {
      ErrorToast('Image Link Required !');
    } else if (FormValues['ProductName'] == '') {
      ErrorToast('Product Name Required !');
    } else if (FormValues['ProductCode'] == '') {
      ErrorToast('Product Code Required !');
    } else if (FormValues['Qty'] == '') {
      ErrorToast('Product quantity Required !');
    } else if (FormValues['TotalPrice'] == '') {
      ErrorToast('Total Price Required !');
    } else if (FormValues['UnitPrice'] == '') {
      ErrorToast('Unit Price Required !');
    } else {
      setState(() {
        Loading = !Loading;
      });
      await ProductCreateRequest(FormValues);
      setState(() {
        Loading = !Loading;
      });
    }
  }

  DropdownButton<String> _dropDownMenuItem() {
    return DropdownButton(
      value: FormValues['Qty'],
      items: const [
        DropdownMenuItem(
          value: '',
          child: Text('Select Qt'),
        ),
        DropdownMenuItem(
          value: '1 pcs',
          child: Text('1 pcs'),
        ),
        DropdownMenuItem(
          value: '2 pcs',
          child: Text('2 pcs'),
        ),
        DropdownMenuItem(
          value: '3 pcs',
          child: Text('3 pcs'),
        ),
        DropdownMenuItem(
          value: '4 pcs',
          child: Text('4 pcs'),
        ),
        DropdownMenuItem(
          value: '5 pcs',
          child: Text('5pcs'),
        ),
      ],
      onChanged: (value) {
        InputOnChange("Qty", value);
      },
      isExpanded: true,
      underline: Container(),
    );
  }
}