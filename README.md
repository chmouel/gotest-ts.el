# GoTest Emacs Mode with Treesitter

A Emacs major mode for running Go tests with Treesitter support.

## Table of Contents

* [Introduction](#introduction)
* [Features](#features)
* [Installation](#installation)
* [Usage](#usage)
* [Authors](#authors)

## Introduction

This Emacs major mode provides a convenient way to run your Go tests using the
`gotest` library with Treesitter support. It automatically detects test
functions and subtests in your test files.

<https://github.com/user-attachments/assets/d61732b0-68a6-4947-b79f-d87adc3a412a>

## Features

* Run test functions and subtests in .go files with Treesitter support.
* Automatic detection of test functions and subtests.
* Simple and intuitive interface for running tests.

## Installation

You need to have your go mode configured to use treesitter see this
[Article](https://robbmann.io/posts/emacs-treesit-auto/) for example for more
information on how to this.

You can install this using `use-package`

```emacs
(use-package gotest-ts
  :preface
  (unless (package-installed-p 'gotest-ts)
    (package-vc-install "https://github.com/chmouel/gotest-ts.el"))
  :bind
  ("<F2>" . gotest-ts-run-dwim))
```

or by manually cloning the repository and add it to your load-path.

## Usage

bind a key to the `gotest-ts-run-dwim` position yourself in a subtest or a test
function and it will use [gotest](https://github.com/nlamirault/gotest.el) to
run the current function or subtest using treesitter.

## Copyright

[Apache-2.0](./LICENSE)

## Authors

### Chmouel Boudjnah

* Fediverse - <[@chmouel@chmouel.com](https://fosstodon.org/@chmouel)>
* Twitter - <[@chmouel](https://twitter.com/chmouel)>
* Blog  - <[https://blog.chmouel.com](https://blog.chmouel.com)>
