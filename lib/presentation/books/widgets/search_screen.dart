part of '../books.dart';

class SearchScreen extends StatelessWidget {
  final void Function(String)? onSubmitted;
  final bool? isInBook;
  SearchScreen({super.key, this.onSubmitted, this.isInBook = false});

  final booksCtrl = BooksController.instance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .89,
      child: Column(
        children: [
          const Gap(16),
          TextFieldBarWidget(
            controller: booksCtrl.state.searchController,
            hintText: 'searchInBooks'.tr,
            fillColor:
                context.theme.colorScheme.onPrimary.withValues(alpha: .4),
            horizontalPadding: 32.0,
            onPressed: () {
              booksCtrl.state.searchController.clear();
              booksCtrl.state.searchResults.clear();
            },
            onChanged: null,
            onSubmitted: (value) {
              if (onSubmitted != null) {
                onSubmitted!(value);
              }
            },
          ),
          SearchBuild(),
        ],
      ),
    );
  }
}
