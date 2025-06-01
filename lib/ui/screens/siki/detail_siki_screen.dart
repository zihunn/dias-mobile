import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../bloc/detail_siki/detail_siki_bloc.dart';
import '../../../bloc/detail_siki/detail_siki_event.dart';
import '../../../bloc/detail_siki/detail_siki_state.dart';
import '../../../bloc/detail_slki/detail_slki_bloc.dart';
import '../../../bloc/detail_slki/detail_slki_event.dart';
import '../../../bloc/detail_slki/detail_slki_state.dart';
import '../../styles/app_colors.dart';
import '../../styles/app_text_style.dart';

class DetailSikiScreen extends StatefulWidget {
  final int idSiki;

  const DetailSikiScreen({
    super.key,
    required this.idSiki,
  });

  @override
  State<DetailSikiScreen> createState() => _DetailSikiScreenState();
}

class _DetailSikiScreenState extends State<DetailSikiScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<DetailSikiBloc>(context);

    bloc.add(FetchSikiDetailEvent(widget.idSiki.toString()));
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Detail SIKI",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: BlocBuilder<DetailSikiBloc, DetailSikiState>(
        builder: (context, state) {
          if (state is DetailSlkiLoadingState) {
            return  Center(child: SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset('assets/lotties/loading.json'),
              ),
            );
          } else if (state is DetailSikiLoadedState) {
            final data = state.detailSiki;
            List<List<String>> apiData = [
              data.data?.sikiKriteria
                      ?.map((item) => item.desc ?? '')
                      .toList() ??
                  [],
            ];
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.data?.sikiData?.siki?[0].nama ?? "",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data.data?.sikiData?.siki?[0].definisi ?? "",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                    child: ListView.builder(
                      itemCount: 1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        List<Map<String, dynamic>> items = [
                          {
                            'color': AppColors.primaryColor.withOpacity(0.2),
                            'text_color': Colors.blue,
                            'title': data.data?.sikiData?.kodeSiki ?? '-',
                          },
                        ];

                        var item = items[index];
                        return Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: item['color'],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              item['title'],
                              style: AppTextStyles.caption.copyWith(
                                color: item['text_color'],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      // Group the siki_kriteria data by category
                      final sikiKriteria = data.data?.sikiKriteria ?? [];
                      Map<String, List<String>> groupedData = {};

                      for (var item in sikiKriteria) {
                        // Check if the category already exists in the map
                        if (groupedData.containsKey(item.category)) {
                          // Add desc to the existing category
                          groupedData[item.category]?.add(item.desc ?? '');
                        } else {
                          // If the category doesn't exist, create a new list for it
                          groupedData[item.category!] = [item.desc ?? ''];
                        }
                      }

                      // Now, create the ExpansionTiles for each category
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            // Now create the ExpansionTile for each category
                            ...groupedData.entries.map((entry) {
                              return Card(
                                elevation: 0,
                                color: AppColors.primaryColor.withOpacity(0.5),
                                child: ExpansionTile(
                                  collapsedBackgroundColor: Colors.white,
                                  title: Text(
                                    entry.key, // Category name as title
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  childrenPadding: const EdgeInsets.all(15),
                                  shape: const Border.symmetric(
                                    vertical: BorderSide.none,
                                    horizontal: BorderSide.none,
                                  ),
                                  expandedAlignment: Alignment.topLeft,
                                  children: entry.value.map((desc) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            "- $desc", // Description for each item
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                            textAlign: TextAlign.left),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          } else if (state is DetailSikiErrorState) {
            return Center(child: Text(state.error));
          } else {
            return  Center(child: SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset('assets/lotties/loading.json'),
              ),
            );
          }
        },
      ),
    );
  }
}
