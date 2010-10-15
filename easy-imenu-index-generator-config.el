;;; easy-imenu-index-generator-config.el --- predefined configurations for `easy-imenu-index-generator.el'

;; Copyright (C) 2010 tm8st

;; Author: tm8st <http://twitter.com/tm8st>
;; Version: 0.1
;; Keywords: convenience, imenu, easy, config

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the

;; GNU General Public License for more details.

;; You should have received ba  copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.	If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; imenuのインデックス生成処理を書くのが億劫な場合に、
;; 適当なレベルのものを手軽に生成するための拡張の設定例です。

;; 現状、howm、unreal、scala用の設定があります。

;;; Code:

(require 'easy-imenu-index-generator)

(defvar easy-imenu-index-generator-howm
  (make-easy-imenu-index-generator-setting
   :alist
   `(
     ((caption . "[TODO] ")
      (regexp . "^[ \t]*\\[.+\\]\\+"))
     ((caption . "[MEMO] ")
      (regexp . "^= "))
     ((caption . "[GOTO] ")
      (regexp . ">>>"))
     ((caption . "[COME] ")
      (regexp . "<<<"))
     )
   :add-line-number-to-item t
   ))

(defvar easy-imenu-index-generator-scala
  (make-easy-imenu-index-generator-setting
   :alist
   `(
     ((caption . "[CLASS]  ")
      (regexp . "^[ \t]*\\(abstract \\)?\\(case \\)?class[ \t]+\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)"))
     ((caption . "[OBJECT] ")
      (regexp . "^[ \t]*object[ \t]+\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)"))
     ((caption . "[TRAIT]  ")
      (regexp . "^[ \t]*trait[ \t]+\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)"))
     ((caption . "[FUNC]   ")
      (regexp . "^[ \t]*\\(private \\)?\\(override \\)?\\(final \\)?\\(def \\)+\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)"))
     ((caption . "[VAL]    ")
      (regexp . "^[ \t]*\\(private \\)?\\var[ \t]"))
     ((caption . "[VAR]    ")
      (regexp . "^[ \t]*\\(private \\)?\\val[ \t]"))
     )
   :add-line-number-to-item t
   ))

(defvar easy-imenu-index-generator-unreal
    (make-easy-imenu-index-generator-setting
   :alist
   `(
     ((caption . "[State] ")
      (regexp . "^[ \t]*state\\(()\\)?[ \t]*"))
     ((caption . "[Var]   ")
      (regexp . "^[ \t]*var"))
     ((caption . "[Func]  ")
      (regexp . "^[ \t]*\\(static \\)?\\(public \\)?\\(private \\)?\\(protected \\)?\\(simulated \\)?\\(native \\)?\\(final \\)?\\(function\\)[ \t]+\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)"))
     ((caption . "[Event] ")
      (regexp . "^[ \t]*\\(simulated \\)?\\(event \\)\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)"))	
     ((caption . "[Classs]")
      (regexp . "^[ \t]*class[ \n\t]+\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)"))
     ;; (regexp . "^[ \t]*class[ \n\t]+\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)[ \t\n]*\\(:\\|{\\)"))
     ((caption . "[Strucs]")
      (regexp . "^[ \t]*struct[ \n\t]+\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)[ \t\n]*[{]"))
     )
   :add-line-number-to-item t
   ))

(provide 'easy-imenu-index-generator-config)
