import 'package:flutter_test/flutter_test.dart';
import 'package:pixabay_content_browser/providers/authentication.dart';

void main(){

  group('test email validation', () {
    test('test valid emails', () {
      Authentication auth = Authentication();
      expect('', auth.validateEmail('bob@xyz.com'));
    });
  });
}