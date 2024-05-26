import 'dart:convert';

import 'package:eventmanagement/helper/sizebox_ex.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

import '../api/repositories/user_repository.dart';
import '../components/button_widget.dart';
import '../helper/custom_loader.dart';
import '../model/response/event_response.dart';

class TicketScreen extends StatefulWidget {
  final Event eventData;
  const TicketScreen({super.key, required this.eventData});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {

  int quantity = 1;

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.fromLTRB(15, 12, 15, 44.4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: const Color(0xFFFBE6DC),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'My Bookings',
                      style: GoogleFonts.getFont(
                        'Raleway',
                        fontWeight: FontWeight.w700,
                        fontSize: 15.7,
                        height: 1.2,
                        letterSpacing: -0.2,
                        color: const Color(0xFF1B153D),
                      ),
                    ),
                  ),
                  20.sH,
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFDFF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.fromLTRB(23, 29, 6, 29),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.eventData.eventTitle.toString(),
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: const Color(0xFF000000),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Rs  ${widget.eventData.price.toString()}',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: const Color(0xFF78007A),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFFFE6FF),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.add, size: 25,),
                                onPressed: _incrementQuantity,),
                              5.sW,
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Text(
                                  '$quantity',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ),
                              5.sW,
                              IconButton(
                                icon: const Icon(Icons.remove, size: 25,),
                                onPressed: _decrementQuantity,),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.sH,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.9),
                      color: const Color(0xFFFEFEFE),
                    ),
                    child: Container(
                      width: 111.9,
                      height: 68.8,
                      padding: const EdgeInsets.fromLTRB(0, 19.1, 3, 13.3),
                      child:
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/khalti.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  20.sH,
                  SignUpButtonWidget(
                    title: "PAY NOW",
                    onPressed: () async{
                      try{
                        customLoadStart();
                        String data = jsonEncode({
                          "eventId": widget.eventData.id.toString(),
                          "ticketQuantity": quantity,
                            "isPaid": true
                        });
                        print("DATA::::$data");
                        final res = await UserRepository().addBooking(data);

                        if (res.success == true) {
                          toastification.show(
                              context: context,
                              icon: Icon(Icons.check_circle, color: Colors.green,),
                              title: Text(res.message.toString()),
                              autoCloseDuration: const Duration(seconds: 2),
                              showProgressBar: false
                          );

                          if(context.mounted){
                            Navigator.pushNamed(context, "/homeScreen");
                            // Navigator.of(context).popUntil((route) => route.isFirst);
                            // Navigator.
                          }
                        } else {
                          toastification.show(
                              context: context,
                              icon: Icon(Icons.warning, color: Colors.red,),
                              title: Text(res.message.toString()),
                              autoCloseDuration: const Duration(seconds: 2),
                              showProgressBar: false
                          );
                        }

                      } on Exception catch (e) {
                        toastification.show(
                            context: context,
                            icon: Icon(Icons.warning, color: Colors.red,),
                            title: Text(e.toString()),
                            autoCloseDuration: const Duration(seconds: 2),
                            showProgressBar: false
                        );

                      }finally {
                        customLoadStop();

                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
