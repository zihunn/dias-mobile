import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../bloc/detail_sdki/detail_sdki_bloc.dart';
import '../../../bloc/detail_sdki/detail_sdki_event.dart';
import '../../../bloc/detail_sdki/detail_sdki_state.dart';
import '../../styles/app_colors.dart';
import '../../styles/app_text_style.dart';

class DetailSdkiScreen extends StatefulWidget {
  final String idSdki;

  const DetailSdkiScreen({super.key, required this.idSdki});

  @override
  State<DetailSdkiScreen> createState() => _DetailSdkiScreenState();
}

class _DetailSdkiScreenState extends State<DetailSdkiScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<DetailSdkiBloc>(context);

    bloc.add(FetchSdkiDetailEvent(widget.idSdki));
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Detail SDKI",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: BlocBuilder<DetailSdkiBloc, DetailSdkiState>(
        builder: (context, state) {
          if (state is DetailSdkiLoadingState) {
            return  Center(child: SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset('assets/lotties/loading.json'),
              ),
            );
          } else if (state is DetailSdkiLoadedState) {
            final data = state.detailSdki;

            List<List<String>> apiData = [
              data.dataSdki?.penyebab
                      ?.map((item) => item.desc ?? '')
                      .toList() ??
                  [],
              data.dataSdki?.mayor?.map((item) => item.desc ?? '').toList() ??
                  [],
              data.dataSdki?.minor?.map((item) => item.desc ?? '').toList() ??
                  [],
              data.dataSdki?.kondisisTerkait
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
                    data.dataSdki?.nama ?? "",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data.dataSdki?.definisi ?? "",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        print(apiData);

                        List<Map<String, dynamic>> items = [
                          {
                            'color': AppColors.primaryColor.withOpacity(0.2),
                            'text_color': Colors.blue,
                            'title': data.dataSdki?.kode ??
                                'D.0001', // Mengambil kode dari API
                          },
                          {
                            'color': Colors.green.withOpacity(0.2),
                            'text_color': Colors.green,
                            'title': data.dataSdki?.kategori ??
                                'Fisiologis', // Mengambil kategori dari API
                          },
                          {
                            'color': Colors.purple.withOpacity(0.2),
                            'text_color': Colors.purple,
                            'title': data.dataSdki?.subkategori ??
                                'Respirasi', // Mengambil subkategori dari API
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
                    itemCount: apiData
                        .length, // Jumlah Cards sesuai dengan panjang apiData
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      // Data untuk setiap ExpansionTile, diambil dari apiData berdasarkan index
                      List<String> expansionTileData = apiData[index];
                      print(expansionTileData);

                      return Card(
                        elevation: 0,
                        color: AppColors.primaryColor.withOpacity(0.5),
                        child: ExpansionTile(
                          collapsedBackgroundColor: Colors.white,
                          title: Text(
                            index == 0
                                ? "Penyebab"
                                : index == 1
                                    ? "Gejala dan Tanda Mayor"
                                    : index == 2
                                        ? "Gejala dan Tanda Minor"
                                        : "Kondisis Terkait",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          childrenPadding: const EdgeInsets.all(15),
                          shape: const Border.symmetric(
                            vertical: BorderSide.none,
                            horizontal: BorderSide.none,
                          ),
                          expandedAlignment: Alignment.topLeft,
                          // Looping data dari API untuk setiap ExpansionTile

                          children: expansionTileData.map((item) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "- $item", // Anda bisa mengganti ini dengan data yang lebih spesifik
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.left),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (state is DetailSdkiErrorState) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}
