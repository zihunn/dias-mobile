import 'package:DiAs/ui/screens/slki/detail_slki_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import '../../../bloc/slki/slki_bloc.dart';
import '../../../bloc/slki/slki_event.dart';
import '../../../bloc/slki/slki_state.dart';
import '../../widgets/cardsearch_widget.dart'; // Pastikan widget ini sesuai dengan kebutuhan

class SlkiScreen extends StatefulWidget {
  final String title;
  final bool isPremium;

  const SlkiScreen({
    super.key,
    required this.title,
    required this.isPremium,
  });

  @override
  State<SlkiScreen> createState() => _SlkiScreenState();
}

class _SlkiScreenState extends State<SlkiScreen> {
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
    BlocProvider.of<SlkiBloc>(context).add(FetchSlkiDataEvent(page: 1));

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
            BlocProvider.of<SlkiBloc>(context).state is SlkiLoadedState
                ? (BlocProvider.of<SlkiBloc>(context).state as SlkiLoadedState)
                    .currentPage
                : 1;
        BlocProvider.of<SlkiBloc>(context)
            .add(FetchNextPageSlkiEvent(nextPage: currentPage + 1));
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
      body: BlocBuilder<SlkiBloc, SlkiState>(
        builder: (context, state) {
          if (state is SlkiLoadingState && state is! SlkiLoadedState) {
            return Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset('assets/lotties/loading.json'),
              ),
            );
          }

          if (state is SlkiErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is SlkiLoadedState) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.slkiData.length,
              itemBuilder: (context, index) {
                if (index == state.slkiData.length) {
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

                final item = state.slkiData[index];
                final isClickable = widget.isPremium || index < 3;
                final color = _colors[index % _colors.length];

                return Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: GestureDetector(
                    onTap: () {
                      if (isClickable) {
                        // Aksi untuk item yang bisa diklik
                        print('slki');
                        Navigator.push(
                          context,
                          PageTransition(
                            child: DetailSlkiScreen(
                              idSlki: item.id!,
                            ),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      } else {
                        // Tampilkan snackbar atau modal
                        _showUpgradeModal(context);
                      }
                    },
                    child: Opacity(
                      opacity: isClickable ? 1.0 : 0.5,
                      child: CardSearch(
                        color: color,
                        title: item.nama ?? 'No Name',
                        subtitle: item.definisi ?? 'No Description',
                        code: item.kodeSlki?.kodeSlki ?? 'No Code',
                        category:
                            'No Category', // Kategori tidak ada di model SlkiItemData
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

  void _showUpgradeModal(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ayo upgrade ke premium untuk menikmati semua fitur!'),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
