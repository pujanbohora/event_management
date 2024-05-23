import 'package:eventmanagement/helper/sizebox_ex.dart';
import 'package:eventmanagement/screen/booking_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../model/response/event_response.dart';
import 'button_widget.dart';

class EventItemCardScreen extends StatelessWidget {
  final Event? eventData;
  const EventItemCardScreen({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.9),
        color: const Color(0xFFFBE6DC),
      ),
      child: SizedBox(
        width: 193,
        height: 261,
        child: Container(
          padding: const EdgeInsets.fromLTRB(6, 14, 0, 9),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "http://172.21.0.42:8080${eventData?.image}",
                      ),
                    ),
                  ),
                  child: const SizedBox(
                    width: 107,
                    height: 107,
                  ),
                ),
              ),
              10.sH,
              Text(
                eventData?.eventTitle ?? "",
                style: GoogleFonts.getFont(
                  'Raleway',
                  fontWeight: FontWeight.w600,
                  fontSize: 12.5,
                  height: 1.5,
                  color: const Color(0xFF5B41FF),
                ),
              ),
              _buildDualContentRow(title: eventData?.location ?? "", icon:Icons.place ),
              _buildDualContentRow(title: DateFormat('MMMM d HH MM').format(eventData?.eventDate ?? DateTime.now()) ?? "", icon: Icons.date_range),
              20.sH,// Date
              Align(
                alignment: Alignment.topCenter,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=> BookingDetailsScreen(eventData: eventData!,)));
                    // Navigator.pushNamed(context, "/bookingDetailsScreen");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFAC3029),
                      borderRadius: BorderRadius.circular(7.8),
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(14.5, 5, 14.6, 5),
                      child:
                      Text(
                        'BOOK NOW',
                        style: GoogleFonts.getFont(
                          'Raleway',
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
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

  Widget _buildDualContentRow({required String title, required IconData icon }){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20,),
        Text(
          title,
          style: GoogleFonts.getFont(
            'Raleway',
            fontWeight: FontWeight.w600,
            fontSize: 10,
            height: 1.9,
            color: const Color(0xFF000000),
          ),
        ),
      ],
    );
  }
}
