;;; easy-imenu-index-generator.el --- easy implement imenu-create-index-function.

;; Copyright (C) 2010 tm8st

;; Author: tm8st <http://twitter.com/tm8st>
;; Version: 0.1
;; Keywords: convenience, imenu, easy

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
;; 適当なレベルのものを手軽に生成するための拡張です。
;; 実際の使用例は、easy-imenu-index-generator-config.elをご覧下さい。

;;; Example:

;; (require 'easy-imenu-index-generator)

;; (add-hook
;;  'emacs-lisp-mode-hook
;;  (lambda ()
;;    (easy-imenu-index-generator-set-for-current-buffer easy-imenu-index-generator-setting-elisp-sample)
;;    ))

;;; Code:

;; imenu生成用設定データ構造体
(defstruct easy-imenu-index-generator-setting
  (alist nil)
  (add-line-number-to-item t)
  )

(defvar easy-imenu-index-generator-setting-elisp-sample
  (make-easy-imenu-index-generator-setting
   :alist
   `(
     ((caption . "[defun]     ")
      (regexp . "^[\t ]*(defun "))
     ((caption . "[defvar]    ")
      (regexp . "^[\t ]*(defvar "))
     ((caption . "[defstruct] ")
      (regexp . "^[\t ]*(defstruct "))
     )
   :add-line-number-to-item t
   )
  "elisp用imenuのindex生成用設定データのサンプル"
  )

(defun easy-imenu-index-generator-imenu-alist-attr (name iter)
  "alist用getter."
  (cdr (assq name iter)))

(defun easy-imenu-index-generator-imenu-create-index (setting)
  "get current buffer imenu index."
  (save-excursion
    (let ((index-list))
      (dolist (iter (easy-imenu-index-generator-setting-alist setting))
	(goto-char (point-min))
	(while (re-search-forward (easy-imenu-index-generator-imenu-alist-attr 'regexp iter) nil t)
	  (goto-char (match-beginning 0))
	  (push (cons
		 (concat (easy-imenu-index-generator-imenu-alist-attr 'caption iter)
			 (when (easy-imenu-index-generator-setting-add-line-number-to-item setting)
			   (concat (format "%6d" (count-lines (point-min) (match-beginning 0))) " "))
			 (replace-regexp-in-string "[\n\t]" " " (thing-at-point 'line))
			 )
		 (point))
		index-list)
	  (goto-char (match-end 0))))
      (nreverse index-list))))

(defun easy-imenu-index-generator-set-for-current-buffer (setting)
  "imenuに使用するsourceを設定する。
   ***-mode-hookなどで呼びだすとmode別imenu設定が可能。"
  (interactive)
  (setq imenu-create-index-function
	`(lambda () (interactive) (easy-imenu-index-generator-imenu-create-index ,setting))))

(provide 'easy-imenu-index-generator)
