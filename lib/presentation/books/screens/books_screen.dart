part of '../books.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen>
    with AutomaticKeepAliveClientMixin {
  final booksCtrl = BooksController.instance;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface.withValues(alpha: .1),
      body: SafeArea(
        child: BooksTabBarWidget(
          topPadding: 64.0,
          firstTabChild: AllBooksBuild(
            title: 'allBooks',
          ),
          secondTabChild:
              AllBooksBuild(title: 'myLibrary', isDownloadedBooks: true),
          thirdTabChild: AllBooksBuild(
            title: 'hadiths',
            isHadithsBooks: true,
          ),
          fourthTabChild: AllBooksBuild(
            title: 'tafsir',
            isTafsirBooks: true,
          ),
        ),
      ),
    );
  }
}
