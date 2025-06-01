// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:DiAs/ui/screens/search/detail_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../bloc/sdki/sdki_bloc.dart';
import '../../../bloc/sdki/sdki_event.dart';
import '../../../bloc/sdki/sdki_state.dart';
import '../../widgets/cardsearch_widget.dart';
import 'detail_sdki_screen.dart';

class SdkiScreen extends StatefulWidget {
  final String title;
  final bool isPremium;
  final bool isDetail;

  const SdkiScreen({
    super.key,
    required this.title,
    required this.isPremium,
    required this.isDetail,
  });

  @override
  State<SdkiScreen> createState() => _SdkiScreenState();
}

class _SdkiScreenState extends State<SdkiScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isFetching = false;

  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.cyan,
  ];

  @override
  void initState() {
    super.initState();
    // Trigger initial fetch
    BlocProvider.of<SdkiBloc>(context).add(FetchSdkiDataEvent(page: 1));

    // Add scroll listener to detect when the user scrolls to the bottom
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!_isFetching) {
        setState(() {
          _isFetching = true;
        });

        final currentPage =
            BlocProvider.of<SdkiBloc>(context).state is SdkiLoadedState
                ? (BlocProvider.of<SdkiBloc>(context).state as SdkiLoadedState)
                    .currentPage
                : 1;
        BlocProvider.of<SdkiBloc>(context)
            .add(FetchNextPageEvent(nextPage: currentPage + 1));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<SdkiBloc, SdkiState>(
        builder: (context, state) {
          if (state is SdkiLoadingState && (state is! SdkiLoadedState)) {
            return Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset('assets/lotties/loading.json'),
              ),
            );
          }

          if (state is SdkiErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is SdkiLoadedState) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.sdkiData.length + 1,
              itemBuilder: (context, index) {
                if (index == state.sdkiData.length) {
                  return _isFetching
                      ? Center(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Lottie.asset('assets/lotties/loading.json'),
                          ),
                        )
                      : const SizedBox.shrink();
                }

                final sdki = state.sdkiData[index];
                final isClickable = widget.isPremium || index < 3;
                final color = _colors[index % _colors.length];

                return Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: GestureDetector(
                    onTap: () {
                      if (isClickable) {
                        // Aksi untuk item yang bisa diklik
                        print('Item clicked!');
                        widget.isDetail
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailSearchScreen(
                                    id: sdki.id.toString(),
                                  ),
                                ),
                              )
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailSdkiScreen(
                                    idSdki: sdki.id.toString(),
                                  ),
                                ));
                      } else {
                        // Tampilkan snackbar atau modal
                        _showUpgradeModal(context);
                      }
                    },
                    child: Opacity(
                      opacity: isClickable ? 1.0 : 0.5,
                      child: CardSearch(
                        color: color,
                        title: sdki.nama ?? 'No Name',
                        subtitle: sdki.definisi ?? 'No Description',
                        code: sdki.kode ?? 'No Code',
                        category: sdki.kategori ?? 'No Category',
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('No Data Available'));
        },
      ),
    );
  }
}

void _showUpgradeModal(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Ayo upgrade ke premium untuk menikmati semua fitur!'),
      duration: Duration(seconds: 3),
    ),
  );
}
