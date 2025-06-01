// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../bloc/detail_search/detail_search_bloc.dart';
// import '../../../bloc/detail_search/detail_search_event.dart';
// import '../../../bloc/detail_search/detail_search_state.dart';
// import '../../../services/api_service.dart';
// import '../../styles/app_colors.dart';
// import '../../styles/app_text_style.dart';

// class DetailSearchScreen extends StatelessWidget {
//   final String id;

//   const DetailSearchScreen({super.key, required this.id});

//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         title: const Text(
//           "Detail",
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//       body: BlocProvider(
//         create: (context) =>
//             DetailSearchBloc(ApiService())..add(DetailSearchQueryChanged(id)),
//         child: BlocBuilder<DetailSearchBloc, DetailSearchState>(
//           builder: (context, state) {
//             if (state is DetailSearchLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is DetailSearchLoaded) {
//               var data = state.data;

//               List<String> listKode = [];

//               listKode.add(data.data?[0].kode?.replaceAll('*', '') ?? '');

//               data.data?[0].kodeSlki?.forEach((kodeSlki) {
//                 String cleanedKode =
//                     kodeSlki.kodeSlki?.replaceAll('*', '') ?? '';
//                 if (cleanedKode.isNotEmpty) {
//                   listKode.add(cleanedKode);
//                 }
//               });

//               data.data?[0].kodeSiki?.forEach((kodeSiki) {
//                 String cleanedKode =
//                     kodeSiki.kodeSiki?.replaceAll('*', '') ?? '';
//                 if (cleanedKode.isNotEmpty) {
//                   listKode.add(cleanedKode);
//                 }
//               });

//               List<Map<String, dynamic>> listDataExpansionTile = [];

//               var dataExpansion = data.data![0];

// // Cleaning and adding general data to listDataExpansionTile
//               listDataExpansionTile.add({
//                 "id": dataExpansion.id,
//                 "nama": dataExpansion.nama,
//                 "kode": dataExpansion.kode,
//                 "definisi": dataExpansion.definisi
//                     ?.replaceAll('*', ''), // Clean * from definisi
//                 "kategori": dataExpansion.kategori
//                     ?.replaceAll('*', ''), // Clean * from kategori
//                 "subkategori": dataExpansion.subkategori
//                     ?.replaceAll('*', ''), // Clean * from subkategori
//                 "penyebab": dataExpansion.penyebab
//                     ?.map((penyebab) => {
//                           "id": penyebab.id,
//                           "desc": penyebab.desc?.replaceAll(
//                               '*', ''), // Clean * from penyebab desc
//                         })
//                     .toList(),
//                 "mayor": dataExpansion.mayor
//                     ?.map((mayor) => {
//                           "id": mayor.id,
//                           "desc": mayor.desc
//                               ?.replaceAll('*', ''), // Clean * from mayor desc
//                         })
//                     .toList(),
//                 "minor": dataExpansion.minor
//                     ?.map((minor) => {
//                           "id": minor.id,
//                           "desc": minor.desc
//                               ?.replaceAll('*', ''), // Clean * from minor desc
//                         })
//                     .toList(),
//                 "kondisis_terkait": dataExpansion.kondisisTerkait
//                     ?.map((kondisi) => {
//                           "id": kondisi.id,
//                           "desc": kondisi.desc?.replaceAll(
//                               '*', ''), // Clean * from kondisi desc
//                         })
//                     .toList(),
//               });

// // Cleaning and adding data from the "slki" field for Expansion Tiles
//               dataExpansion.slki?.forEach((slki) {
//                 listDataExpansionTile.add({
//                   "id": slki.id,
//                   "nama":
//                       slki.nama?.replaceAll('*', ''), // Clean * from slki name
//                   "definisi":
//                       slki.desc?.replaceAll('*', ''), // Clean * from slki desc
//                   "kriteria": slki.kriteria
//                       ?.map((kriteria) => {
//                             "desc": kriteria.desc?.replaceAll(
//                                 '*', ''), // Clean * from kriteria desc
//                           })
//                       .toList(),
//                 });
//               });

//               dataExpansion.siki?.forEach((siki) {
//                 listDataExpansionTile.add({
//                   "id": siki.id,
//                   "nama":
//                       siki.nama?.replaceAll('*', ''), // Clean * from siki name
//                   "definisi": siki.definisi
//                       ?.replaceAll('*', ''), // Clean * from siki definisi
//                   "tindakan": siki.tindakan
//                       ?.map((tindakan) => {
//                             "category": tindakan.category?.replaceAll(
//                                 '*', ''), // Clean * from tindakan category
//                             "desc": tindakan.desc?.replaceAll(
//                                 '*', ''), // Clean * from tindakan desc
//                           })
//                       .toList(),
//                 });
//               });

//               return SingleChildScrollView(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       data.data?[0].nama ?? 'Null',
//                       style: const TextStyle(
//                           fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(
//                       height: 10.0,
//                     ),
//                     Text(
//                       data.data?[0].definisi ?? 'Null',
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                     const SizedBox(
//                       height: 10.0,
//                     ),
//                     SizedBox(
//                       height: screenHeight * 0.04,
//                       child: ListView.builder(
//                         itemCount: 3, // Set sesuai jumlah data yang ada
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: (context, index) {
//                           List<Map<String, dynamic>> items = [
//                             {
//                               'color': AppColors.primaryColor.withOpacity(0.2),
//                               'text_color': Colors.blue,
//                               'title': data.data?[0].kode,
//                             },
//                             {
//                               'color': Colors.green.withOpacity(0.2),
//                               'text_color': Colors.green,
//                               'title': data.data?[0].kategori,
//                             },
//                             {
//                               'color': Colors.purple.withOpacity(0.2),
//                               'text_color': Colors.purple,
//                               'title': data.data?[0].subkategori,
//                             },
//                           ];

//                           var item = items[index];
//                           return Container(
//                             padding: const EdgeInsets.all(5),
//                             margin: const EdgeInsets.only(right: 10),
//                             decoration: BoxDecoration(
//                               color: item['color'],
//                               borderRadius: const BorderRadius.all(
//                                 Radius.circular(5.0),
//                               ),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 item['title'],
//                                 style: AppTextStyles.caption.copyWith(
//                                   color: item['text_color'],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10.0,
//                     ),
//                     const SizedBox(height: 20),
//                     ListView.builder(
//                       itemCount: listDataExpansionTile.length,
//                       shrinkWrap: true,
//                       physics: const ScrollPhysics(),
//                       itemBuilder: (BuildContext context, int index) {
//                         var tileData = listDataExpansionTile[index];
//                         var title = listKode[index];
//                         return Card(
//                           elevation: 0,
//                           color: AppColors.primaryColor.withOpacity(0.5),
//                           child: ExpansionTile(
//                             collapsedBackgroundColor: Colors.white,
//                             title: Text(
//                               title, // Section title
//                               style: const TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             childrenPadding: const EdgeInsets.all(15),
//                             shape: const Border.symmetric(
//                               vertical: BorderSide.none,
//                               horizontal: BorderSide.none,
//                             ),
//                             expandedAlignment: Alignment.topLeft,
//                             children: [
//                               if (tileData["penyebab"] != null)
//                                 ...tileData["penyebab"].map<Widget>((penyebab) {
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 5.0),
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "- ${penyebab['desc']}",
//                                         style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w400),
//                                         textAlign: TextAlign.left,
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                               if (tileData["mayor"] != null)
//                                 ...tileData["mayor"].map<Widget>((mayor) {
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 5.0),
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "- ${mayor['desc']}",
//                                         style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w400),
//                                         textAlign: TextAlign.left,
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                               if (tileData["minor"] != null)
//                                 ...tileData["minor"].map<Widget>((minor) {
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 5.0),
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "- ${minor['desc']}",
//                                         style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w400),
//                                         textAlign: TextAlign.left,
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                               if (tileData["kondisis_terkait"] != null)
//                                 ...tileData["kondisis_terkait"]
//                                     .map<Widget>((kondisi) {
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 5.0),
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "- ${kondisi['desc']}",
//                                         style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w400),
//                                         textAlign: TextAlign.left,
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                               if (tileData["nama"] !=
//                                   null) // Memeriksa jika ada data definisi
//                                 Padding(
//                                   padding: const EdgeInsets.only(bottom: 8.0),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "${tileData["nama"]} - $title" ??
//                                               "", // Menampilkan definisi jika ada
//                                           style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.black87,
//                                           ),
//                                           textAlign: TextAlign.left,
//                                         ),
//                                         const SizedBox(
//                                           height: 10.0,
//                                         ),
//                                         Text(
//                                           "${tileData['definisi']}",
//                                           style: const TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w400),
//                                           textAlign: TextAlign.left,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               if (tileData["kriteria"] != null)
//                                 ...tileData["kriteria"].map<Widget>((kriteria) {
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 5.0),
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "- ${kriteria['desc']}",
//                                         style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w400),
//                                         textAlign: TextAlign.left,
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                               if (tileData["tindakan"] != null)
//                                 ...tileData["tindakan"].map<Widget>((tindakan) {
//                                   // Group tindakan by category first
//                                   Map<String, List<String>>
//                                       tindakanGroupedByCategory = {};

//                                   // Grouping tindakan by category
//                                   tileData["tindakan"].forEach((tindakan) {
//                                     String category =
//                                         tindakan["category"] ?? "Unknown";
//                                     String desc = tindakan["desc"] ?? "";

//                                     // If category does not exist in map, create a list for it
//                                     if (!tindakanGroupedByCategory
//                                         .containsKey(category)) {
//                                       tindakanGroupedByCategory[category] = [];
//                                     }
//                                     tindakanGroupedByCategory[category]
//                                         ?.add(desc);
//                                   });

//                                   return Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: tindakanGroupedByCategory.entries
//                                         .map((entry) {
//                                       String category = entry.key;
//                                       List<String> descriptions = entry.value;

//                                       return Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: 5.0),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               category, // Display category only once
//                                               style: const TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             const SizedBox(height: 5),
//                                             // Display the descriptions under the category
//                                             ...descriptions.map((desc) {
//                                               return Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10.0),
//                                                 child: Text(
//                                                   "- $desc", // Display description for the category
//                                                   style: const TextStyle(
//                                                       fontSize: 16,
//                                                       fontWeight:
//                                                           FontWeight.w400),
//                                                   textAlign: TextAlign.left,
//                                                 ),
//                                               );
//                                             }),
//                                           ],
//                                         ),
//                                       );
//                                     }).toList(),
//                                   );
//                                 }).toList(),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             } else if (state is DetailSearchError) {
//               return Center(child: Text(state.message));
//             } else {
//               return const Center(child: Text('Unknown state'));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../bloc/detail_search/detail_search_bloc.dart';
import '../../../bloc/detail_search/detail_search_event.dart';
import '../../../bloc/detail_search/detail_search_state.dart';
import '../../../services/api_service.dart';
import '../../styles/app_colors.dart';
import '../../styles/app_text_style.dart';

class DetailSearchScreen extends StatelessWidget {
  final String id;

  const DetailSearchScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Detail",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            DetailSearchBloc(ApiService())..add(DetailSearchQueryChanged(id)),
        child: BlocBuilder<DetailSearchBloc, DetailSearchState>(
          builder: (context, state) {
            if (state is DetailSearchLoading) {
              return  Center(child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Lottie.asset('assets/lotties/loading.json'),
                ),
              );
            } else if (state is DetailSearchLoaded) {
              var data = state.data;

              List<String> listKode = [];

              listKode.add(data.data?[0].kode?.replaceAll('*', '') ?? '');

              data.data?[0].kodeSlki?.forEach((kodeSlki) {
                String cleanedKode =
                    kodeSlki.kodeSlki?.replaceAll('*', '') ?? '';
                if (cleanedKode.isNotEmpty) {
                  listKode.add(cleanedKode);
                }
              });

              data.data?[0].kodeSiki?.forEach((kodeSiki) {
                String cleanedKode =
                    kodeSiki.kodeSiki?.replaceAll('*', '') ?? '';
                if (cleanedKode.isNotEmpty) {
                  listKode.add(cleanedKode);
                }
              });

              List<Map<String, dynamic>> listDataExpansionTile = [];

              var dataExpansion = data.data![0];

// Cleaning and adding general data to listDataExpansionTile
              listDataExpansionTile.add({
                "id": dataExpansion.id,
                "penyebab": dataExpansion.penyebab
                    ?.map((penyebab) => {
                          "id": penyebab.id,
                          "desc": penyebab.desc?.replaceAll(
                              '*', ''), // Clean * from penyebab desc
                        })
                    .toList(),
                "mayor": dataExpansion.mayor
                    ?.map((mayor) => {
                          "id": mayor.id,
                          "desc": mayor.desc
                              ?.replaceAll('*', ''), // Clean * from mayor desc
                        })
                    .toList(),
                "minor": dataExpansion.minor
                    ?.map((minor) => {
                          "id": minor.id,
                          "desc": minor.desc
                              ?.replaceAll('*', ''), // Clean * from minor desc
                        })
                    .toList(),
                "kondisis_terkait": dataExpansion.kondisisTerkait
                    ?.map((kondisi) => {
                          "id": kondisi.id,
                          "desc": kondisi.desc?.replaceAll(
                              '*', ''), // Clean * from kondisi desc
                        })
                    .toList(),
              });

// Cleaning and adding data from the "slki" field for Expansion Tiles
              dataExpansion.slki?.forEach((slki) {
                listDataExpansionTile.add({
                  "id": slki.id,
                  "nama":
                      slki.nama?.replaceAll('*', ''), // Clean * from slki name
                  "definisi":
                      slki.desc?.replaceAll('*', ''), // Clean * from slki desc
                  "kriteria": slki.kriteria
                      ?.map((kriteria) => {
                            "desc": kriteria.desc?.replaceAll(
                                '*', ''), // Clean * from kriteria desc
                          })
                      .toList(),
                });
              });

              dataExpansion.siki?.forEach((siki) {
                listDataExpansionTile.add({
                  "id": siki.id,
                  "nama":
                      siki.nama?.replaceAll('*', ''), // Clean * from siki name
                  "definisi": siki.definisi
                      ?.replaceAll('*', ''), // Clean * from siki definisi
                  "tindakan": siki.tindakan
                      ?.map((tindakan) => {
                            "category": tindakan.category?.replaceAll(
                                '*', ''), // Clean * from tindakan category
                            "desc": tindakan.desc?.replaceAll(
                                '*', ''), // Clean * from tindakan desc
                          })
                      .toList(),
                });
              });

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.data?[0].nama ?? 'Null',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      data.data?[0].definisi ?? 'Null',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                      child: ListView.builder(
                        itemCount: 3, // Set sesuai jumlah data yang ada
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          List<Map<String, dynamic>> items = [
                            {
                              'color': AppColors.primaryColor.withOpacity(0.2),
                              'text_color': Colors.blue,
                              'title': data.data?[0].kode,
                            },
                            {
                              'color': Colors.green.withOpacity(0.2),
                              'text_color': Colors.green,
                              'title': data.data?[0].kategori,
                            },
                            {
                              'color': Colors.purple.withOpacity(0.2),
                              'text_color': Colors.purple,
                              'title': data.data?[0].subkategori,
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
                      itemCount: listDataExpansionTile.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var tileData = listDataExpansionTile[index];
                        var title = listKode[index];

                        // Pastikan tindakan tidak null
                        List<Widget> tindakanWidgets = [];
                        if (tileData["tindakan"] != null) {
                          // Group tindakan by category first
                          Map<String, List<String>> tindakanGroupedByCategory =
                              {};

                          // Grouping tindakan by category
                          tileData["tindakan"].forEach((tindakan) {
                            String category = tindakan["category"] ?? "Unknown";
                            String desc = tindakan["desc"] ?? "";
                            // If category does not exist in map, create a list for it
                            if (!tindakanGroupedByCategory
                                .containsKey(category)) {
                              tindakanGroupedByCategory[category] = [];
                            }
                            tindakanGroupedByCategory[category]?.add(desc);
                          });

                          // Display grouped tindakan data
                          tindakanWidgets.add(
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Display tileData['nama'] - $title only once, above all categories
                                  Text(
                                    "${tileData['nama']} - $title", // Displayed only once
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),

                                  Text(
                                    "${tileData['definisi']}", // Display description for the category
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  // Loop over the grouped categories and descriptions
                                  ...tindakanGroupedByCategory.entries
                                      .map((entry) {
                                    String category = entry.key;
                                    List<String> descriptions = entry.value;

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Display category only once for each group
                                          Text(
                                            category,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 5),
                                          // Display descriptions for the category
                                          ...descriptions.map((desc) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Text(
                                                "- $desc", // Display description for the category
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                textAlign: TextAlign.left,
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          );
                        }

                        // Grouping and displaying data for penyebab, mayor, minor, and kondisi_terkait
                        List<Widget> additionalWidgets = [];

                        // Group and display penyebab
                        if (tileData["penyebab"] != null) {
                          Map<String, List<String>> penyebabGroupedByCategory =
                              {};
                          tileData["penyebab"].forEach((penyebab) {
                            String category =
                                "Penyebab"; // All are in "Penyebab" category
                            String desc = penyebab["desc"] ?? "";

                            if (!penyebabGroupedByCategory
                                .containsKey(category)) {
                              penyebabGroupedByCategory[category] = [];
                            }
                            penyebabGroupedByCategory[category]?.add(desc);
                          });

                          // Display grouped penyebab
                          additionalWidgets.addAll(
                              penyebabGroupedByCategory.entries.map((entry) {
                            String category = entry.key;
                            List<String> descriptions = entry.value;

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  ...descriptions.map((desc) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "- $desc",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.left,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            );
                          }).toList());
                        }

                        // Group and display mayor
                        if (tileData["mayor"] != null) {
                          Map<String, List<String>> mayorGroupedByCategory = {};
                          tileData["mayor"].forEach((mayor) {
                            String category =
                                "Gejala dan Tanda Mayor"; // Changed category name
                            String desc = mayor["desc"] ?? "";

                            if (!mayorGroupedByCategory.containsKey(category)) {
                              mayorGroupedByCategory[category] = [];
                            }
                            mayorGroupedByCategory[category]?.add(desc);
                          });

                          // Display grouped mayor
                          additionalWidgets.addAll(
                              mayorGroupedByCategory.entries.map((entry) {
                            String category = entry.key;
                            List<String> descriptions = entry.value;

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  ...descriptions.map((desc) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "- $desc",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.left,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            );
                          }).toList());
                        }

                        // Group and display minor
                        if (tileData["minor"] != null) {
                          Map<String, List<String>> minorGroupedByCategory = {};
                          tileData["minor"].forEach((minor) {
                            String category =
                                "Gejala dan Tanda Minor"; // Changed category name
                            String desc = minor["desc"] ?? "";

                            if (!minorGroupedByCategory.containsKey(category)) {
                              minorGroupedByCategory[category] = [];
                            }
                            minorGroupedByCategory[category]?.add(desc);
                          });

                          // Display grouped minor
                          additionalWidgets.addAll(
                              minorGroupedByCategory.entries.map((entry) {
                            String category = entry.key;
                            List<String> descriptions = entry.value;

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      category,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  ...descriptions.map((desc) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "- $desc",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            );
                          }).toList());
                        }

                        // Group and display kondisi_terkait
                        if (tileData["kondisis_terkait"] != null) {
                          Map<String, List<String>> kondisiGroupedByCategory =
                              {};
                          tileData["kondisis_terkait"].forEach((kondisi) {
                            String category =
                                "Kondisi Terkait"; // All are in "Kondisi Terkait" category
                            String desc = kondisi["desc"] ?? "";

                            if (!kondisiGroupedByCategory
                                .containsKey(category)) {
                              kondisiGroupedByCategory[category] = [];
                            }
                            kondisiGroupedByCategory[category]?.add(desc);
                          });

                          // Display grouped kondisi_terkait
                          additionalWidgets.addAll(
                              kondisiGroupedByCategory.entries.map((entry) {
                            String category = entry.key;
                            List<String> descriptions = entry.value;

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      category,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  ...descriptions.map((desc) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "- $desc",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            );
                          }).toList());
                        }

                        return Card(
                          elevation: 0,
                          color: AppColors.primaryColor.withOpacity(0.5),
                          child: ExpansionTile(
                            collapsedBackgroundColor: Colors.white,
                            title: Text(
                              title, // Section title
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            childrenPadding: const EdgeInsets.all(15),
                            shape: const Border.symmetric(
                              vertical: BorderSide.none,
                              horizontal: BorderSide.none,
                            ),
                            expandedAlignment: Alignment.topLeft,
                            children: [
                              // Display additional widgets for penyebab, mayor, minor, and kondisi_terkait
                              ...additionalWidgets,
                              if (tileData["kriteria"] != null)
                                Column(
                                  children: [
                                    Text(
                                      tileData[
                                          "definisi"], // Menampilkan deskripsi
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    ...tileData["kriteria"]
                                        .map<Widget>((kriteria) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "- ${kriteria['desc']}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                              // Display tindakan widgets
                              if (tindakanWidgets.isNotEmpty)
                                ...tindakanWidgets,
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            } else if (state is DetailSearchError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
