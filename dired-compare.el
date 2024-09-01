;;; dired-compare.el --- Compare directories using multiple tools in Dired  -*- lexical-binding: t; -*-
;;
;; Author: James Dyer <captainflasmr@gmail.com>
;; Version: 0.0.1
;; Package-Requires: ((emacs "28.1"))
;; Keywords: convenience
;; URL: https://github.com/captainflasmr/dired-compare
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.
;;
;;; Commentary:
;;
;; This package allows you to compare directories in Dired using multiple
;; directory comparison tools. It supports tools like Meld by default,
;; and new tools can be added by extending the `dired-compare-diff-tools`.
;;
;;; Code:

(defgroup dired-compare nil
  "Comparison tools for directories within Dired."
  :prefix "dired-compare-"
  :group 'dired)

 (defcustom dired-compare-diff-tools
  '(("Meld" . ("meld"))
    ("diff" . ("diff" ("-ry")))
    ("rsync" . ("rsync" ("-avP" "--dry-run")))
    ("kompare" . ("kompare"))
    ("ztree-diff" . ("ztree-diff"))
    ("ediff-directories" . ("ediff-directories"))
    ("dired-diff" . ("dired-diff"))
    ("dired-compare-directories" . ("dired-compare-directories"))
    ("fdupes" . ("fdupes" ("-r"))))
  "An alist of available directory comparison tools and their shell commands with optional arguments."
  :type '(alist :key-type string :value-type (group string (repeat (choice string symbol))))
  :group 'dired-compare)

;; (defun dired-compare-directories-predicate (file1 file2)
;;   "Predicate to compare files by size."
;;   (= (file-attribute-size (file-attributes file1))
;;      (file-attribute-size (file-attributes file2))))

(defun dired-compare-directories-predicate (size1 size2)
  "Predicate to compare files by size."
  (not (= size1 size2)))

(defun dired-compare (tool)
  "Compare all marked directories in all visible Dired buffers using TOOL with pre-specified arguments.
The order of directories respects the order suggested by `dired-dwim-target`."
  (interactive
   (list (completing-read "Choose comparison tool: " (mapcar 'car dired-compare-diff-tools))))
  (let ((tool-entry (cdr (assoc tool dired-compare-diff-tools)))
        (files ()))
    (dolist (window (window-list))
      (with-current-buffer (window-buffer window)
        (when (and (derived-mode-p 'dired-mode)
                   (dired-get-marked-files))
          (setq files (append files (dired-get-marked-files))))))
    (if (or (<= (length files) 1)
            (not (cl-every 'file-directory-p files)))
        (message "Please mark at least two directories.")
      (if tool-entry
          (let* ((command (car tool-entry))
                 (args (append (cadr tool-entry) files)))
            (prin1 (cadr tool-entry))
            (prin1 args)
            (cond
             ((string-equal tool "dired-diff")
              (dired-diff (nth 1 files)))
             ((string-equal tool "ztree-diff")
              (ztree-diff (nth 0 files) (nth 1 files)))
             ((string-equal tool "ediff-directories")
              (ediff-directories (nth 0 files) (nth 1 files) nil))
             ((string-equal tool "dired-compare-directories")
              (dired-compare-directories (nth 1 files) 'dired-compare-directories-predicate))
             (t
              (let* ((buffer-name (format "*%s*" tool))
                     (buffer (get-buffer-create buffer-name)))
                (with-current-buffer buffer
                  (erase-buffer))
                (apply 'start-process tool buffer command args)
                (pop-to-buffer buffer))
              )))
        (message "Tool '%s' not found in `dired-compare-diff-tools`." tool)))))

(provide 'dired-compare)

;;; dired-compare.el ends here
