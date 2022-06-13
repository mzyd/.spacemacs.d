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

;; /////////////////////////// set key to nil ////////////////////////////
(global-set-key (kbd "C-s") nil)
(global-set-key (kbd "s-w") nil)
(global-set-key (kbd "s-o") nil)
(define-key evil-normal-state-map (kbd "C-e") nil)
(define-key evil-normal-state-map (kbd "s-n") nil)
(define-key evil-motion-state-map (kbd ";") nil)
(spacemacs/set-leader-keys "/" nil)

;; ****** nil key ******
(global-set-key (kbd "s-d") nil)
(global-set-key (kbd "s-e") nil)
(global-set-key (kbd "s-i") nil)

;; /////////////////////////// set key to nil ////////////////////////////


;; 打开occur模式
(spacemacs/set-leader-keys "oo" 'occur-dwim)
(spacemacs/set-leader-keys "oi" 'iedit-mode)


;; ;; comment region in js
;; (defun set-hotkey-for-js ()
;;   (setq js-hook-list
;;         '("js-mode-hook" "js2-mode-hook" "rjsx-mode-hook" "vue-mode-hook"))
;;   (setq index 0)
;;   (while (< index 4)
;;     (setq cur-item (car js-hook-list))
;;     (add-hook (intern (format "%s" cur-item))
;;               (lambda ()
;;                 (local-set-key evil-normal-state-map (kbd "<SPC> o ;") 'my-comment-region))
;;               )
;;     (setq js-hook-list (cdr js-hook-list))
;;     (setq index (+ index 1))
;;     )
;;   )
;; (set-hotkey-for-js)


;; package.el 里面的方法, 自动模板的快捷键
;; (global-set-key (kbd "M-m o s") 'autoinsert-yas-expand)



(global-set-key (kbd "M-m o k") 'cd-iterm2)

(define-key evil-normal-state-map (kbd ", ;") 'add-semicolon)

(define-key evil-normal-state-map (kbd ", e b") 'eval-buffer)
(define-key evil-normal-state-map (kbd ", s s") 'swiper-thing-at-point)
(define-key evil-normal-state-map (kbd ", f f") 'helm-projectile-find-file)

(define-key evil-normal-state-map (kbd "; a a") 'edit-at-point-word-copy)
(define-key evil-normal-state-map (kbd "; c c") 'mzy/edit-at-point-cut-word)
(define-key evil-normal-state-map (kbd "; s c") 'edit-at-point-word-cut)
(define-key evil-normal-state-map (kbd "; s r") 'mzy/evil-ex-s)
(define-key evil-normal-state-map (kbd "; r r") 'mzy/evil-ex-%s)
(define-key evil-normal-state-map (kbd "; s p") 'edit-at-point-word-paste)
(define-key evil-normal-state-map (kbd "; s d") 'edit-at-point-word-delete)

;; (define-key evil-normal-state-map (kbd "; g e") 'mzy/jump-to-script-tag)
;; (define-key evil-normal-state-map (kbd "; g d") 'mzy/jump-to-data)
;; (define-key evil-normal-state-map (kbd "; g s") 'mzy/jump-to-style)
;; (define-key evil-normal-state-map (kbd "; g m") 'mzy/jump-to-methods)

(add-hook 'vue-mode-hook
          (lambda ()
            (define-key evil-normal-state-map (kbd "; g e") 'mzy/jump-to-script-tag)
            (define-key evil-normal-state-map (kbd "; g d") 'mzy/jump-to-data)
            (define-key evil-normal-state-map (kbd "; g s") 'mzy/jump-to-style)
            (define-key evil-normal-state-map (kbd "; g m") 'mzy/jump-to-methods)
            ))

(global-set-key (kbd "C-9") 'wrap-parenthesis-at-point)
(spacemacs/set-leader-keys "o9" 'wrap-parenthesis-at-point)
(define-key evil-motion-state-map (kbd "C-e") 'evil-end-of-line)
(define-key evil-normal-state-map (kbd "s-n") 'evil-jump-item)
;; (global-set-key (kbd "C-;") 'hungry-delete-backward)

(spacemacs/set-leader-keys "/" 'replace-regexp)
(define-key evil-visual-state-map (kbd ", s r") 'replace-string)

(define-key evil-visual-state-map (kbd "v") 'er/expand-region)

(global-set-key (kbd "C-s q s") 'isearch-forward)
(global-set-key (kbd "C-s s") 'swiper-thing-at-point)
(global-set-key (kbd "C-s k") 'wrap-markup-region-by-tag)

(define-key evil-normal-state-map (kbd ", 0") 'winum-select-window-0)
(define-key evil-normal-state-map (kbd ", 1") 'winum-select-window-1)
(define-key evil-normal-state-map (kbd ", 2") 'winum-select-window-2)
(define-key evil-normal-state-map (kbd ", 3") 'winum-select-window-3)
(define-key evil-normal-state-map (kbd ", 4") 'winum-select-window-4)
(define-key evil-normal-state-map (kbd ", w /") 'split-window-right)
(define-key evil-normal-state-map (kbd ", w s") 'split-window-below)
(define-key evil-normal-state-map (kbd ", w d") 'delete-window)
(global-set-key (kbd "s-w") 'delete-window)

;; comment indent
(spacemacs/set-leader-keys ";" 'evilnc-comment-or-uncomment-lines)
(spacemacs/set-leader-keys "=" 'spacemacs/indent-region-or-buffer)
;; setup document comment for js
;; (global-set-key (kbd "M-m o c") 'js-doc-insert-function-doc-snippet)
(spacemacs/set-leader-keys "oh" 'helm-show-kill-ring)
(spacemacs/set-leader-keys "o." 'mzy/open-cur-finder)
(spacemacs/set-leader-keys "olu" 'edit-at-point-line-up)
(spacemacs/set-leader-keys "old" 'edit-at-point-line-down)

(global-set-key (kbd "s-;") 'company-files)
;; dired-mode backward
(add-hook 'dired-mode-hook
          (lambda ()
            (local-set-key (kbd "s-b") 'dired-up-directory)
            ))


;; normal-state 下 RET 键打开最近的 buffer 列表
(define-key evil-normal-state-map (kbd "<RET>") 'helm-mini)

(global-set-key (kbd "s-o") 'mzy/open-cur-finder)

