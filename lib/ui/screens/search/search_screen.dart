import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../bloc/search/search_bloc.dart';
import '../../../bloc/search/search_event.dart';
import '../../../bloc/search/search_state.dart';
import 'package:DiAs/ui/widgets/cardsearch_widget.dart';
import 'package:DiAs/ui/widgets/search_bar_widget.dart';

import 'detail_search_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    final List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.cyan,
    ];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: SearchBarWidget(
                onSubmitted: (query) {
                  // Dispatch the event to BLoC when the search query is submitted
                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchQueryChanged(query));
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Lottie.asset('assets/lotties/loading.json'),
                      ),
                    );
                  } else if (state is SearchError) {
                    // Handle 403 error for limit exceeded
                    if (state.message
                        .contains("Limit pencarian Anda sudah habis")) {
                      // Delay the dialog to prevent the error
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _showLimitExceededDialog(context);
                      });
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.3,
                            child: Image.asset(
                              'assets/images/empty.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text(
                            'Silahkan coba lagi, periksa koneksi internet anda.',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                    );
                  } else if (state is SearchLoaded) {
                    // Directly access data from the Map
                    var data = state.data.data;

                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: ListView.builder(
                        itemCount: data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          var item = data?[index];
                          final color = colors[index % colors.length];
                          return Padding(
                            padding:
                                EdgeInsets.only(bottom: screenHeight * 0.02),
                            child: GestureDetector(
                              onTap: () {
                                // Navigate to the DetailSearchScreen and pass the selected item data
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailSearchScreen(
                                        id: item?.id.toString() ?? '0'),
                                  ),
                                );
                              },
                              child: CardSearch(
                                color: color,
                                title: item?.nama ?? 'Null',
                                subtitle: item?.definisi ?? 'Null',
                                code: item?.kode ?? 'Null',
                                category: item?.kategori ?? 'Null',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Lottie.asset('assets/lotties/empty.json'),
                      ),
                      const Text('Search something...'),
                    ],
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the limit exceeded dialog

  void _showLimitExceededDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      padding: const EdgeInsets.all(12),
      animType: AnimType.rightSlide,
      dialogType: DialogType.error,
      transitionAnimationDuration: const Duration(milliseconds: 500),
      title: 'Limit Pencarian Habis',
      desc:
          'Upgrade ke akun premium untuk mendapatkan akses pencarian tanpa batas.',
      titleTextStyle:
          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      descTextStyle: const TextStyle(fontSize: 16),
      btnOkOnPress: () {},
      btnOkColor: Colors.green,
    ).show(); // Menampilkan dialog
  }
}
