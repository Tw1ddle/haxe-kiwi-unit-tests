[![Project logo](https://github.com/Tw1ddle/haxe-kiwi-unit-tests/blob/master/screenshots/logo.png?raw=true "Haxe Kiwi - an implementation of the Cassowary constraint solving algorithm")](http://tw1ddle.github.io/haxe-kiwi-demo/)

[![Travis Unit Test Build Status](https://img.shields.io/travis/Tw1ddle/haxe-kiwi-unit-tests.svg?style=flat-square)](https://travis-ci.org/Tw1ddle/haxe-kiwi-unit-tests)

This is the unit test suite for [Haxe Kiwi](https://github.com/Tw1ddle/haxe-kiwi), a Haxe port of Kiwi, an implementation of the Cassowary constraint solving algorithm . The intent is to achieve good test coverage of the codebase, and to add regression tests for fixed bugs.

The tests are run through CI on [Travis](https://travis-ci.org/Tw1ddle/haxe-kiwi-unit-tests) using the Travis helper [Travix](https://github.com/back2dos/travix).

## Setup

```
haxelib install sure
haxelib install utest
```

## Usage

Open and build the FlashDevelop project in this directory to run the tests. Edit *run_tests_local.hxml* to change the platform to test locally.