;;; mime-w3.el --- mime-view content filter for text

;; Copyright (C) 1994,1995,1996,1997,1998 Free Software Foundation, Inc.

;; Author: MORIOKA Tomohiko <morioka@jaist.ac.jp>
;; Keywords: HTML, MIME, multimedia, mail, news

;; This file is part of SEMI (Suite of Emacs MIME Interfaces).

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Code:

(require 'w3)
(require 'mime-text)

(defmacro mime-put-keymap-region (start end keymap)
  `(put-text-property ,start ,end
		      ',(if (featurep 'xemacs)
			    'keymap
			  'local-map)
		      ,keymap)
  )

(defmacro mime-save-background-color (&rest body)
  (if (featurep 'xemacs)
      `(let ((color (color-name (face-background 'default))))
	 (prog1
	     (progn ,@body)
	   (font-set-face-background 'default color (current-buffer))
	   ))
    (cons 'progn body)))

(defun mime-preview-text/html (entity situation)
  (mime-save-background-color
   (save-restriction
     (narrow-to-region (point-max)(point-max))
     (mime-text-insert-decoded-body entity)
     (let ((beg (point-min)))
       (remove-text-properties beg (point-max) '(face nil))
       (w3-region beg (point-max))
       (mime-put-keymap-region beg (point-max) w3-mode-map)
       ))))


;;; @ end
;;;

(provide 'mime-w3)

;;; mime-w3.el ends here