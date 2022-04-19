;;; keybindings.el --- Better Emacs Defaults Layer key bindings File
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; 打开occur模式
(spacemacs/set-leader-keys "oo" 'occur-dwim)
(spacemacs/set-leader-keys "oi" 'iedit-mode)

;; comment region in js
(defun set-hotkey-for-js ()
  (setq js-hook-list
        '("js-mode-hook" "js2-mode-hook" "rjsx-mode-hook" "vue-mode-hook"))
  (setq index 0)
  (while (< index 4)
    (setq cur-item (car js-hook-list))
    (add-hook (intern (format "%s" cur-item))
              (lambda ()
                (local-set-key (kbd "<SPC> o ;") 'my-comment-region))
              )
    (setq js-hook-list (cdr js-hook-list))
    (setq index (+ index 1))
    )
  )
(set-hotkey-for-js)

;; (defun test-123 ()
;;   (dolist (hook (list 'rjsx-mode-hook 'js2-mode-hook))
;;     (message "%s" hook)
;;     (add-hook (intern (format "%s" hook)) (lambda () (
;;                                 (local-set-key (kbd "<SPC> o ;") 'my-comment-region)
;;                                 )))
;;     ))
;; (test-123)

;; package.el 里面的方法, 自动模板的快捷键
;; (global-set-key (kbd "M-m o s") 'autoinsert-yas-expand)


(global-set-key (kbd "M-m o k") 'cd-iterm2)

(define-key evil-normal-state-map (kbd ", ;") 'add-semicolon)

(global-set-key (kbd "C-9") 'wrap-parenthesis-at-point)
(spacemacs/set-leader-keys "o9" 'wrap-parenthesis-at-point)
