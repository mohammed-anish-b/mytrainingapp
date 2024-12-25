import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training/controllers/training_controller.dart';
import 'package:training/presentation/common/app_theme.dart';
import 'package:training/presentation/common/ui_string.dart';
import 'package:training/provider/training_provider.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({
    super.key,
  });

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  final _trainingController = TrainingController.instance;

  @override
  void initState() {
    _fetchTrainerNames();
    _fetchTrainingNames();
    _fetchLocationNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(),
        const Divider(height: 1),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: FilterType.values.map((filterType) => _filterCard(filterType)).toList(),
                ),
              ),
              Expanded(
                flex: 6,
                child: _filterItemsView(),
              ),
            ],
          ),
        ),
        _filterButton()
      ],
    );
  }

  Widget _filterButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Navigator.pop(context, true),
            child: Container(
              color: AppTheme.sunburntCyclops,
              padding: const EdgeInsets.all(10),
              child: const Center(
                child: Text(
                  UIString.apply,
                  style: TextStyle(
                    color: AppTheme.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () => Navigator.pop(context, false),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Center(
                child: Text(
                  UIString.reset,
                  style: TextStyle(
                    color: AppTheme.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _filterItemsView() {
    return Selector<
        TrainingProvider,
        ({
          FilterType selectedFilterType,
          List<String> allLocations,
          List<String> allTrainingNames,
          List<String> allTrainerNames,
          List<String> selectedLocations,
          List<String> selectedTrainingNames,
          List<String> selectedTrainerNames
        })>(
      selector: (_, TrainingProvider provider) => (
        selectedFilterType: provider.selectedFilterType,
        allLocations: provider.allLocations,
        allTrainingNames: provider.allTrainingNames,
        allTrainerNames: provider.allTrainerNames,
        selectedLocations: provider.selectedLocations,
        selectedTrainingNames: provider.selectedTrainingNames,
        selectedTrainerNames: provider.selectedTrainerNames
      ),
      builder: (context, record, child) {
        final allItems = _getItemsForFilterType(
          record.selectedFilterType,
          record.allLocations,
          record.allTrainerNames,
          record.allTrainingNames,
        );

        if (allItems.isEmpty) return _comingSoon();

        var selectedItems = _getSelectedItemsForFilterType(
          record.selectedFilterType,
          record.selectedLocations,
          record.selectedTrainerNames,
          record.selectedTrainingNames,
        );

        return ListView.builder(
          itemCount: allItems.length,
          itemBuilder: (context, index) {
            final item = allItems[index];
            return _filterItem(
              selectedItems,
              item,
              context,
              (value) {
                final provider = context.read<TrainingProvider>();

                if (value == true) {
                  selectedItems.add(item);
                } else {
                  selectedItems.remove(item);
                }

                switch (record.selectedFilterType) {
                  case FilterType.location:
                    provider.setSelectedLocations(selectedItems);
                    break;
                  case FilterType.trainer:
                    provider.setSelectedTrainerNames(selectedItems);
                    break;
                  case FilterType.trainingName:
                    provider.setSelectedTrainingNames(selectedItems);
                    break;
                  case FilterType.sort:
                    break;
                }
              },
            );
          },
        );
      },
    );
  }

  Padding _filterItem(
    List<String> selectedItems,
    String item,
    BuildContext context,
    void Function(bool?)? onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Checkbox(value: selectedItems.contains(item), onChanged: onChanged),
          Expanded(
            child: Text(
              item,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppTheme.black,
                fontSize: 16,
                fontWeight: selectedItems.contains(item) ? FontWeight.w900 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Center _comingSoon() {
    return const Center(
      child: Text(
        UIString.comingSoon,
        style: TextStyle(
          color: AppTheme.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _filterCard(FilterType filterType) {
    return Selector<TrainingProvider, FilterType>(
      selector: (context, provider) => provider.selectedFilterType,
      builder: (context, selectedFilterType, child) {
        final isSelected = selectedFilterType == filterType;
        return InkWell(
          onTap: () => context.read<TrainingProvider>().setSelectedFilterType(filterType),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? null : AppTheme.black.withOpacity(0.1),
              border: Border(
                left: BorderSide(
                  color: isSelected ? AppTheme.sunburntCyclops : Colors.transparent,
                  width: 5,
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  filterType.label,
                  style: TextStyle(
                    color: AppTheme.black,
                    fontSize: 18,
                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            UIString.sortAndFilters,
            style: TextStyle(
              color: AppTheme.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
            onPressed: () => Navigator.pop(context, false),
            icon: Icon(Icons.close, color: AppTheme.black.withOpacity(0.5)))
      ],
    );
  }

  List<String> _getItemsForFilterType(
    FilterType filterType,
    List<String> allLocations,
    List<String> allTrainerNames,
    List<String> allTrainingNames,
  ) {
    switch (filterType) {
      case FilterType.location:
        return allLocations;
      case FilterType.trainer:
        return allTrainerNames;
      case FilterType.trainingName:
        return allTrainingNames;
      default:
        return [];
    }
  }

  List<String> _getSelectedItemsForFilterType(
    FilterType filterType,
    List<String> selectedLocations,
    List<String> selectedTrainerNames,
    List<String> selectedTrainingNames,
  ) {
    switch (filterType) {
      case FilterType.location:
        return [...selectedLocations];
      case FilterType.trainer:
        return [...selectedTrainerNames];
      case FilterType.trainingName:
        return [...selectedTrainingNames];
      default:
        return [];
    }
  }

  void _fetchTrainerNames() {
    final result = _trainingController.fetchTrainerNames();
    context.read<TrainingProvider>().setAllTrainerNames(result);
  }

  void _fetchTrainingNames() {
    final result = _trainingController.fetchTrainingNames();
    context.read<TrainingProvider>().setAllTrainingNames(result);
  }

  void _fetchLocationNames() {
    final result = _trainingController.fetchLocationNames();
    context.read<TrainingProvider>().setAllLocations(result);
  }
}

enum FilterType {
  sort(label: UIString.sortBy),
  location(label: UIString.location),
  trainingName(label: UIString.trainingName),
  trainer(label: UIString.trainer);

  final String label;

  const FilterType({required this.label});
}
