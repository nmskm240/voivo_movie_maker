// Flutter imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/project_assets.dart';

void main() {
  group('ProjectAsset', () {
    test('rejects an empty value', () {
      expect(
        () => ProjectAsset(name: '', kind: ProjectAssetKind.image),
        throwsArgumentError,
      );
    });

    test('renames in place', () {
      final asset = ProjectAsset(
        name: 'image.png',
        kind: ProjectAssetKind.image,
      );

      asset.rename('renamed.png');

      expect(asset.name, 'renamed.png');
    });
  });
}
