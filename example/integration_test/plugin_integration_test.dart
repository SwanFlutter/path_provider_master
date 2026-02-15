// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path_provider_master/path_provider_master.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getTemporaryDirectory test', (WidgetTester tester) async {
    final directory = await PathProviderMaster.getTemporaryDirectory();
    expect(directory, isNotNull);
    expect(directory!.path.isNotEmpty, true);
  });

  testWidgets('getApplicationDocumentsDirectory test', (
    WidgetTester tester,
  ) async {
    final directory =
        await PathProviderMaster.getApplicationDocumentsDirectory();
    expect(directory, isNotNull);
    expect(directory!.path.isNotEmpty, true);
  });

  testWidgets('getApplicationSupportDirectory test', (
    WidgetTester tester,
  ) async {
    final directory = await PathProviderMaster.getApplicationSupportDirectory();
    expect(directory, isNotNull);
    expect(directory!.path.isNotEmpty, true);
  });

  testWidgets('getDownloadsDirectory test', (WidgetTester tester) async {
    final directory = await PathProviderMaster.getDownloadsDirectory();
    // ممکن است در برخی پلتفرم‌ها null باشد
    if (directory != null) {
      expect(directory.path.isNotEmpty, true);
    }
  });

  testWidgets('getPublicPicturesDirectory test', (WidgetTester tester) async {
    final directory = await PathProviderMaster.getPublicPicturesDirectory();
    // ممکن است در برخی پلتفرم‌ها null باشد
    if (directory != null) {
      expect(directory.path.isNotEmpty, true);
    }
  });

  testWidgets('getPublicVideosDirectory test', (WidgetTester tester) async {
    final directory = await PathProviderMaster.getPublicVideosDirectory();
    // ممکن است در برخی پلتفرم‌ها null باشد
    if (directory != null) {
      expect(directory.path.isNotEmpty, true);
    }
  });
}
