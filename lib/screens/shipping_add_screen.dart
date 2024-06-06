import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_example/constants.dart';
import 'package:shop_example/providers/shipping_add_provider.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  var address1 = TextEditingController();
  var address2 = TextEditingController();
  var city = TextEditingController();
  var state = TextEditingController();
  var country = TextEditingController();
  var pincode = TextEditingController();
  @override
  void initState() {
    super.initState();
    final shipadd =
        Provider.of<ShippingAddProvider>(context, listen: false).shippingAdd;
    address1.text = shipadd['add1'];
    address2.text = shipadd['add2'];
    city.text = shipadd['city'];
    state.text = shipadd['state'];
    country.text = shipadd['country'];
    pincode.text = shipadd['pincode'];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShippingAddProvider>(
      builder: (context, shippingprovider, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: kcontentColor,
          title: const Text(
            "Shipping Address",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          leadingWidth: 60,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Ionicons.chevron_back),
            ),
          ),
        ),
        body: SafeArea(
          minimum: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('Current Address:'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(shippingprovider.shippingAdd['add1']),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(shippingprovider.shippingAdd['add2']),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(shippingprovider.shippingAdd['city']),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(shippingprovider.shippingAdd['state'] +
                    ", " +
                    shippingprovider.shippingAdd['country'] +
                    ", " +
                    shippingprovider.shippingAdd['pincode']),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: address1,
                    decoration: InputDecoration(
             
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        label: Text('Address Line 1'))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: address2,
                    decoration: InputDecoration(
            
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        label: Text('Address Line 2'))),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                            controller: city,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                label: Text('City'))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                            controller: state,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                label: Text('State'))),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                            controller: country,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                label: Text('Country'))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                            controller: pincode,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                label: Text('Pincode'))),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (address1.text.isNotEmpty &&
                          address2.text.isNotEmpty &&
                          city.text.isNotEmpty &&
                          state.text.isNotEmpty &&
                          pincode.text.isNotEmpty &&
                          country.text.isNotEmpty) {
                        await shippingprovider.updateAddress(
                          address1.text,
                          address2.text,
                          city.text,
                          state.text,
                          country.text,
                          pincode.text,

                          // _photo?.path ?? '', // Provide a default value if _photo is null
                        );
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Ionicons.save_outline),
                    label: Text('Save Changes'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kprimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
