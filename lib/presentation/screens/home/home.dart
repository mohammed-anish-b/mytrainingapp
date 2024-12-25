import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training/controllers/training_controller.dart';
import 'package:training/data/models/training.dart';
import 'package:training/presentation/common/app_theme.dart';
import 'package:training/presentation/common/ui_string.dart';
import 'package:training/presentation/screens/home/widgets/filter_modal.dart';
import 'package:training/presentation/screens/home/widgets/highlight_banner.dart';
import 'package:training/presentation/screens/home/widgets/training_card.dart';
import 'package:training/provider/training_provider.dart';

class Home extends StatefulWidget {
  static const menuIcon = Icons.menu;

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _trainingController = TrainingController.instance;
  final _pageController = PageController();

  final _pageAnimationDelayDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchHighlights();
      _fetchTrainings();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _sliverAppBar(),
          SliverToBoxAdapter(child: _filterButton()),
          _sliverListView(),
        ],
      ),
    );
  }

  Widget _sliverListView() {
    return Selector<TrainingProvider, List<Training>>(
      selector: (context, provider) => provider.trainings,
      builder: (context, trainings, child) {
        return SliverList.builder(
          itemCount: trainings.length,
          itemBuilder: (context, index) {
            final training = trainings[index];
            return TrainingCard(training: training);
          },
        );
      },
    );
  }

  Widget _filterButton() {
    return Container(
      color: AppTheme.white,
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: 120,
          child: InkWell(
            onTap: () {
              _onFilterButtonTapped();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.black.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.tune,
                    size: 14,
                    color: AppTheme.black.withOpacity(0.5),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    UIString.filters,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.black.withOpacity(0.5),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sliverAppBar() {
    return SliverAppBar(
      title: const Text(
        UIString.trainings,
        style: TextStyle(
          color: AppTheme.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(Home.menuIcon, color: AppTheme.white),
        ),
      ],
      floating: true,
      pinned: true,
      expandedHeight: 300,
      flexibleSpace: _sliverAppBarFlexibleSpaceContent(),
    );
  }

  Widget _sliverAppBarFlexibleSpaceContent() {
    return FlexibleSpaceBar(
      background: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.sunburntCyclops, AppTheme.white],
            stops: [.75, .25],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                UIString.highlights,
                style: TextStyle(
                  color: AppTheme.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _highlightPageView()
          ],
        ),
      ),
    );
  }

  Widget _highlightPageView() {
    return Selector<TrainingProvider, List<Training>>(
      selector: (context, provider) => provider.highlights,
      builder: (context, highlights, child) {
        return SizedBox(
          height: 160,
          child: Row(
            children: [
              _pageControlButton(
                icon: Icons.chevron_left,
                onTap: () {
                  _pageController.previousPage(
                      duration: _pageAnimationDelayDuration, curve: Curves.bounceIn);
                },
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: highlights.length,
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    final highlight = highlights[index];
                    return HighlightBanner(highlight: highlight);
                  },
                ),
              ),
              _pageControlButton(
                icon: Icons.chevron_right,
                onTap: () {
                  _pageController.nextPage(
                      duration: _pageAnimationDelayDuration, curve: Curves.bounceIn);
                },
              )
            ],
          ),
        );
      },
    );
  }

  Widget _pageControlButton({
    required IconData icon,
    required void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: AppTheme.black.withOpacity(0.3),
        height: 80,
        width: 25,
        child: Icon(icon, color: AppTheme.white),
      ),
    );
  }

  void _onFilterButtonTapped() async {
    final proivder = context.read<TrainingProvider>();
    final result = await showModalBottomSheet<bool?>(
      shape: const RoundedRectangleBorder(),
      context: context,
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: proivder,
          child: const FilterModal(),
        );
      },
    );
    _fetchTrainings(hasFilter: result == true);
  }

  _fetchHighlights() {
    final highlights = _trainingController.fetchHighlights();
    if (mounted) {
      context.read<TrainingProvider>().setHighlights(highlights);
    }
  }

  _fetchTrainings({bool hasFilter = false}) {
    final provider = context.read<TrainingProvider>();
    final selectedTrainerNames = provider.selectedTrainerNames;
    final selectedTrainingNames = provider.selectedTrainingNames;
    final selectedLocations = provider.selectedLocations;
    final trainings = _trainingController.fetchTrainings(
      hasFilter: hasFilter,
      locations: selectedLocations,
      trainerNames: selectedTrainerNames,
      trainingNames: selectedTrainingNames,
    );
    if (mounted) {
      context.read<TrainingProvider>().setTraining(trainings);
    }
  }
}
