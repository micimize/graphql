import 'package:graphql_parser/graphql_parser.dart';
import 'package:matcher/matcher.dart';
import 'package:test/test.dart';

Parser parse(String text) => new Parser(scan(text));

final Matcher throwsSyntaxError =
    throwsA(predicate((x) => x is SyntaxError, 'is a syntax error'));