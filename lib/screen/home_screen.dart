import 'package:eventmanagement/helper/sizebox_ex.dart';
import 'package:eventmanagement/viewModel/common_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/event_item_card_widget.dart';
import '../config/api_response_config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Consumer<CommonViewModel>(
      builder: (context, commonVm, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFD4D4F7),
          body: SafeArea(
            child: SingleChildScrollView(
              child:
                Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  children: [
                    TextField(
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        hintText: 'Search Events',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.symmetric(vertical: 5)
                      ),
                      controller: searchController,
                      onSubmitted: (value) {
                        // Your onSubmitted logic here
                      },
                      onEditingComplete: () {
                        // Your onEditingComplete logic here
                      },
                    ),

                    10.sH,

                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            'assets/images/home_banner.png',
                          ),
                        ),
                      ),
                      child: const SizedBox(
                        // width: 344,
                        // height: 297,
                      ),
                    ),

                    10.sH,
                    isLoading(commonVm.eventDataApiResponse) ?
                    const Center(child: CircularProgressIndicator()) :
                    commonVm.eventData.events == null ||
                        commonVm.eventData.events!.isEmpty ?
                    const Center(child: Text("No Event Found")) :
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: commonVm.eventData.events?.length,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        final event = commonVm.eventData.events?[index];
                        return EventItemCardScreen(eventData: event);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        );
      }
    );
  }
}
