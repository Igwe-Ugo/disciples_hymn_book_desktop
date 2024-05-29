import 'package:provider/provider.dart';
import 'common/widget.dart';
import 'widget.dart';
import 'models/models.dart';
import 'package:flutter/material.dart';

class SearchHymnary extends SearchDelegate<DiscipleshipHymnaryModel> {
  final List<DiscipleshipHymnaryModel> allHymns;
  final Function(int) onSearchResultSelected;

  SearchHymnary({required this.onSearchResultSelected, required this.allHymns});

  List<DiscipleshipHymnaryModel> _performSearch(String query) {
    return allHymns.where((hymn) {
      return hymn.title.toLowerCase().contains(query.toLowerCase()) || hymn.id.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
        tooltip: "Clear",
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_left),
      onPressed: () {
        Navigator.of(context).pop();
      },
      tooltip: "Back",
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<DiscipleshipHymnaryModel> searchResults = _performSearch(query);
    return _buildResultList(context, searchResults);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<DiscipleshipHymnaryModel> searchResults = _performSearch(query);
    return _buildResultList(context, searchResults);
  }

  Widget _buildResultList(BuildContext context, List<DiscipleshipHymnaryModel> searchResults) {
    final fontSizeNotifier = Provider.of<FontSizeNotifier>(context);
    
    if (searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_outlined,
              size: 70.0,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 20.0,),
            Text(
              "Search Not Found!",
              style: TextStyle(
                fontSize: fontSizeNotifier.fontSize.toDouble(),
                fontWeight: FontWeight.w700
              ),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final hymn = searchResults[index];
        return HymnCard(
          hymns: hymn,
          fromHome: true,
          fontSize: fontSizeNotifier.fontSize.toDouble(),
          onTap: (value) {
            onSearchResultSelected(value);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
