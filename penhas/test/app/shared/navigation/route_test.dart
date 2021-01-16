import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/shared/navigation/route.dart';

void main() {

  group('Route', () {
    test('no argument route', () {
      Route actual = Route('/aroute');
      expect(actual.args, null);
      expect(actual.path, '/aroute');
    });

    test('single argument route', () {
      Route actual = Route('/aroute?arg=val');
      expect(actual.args, {"arg": "val"});
      expect(actual.path, '/aroute');
    });

    test('repeated arguments route', () {
      Route actual = Route('/aroute?arg=val&arg=other');
      expect(actual.args, {"arg": "other"});
      expect(actual.path, '/aroute');
    });


    test('two arguments route', () {
      Route actual = Route('/aroute?arg=val&second=arg');
      expect(actual.args, {"arg": "val", "second": "arg"});
      expect(actual.path, '/aroute');
    });
  });
}
