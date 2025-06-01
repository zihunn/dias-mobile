import 'package:DiAs/ui/screens/siki/detail_siki_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import '../../../bloc/siki/siki_bloc.dart';
import '../../../bloc/siki/siki_event.dart';
import '../../../bloc/siki/siki_state.dart';
import '../../widgets/cardsearch_widget.dart'; // Pastikan widget ini sesuai dengan kebutuhan

class SikiScreen extends StatefulWidget {
  final String title;
  final bool isPremium;

  const SikiScreen({
    super.key,
    required this.title,
    required this.isPremium,
  });

  @override
  State<SikiScreen> createState() => _SikiScreenState();
}

class _SikiScreenState extends State<SikiScreen> {
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
    BlocProvider.of<SikiBloc>(context).add(FetchSikiDataEvent(page: 1));

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
            BlocProvider.of<SikiBloc>(context).state is SikiLoadedState
                ? (BlocProvider.of<SikiBloc>(context).state as SikiLoadedState)
                    .currentPage
                : 1;
        BlocProvider.of<SikiBloc>(context)
            .add(FetchNextPageSikiEvent(nextPage: currentPage + 1));
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
      body: BlocBuilder<SikiBloc, SikiState>(
        builder: (context, state) {
          if (state is SikiLoadingState && state is! SikiLoadedState) {
            return Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset('assets/lotties/loading.json'),
              ),
            );
          }

          if (state is SikiErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is SikiLoadedState) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.sikiData.length,
              itemBuilder: (context, index) {
                if (index == state.sikiData.length) {
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

                final item = state.sikiData[index];
                final isClickable = widget.isPremium || index < 3;
                final color = _colors[index % _colors.length];

                return Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: GestureDetector(
                    onTap: () {
                      if (isClickable) {
                        // Aksi untuk item yang bisa diklik
                        Navigator.push(
                          context,
                          PageTransition(
                            child: DetailSikiScreen(
                              idSiki: item.id!,
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
                        code: item.kodeSiki?.kodeSiki ?? 'No Code',
                        category:
                            'No Category', // Kategori tidak ada di model SikiItemData
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
