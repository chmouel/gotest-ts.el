;;; gotest-ts.el --- gotest with treesitter -*- lexical-binding: t -*-

;; Author: Chmouel Boudjnah
;; Maintainer: Chmouel Boudjnah
;; Version: 0.1
;; Package-Requires: (gotest treesit)
;; Homepage: https://github.com/chmouel/gitest-ts.el
;; Keywords: testing


;; This file is not part of GNU Emacs

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.


;;; Commentary:

;; commentary
;; This mode provides Emacs functionality for running tests using GoTest
;; and Treesitter.
;;
;; It supports running test functions and subtests in .go files with Treesitter
;; support.
;;; Code:

;;; gotest-ts.el ends here
(defcustom gotest-ts-get-subtest-key "name"
  "The key used to identify a subtest in a struct.
Default is 'name'."
  :type 'string
  :group 'gotest-ts)


(defun gotest-ts-get-subtest-ts ()
  (let* ((struct-node (treesit-parent-until
                       (treesit-node-at (point))
                       (lambda (n)
                         (string-equal (treesit-node-type n) "literal_value"))))
         (funcname
          (substring-no-properties
           (treesit-node-text
            (treesit-node-child-by-field-name (treesit-defun-at-point) "name"))))
         (children (when struct-node
                     (treesit-node-children struct-node)))
         (subtest nil))
    (when struct-node
      (dolist (child children)
        (when (and (string-equal (treesit-node-type child) "keyed_element")
                   (string-match (concat "^" my-gotest-get-subtest-key ":\\s-*\"\\(.*\\)\"$") (treesit-node-text child)))
          (setq subtest
                (shell-quote-argument
                 (replace-regexp-in-string " " "_" (match-string-no-properties 1 (treesit-node-text child))))))))
    (concat (format "^%s%s$" funcname (if subtest (concat "/" subtest) "")))))

(defun gotest-ts-maybe-run()
  "Run the test function at point or the subtest at point if it is a subtest."
  (interactive)
  (when (string-match "_test\\.go" (buffer-file-name))
    (let ((gotest (my-gotest-get-subtest-ts)))
      (go-test--go-test (concat "-run " gotest " .")))))

(provide 'gotest-ts)
