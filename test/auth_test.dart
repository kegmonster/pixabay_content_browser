import 'package:flutter_test/flutter_test.dart';
import 'package:pixabay_content_browser/providers/authentication.dart';

void main(){

  Authentication auth = Authentication();

  group('test email validation', () {
    test('test valid emails', () {
      expect(null, auth.validateEmail('peter@microsoft.com'));
      expect(null, auth.validateEmail('steve.creek@mydomain.net'));
      expect(null, auth.validateEmail('bob__@xyz.com'));
      expect(null, auth.validateEmail('bob@[127.0.0.1]'));
      expect(null, auth.validateEmail('\"bob\"@[127.0.0.1]'));
    });
    test('test invalid emails', () {
      expect('Please enter a valid email', auth.validateEmail('email.@domain.com'));
      expect('Please enter a valid email', auth.validateEmail('email.domain.com'));
      expect('Please enter a valid email', auth.validateEmail('email@domain'));
    });
  });

  group('test password validation', () {
    test('test valid password', () {
      expect(null, auth.validatePassword('Aa11%\$cccc'));
      expect(null, auth.validatePassword('g\$jkKK44Q!'));
    });
    test('test invalid password', () {
      expect('Password too short', auth.validatePassword('Ab@1'));
      expect('At least one lowercase character', auth.validatePassword('AB@1AAAA'));
      expect('At least one uppercase character', auth.validatePassword('ab@1aaaa'));
      expect('At least one numeric character', auth.validatePassword('Ab@ababa'));
      expect('At least one special character', auth.validatePassword('Abs12345'));
    });
  });
}