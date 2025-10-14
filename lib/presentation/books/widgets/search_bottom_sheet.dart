part of '../books.dart';

void showSearchBottomSheet(BuildContext context,
    {void Function(String)? onSubmitted, bool? isInBook}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (sheetCtx) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetCtx).viewInsets.bottom,
        ),
        child: Material(
          color: context.theme.scaffoldBackgroundColor,
          child: SafeArea(
            top: false,
            child: FractionallySizedBox(
              heightFactor: 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'searchInBooks'.tr,
                            style:
                                context.theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        IconButton(
                          tooltip: MaterialLocalizations.of(sheetCtx)
                              .closeButtonTooltip,
                          onPressed: () => Navigator.of(sheetCtx).pop(),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  // محتوى البحث الحالي
                  Expanded(
                    child: SearchScreen(
                      onSubmitted: (value) => onSubmitted?.call(value),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
