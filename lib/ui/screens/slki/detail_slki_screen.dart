import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../bloc/detail_slki/detail_slki_bloc.dart';
import '../../../bloc/detail_slki/detail_slki_event.dart';
import '../../../bloc/detail_slki/detail_slki_state.dart';
import '../../styles/app_colors.dart';
import '../../styles/app_text_style.dart';

class DetailSlkiScreen extends StatefulWidget {
  final int idSlki;

  const DetailSlkiScreen({
    super.key,
    required this.idSlki,
  });

  @override
  State<DetailSlkiScreen> createState() => _DetailSlkiScreenState();
}

class _DetailSlkiScreenState extends State<DetailSlkiScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<DetailSlkiBloc>(context);

    bloc.add(FetchSlkiDetailEvent(widget.idSlki.toString()));
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Detail SLKI",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: BlocBuilder<DetailSlkiBloc, DetailSlkiState>(
        builder: (context, state) {
          if (state is DetailSlkiLoadingState) {
            return  Center(child: SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset('assets/lotties/loading.json'),
              ),
            );
          } else if (state is DetailSlkiLoadedState) {
            final data = state.detailSlki;
            List<List<String>> apiData = [
              data.data?.slkiKriteria
                      ?.map((item) => item.desc ?? '')
                      .toList() ??
                  [],
              // data.dataSdki?.mayor?.map((item) => item.desc ?? '').toList() ??
              //     [],
              // data.dataSdki?.minor?.map((item) => item.desc ?? '').toList() ??
              //     [],
              // data.dataSdki?.kondisisTerkait
              //         ?.map((item) => item.desc ?? '')
              //         .toList() ??
              //     [],
            ];
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.data?.slkiData?.slki?[0].nama ?? "",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data.data?.slkiData?.slki?[0].definisi ?? "",
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
                            'title': data.data?.slkiData?.kodeSlki ??
                                'D.0001', // Mengambil kode dari API
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
                      List expansionTileData = apiData[index];
                      String? description = data.data?.slkiData?.slki?[0].desc;
                      print(expansionTileData);

                      return Card(
                        elevation: 0,
                        color: AppColors.primaryColor.withOpacity(0.5),
                        child: ExpansionTile(
                          collapsedBackgroundColor: Colors.white,
                          title: const Text(
                            "Kriteria",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          childrenPadding: const EdgeInsets.all(15),
                          shape: const Border.symmetric(
                            vertical: BorderSide.none,
                            horizontal: BorderSide.none,
                          ),
                          expandedAlignment: Alignment.topLeft,
                          children: [
                            if (description != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  description, // Menampilkan deskripsi
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ...expansionTileData.map((item) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Align(
                                  alignment: Alignment
                                      .centerLeft, // Explicitly align text to the left
                                  child: Text(
                                    "- $item",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign
                                        .left, // Align the text to the left
                                  ),
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
          } else if (state is DetailSlkiErrorState) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}
