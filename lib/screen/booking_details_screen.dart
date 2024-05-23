import 'package:eventmanagement/components/button_widget.dart';
import 'package:eventmanagement/helper/sizebox_ex.dart';
import 'package:eventmanagement/screen/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../model/response/event_response.dart';

class BookingDetailsScreen extends StatelessWidget {
 final  Event eventData;
  const BookingDetailsScreen({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    "http://172.21.0.42:8080${eventData.image}",
                  ),
                ),
              ),
              child: const SizedBox(
                // width: 344,
                // height: 297,
              ),
            ),

            30.sH,

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: const Color(0XFFFBE6DC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          eventData.eventTitle.toString(),
                          textAlign: TextAlign.start,
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: const Color(0xFF000000),
                          ),
                        ),
                      ),
                      5.sW,
                      Text("RS. ${eventData.price.toString()}",
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: const Color(0xFF5B41FF),
                        ),)
                    ],
                  ),
                  20.sH,
                  Text(
                    "Details",
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: const Color(0xFF5B41FF),
                    ),
                  ),
                  10.sH,
                  Text(eventData.details.toString()),
                  20.sH,
                  Text("Location and timings ",
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: const Color(0xFF5B41FF),
                    ),),
                  Text(eventData.location.toString(),),
                  5.sH,
                  Text(DateFormat('MMMM d HH MM').format(eventData.eventDate ?? DateTime.now())),
                  40.sH,
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: SignUpButtonWidget(
                        title: "Book Now",
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=> TicketScreen(eventData: eventData)));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
