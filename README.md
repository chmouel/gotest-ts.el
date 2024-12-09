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
functions and subtests (using the conventional `name` key for subtest) in your
test files.

<https://github.com/user-attachments/assets/d61732b0-68a6-4947-b79f-d87adc3a412a>

## Features

* Run test functions and subtests in .go files with Treesitter support.
* Automatic detection of test functions and subtests.
* Simple and intuitive interface for running tests.

## Installation

You need to have your go mode configured to use treesitter see this
[Article](https://robbmann.io/posts/emacs-treesit-auto/) for example for more
information on how to this.

You can install this using `use-package` and
[Melpa](https://melpa.org/#/gotest-ts) by adding the following to your Emacs
configuration:

```emacs
(use-package gotest-ts
  :bind
  ("<F2>" . gotest-ts-run-dwim))
```

or by manually cloning the repository and add it to your load-path.

## Usage

bind a key to the `gotest-ts-run-dwim` (`F2` if you have copied the
configuration above verbatim) position yourself in a subtest or a test
function and it will discover via treesitter and run the current function or
subtest with the [gotest](https://github.com/nlamirault/gotest.el) mode.

## Debugging the current test or subtest with [Dape](https://github.com/svaante/dape)

If you use Dape to debug your tests you can use this function:

```emacs
  (defun my-dape-go-test-at-point ()
    (interactive)
    (dape (dape--config-eval-1
           `(modes (go-ts-mode)
                   ensure dape-ensure-command
                   fn dape-config-autoport
                   command "dlv"
                   command-args ("dap" "--listen" "127.0.0.1::autoport")
                   command-cwd dape-cwd-fn
                   port :autoport
                   :type "debug"
                   :request "launch"
                   :mode "test"
                   :cwd dape-cwd-fn
                   :program (lambda () (concat "./" (file-relative-name default-directory (funcall dape-cwd-fn))))
                   :args (lambda ()
                           (when-let* ((test-name (gotest-ts-get-subtest-ts)))
                             (if test-name `["-test.run" ,test-name]
                               (error "No test selected")))))))))
```

Bind it to a key and it will run the current test or subtest with DAPE.

(do not forget to put a breakpoint somewhere in your code or you won't see much)

See the [DAPE](https://github.com/svaante/dape) package documentation for more
information about dape.

## Bug

When you have different structure inside a subtest that has a Name: it would
pick up the wrong one. You just need to place yourself in the right struct where
the name is.


## Thanks

This package is only a thin wrapper adding function to the excelent [gotest](https://github.com/nlamirault/gotest.el) package.

## Copyright

[Apache-2.0](./LICENSE)

## Authors

### Chmouel Boudjnah

* Fediverse - <[@chmouel@chmouel.com](https://fosstodon.org/@chmouel)>
* Twitter - <[@chmouel](https://twitter.com/chmouel)>
* Blog  - <[https://blog.chmouel.com](https://blog.chmouel.com)>
