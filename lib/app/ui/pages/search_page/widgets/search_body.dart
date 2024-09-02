// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'search_result.dart';
import 'search_text_field.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SearchTextField(),
          const SearchResult(),
          // const HistorySearch(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
