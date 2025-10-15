part of '../books.dart';

class BooksBottomOptionsWidget extends StatelessWidget {
  final int bookNumber;
  final int index;
  final booksCtrl = BooksController.instance;

  BooksBottomOptionsWidget({
    super.key,
    required this.bookNumber,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: .7),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _isTashkilBuild(context),
          const ChangeThemeWidget(),
          const FontSizeDropDown(position: PopupMenuPosition.over),
          CustomButton(
            onPressed: () => showSearchBottomSheet(context,
                onSubmitted: (_) => booksCtrl.searchBooks(
                      booksCtrl.state.searchController.text,
                      bookNumber: bookNumber,
                    )),
            width: 40,
            isCustomSvgColor: true,
            svgColor: context.theme.colorScheme.secondary,
            backgroundColor: Colors.transparent,
            borderColor:
                context.theme.colorScheme.secondary.withValues(alpha: .2),
            svgPath: SvgPath.svgSearchIcon,
          ),
        ],
      ),
    );
  }

  Widget _isTashkilBuild(BuildContext context) {
    return GetX<BooksController>(
      builder: (booksCtrl) => CustomButton(
        width: 40,
        isCustomSvgColor: true,
        svgPath: SvgPath.svgTashkil,
        verticalPadding: 6.0,
        svgColor: booksCtrl.state.isTashkil.value
            ? context.theme.colorScheme.secondary
            : context.theme.colorScheme.secondary.withValues(alpha: .2),
        backgroundColor: Colors.transparent,
        borderColor: context.theme.colorScheme.secondary.withValues(alpha: .2),
        onPressed: () => booksCtrl.isTashkilOnTap(),
      ),
    );
  }
}
