import 'package:eventmanagement/config/api_response_config.dart';
import 'package:eventmanagement/helper/sizebox_ex.dart';
import 'package:eventmanagement/viewModel/common_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../model/response/my_booking_response.dart';

class MyBookingHistoryScreen extends StatelessWidget {
  const MyBookingHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    late CommonViewModel _provider;

    getData() async {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _provider = Provider.of<CommonViewModel>(context, listen: false);
        _provider.fetchMyBooking();
      });
    }

    return Consumer<CommonViewModel>(
      builder: (context, commonVm, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Bookings',
              style: GoogleFonts.getFont(
                'Raleway',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: const Color(0xFF1B153D),
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: SafeArea(
            child: RefreshIndicator(
                onRefresh: () => getData(),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: isLoading(commonVm.myBookingApiResponse) ?
                        const Center(child: CircularProgressIndicator()) :
                    commonVm.myBooking.bookings == null ||
                        commonVm.myBooking.bookings!.isEmpty ?
                        const Center(child: Text("No Booking Found")) :
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: commonVm.myBooking.bookings?.length,
                        itemBuilder: (context, index) {
                          var myBooking = commonVm.myBooking.bookings?[index];
                          return BookingHistoryCard(myBooking: myBooking!,);
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}


class BookingHistoryCard extends StatelessWidget {
  final Booking myBooking;

  const BookingHistoryCard({
    Key? key,
    required this.myBooking
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        // height: 120,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFDFF),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.fromLTRB(23, 29, 6, 29),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              myBooking.eventId?.eventTitle ?? "",
              style: GoogleFonts.getFont(
                'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: const Color(0xFF000000),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Rs  ${myBooking.eventId?.price}',
                style: GoogleFonts.getFont(
                  'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: const Color(0xFF78007A),
                ),
              ),
            ),
            10.sH,
            const Text("Details", style: TextStyle(fontWeight: FontWeight.w600),),
            5.sH,
            ReadMoreText(
              myBooking.eventId?.details ?? "",
              trimLines: 3,
              trimMode: TrimMode.Line,
              trimCollapsedText: ' Read more',
              trimExpandedText: ' Less',
            ),
          ],
        ),
      ),
    );
  }
}