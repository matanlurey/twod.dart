check: get format analyze tests

get:
	dart pub get

format:
	dart format . --set-exit-if-changed

analyze:
	dart analyze --fatal-infos

tests:
	dart run coverage:test_with_coverage

serve:
	dart pub global activate webdev
	dart pub global run webdev serve --auto refresh

build:
	dart pub global activate webdev
	dart pub global run webdev build 
	wc -c "build/main.dart.js"
