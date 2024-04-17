import 'package:genius_bank/module/support_pages/data/support_pages.dart';

class SupportState {
  SupportPages? pages = SupportPages.getPages();
  Page? singlePage;


  SupportState({this.pages, this.singlePage});

  SupportState init() {
    return SupportState(
      pages: SupportPages.getPages()
    );
  }

  SupportState clone({SupportPages? pages, Page? singlePage}) {
    return SupportState(
      pages: pages ?? this.pages,
      singlePage: singlePage ?? this.singlePage
    );
  }
}
