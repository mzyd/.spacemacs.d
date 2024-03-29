;;; packages.el --- yellow layer packages file for Spacemacs.
;;

;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Mzy <Mzy@bogon>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;; License: GPLv3


;; See the Spacemacs documentation and FAQs for instructions on how to implement
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `yellow-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `yellow/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `yellow/pre-init-PACKAGE' and/or
;;   `yellow/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst yellow-packages
  '(youdao-dictionary
    ;; company
    ;; 修改 emacs 本身的 package 配置
    ;; (occur-mode :location built-in)
    ;; becuase when start emacs, this packages always reload;
    ;; (gulpjs :location (recipe :fetcher github :repo "zilongshanren/emacs-gulpjs"))
    )
  )

;; (defun yellow/init-gulpjs()
;;   (use-package gulpjs
;;     :init))

;; 可以重写 layer 的方法, 在上面的 package 添加好要修改的 layer
;; (defun yellow/post-init-company()
;;   (setq company-minimum-prefix-length 1))

(defun wrap-markup-region-by-tag ()
  "Insert a markup 'tag-name' around a region."
  (interactive)
  (format "Please enter the tag you wanted:")
  (let ((p1 (region-beginning))
        (p2 (region-end))
        (tag-name (read)))
    (goto-char p2)
    (insert (format "</%s>" tag-name))
    (goto-char p1)
    (insert (format "<%s>" tag-name))))

;; (defun my-select-current-word ()
;;   "Select the word under cursor.
;; “word” here is considered any alphanumeric sequence with “_” or “-”."
;;   (interactive)
;;   (let (pt)
;;     (skip-chars-backward "-_A-Za-z0-9")
;;     (setq pt (point))
;;     (skip-chars-forward "-_A-Za-z0-9")
;;     (set-mark pt)))

(defun yellow/init-youdao-dictionary()
  (use-package youdao-dictionary
    :defer t
    :init
    (spacemacs/set-leader-keys "op" 'youdao-dictionary-search-at-point+)
    ;; 在有道加载完之后想做一些事, 可以放到 config 里面
    ;; :config
    ;; ()
    )
  )

(defun my-toggle-web-indent ()
  (interactive)
  ;; web development
  (if (eq major-mode 'json-mode)
      (progn
        (setq js-indent-level (if (= js-indent-level 2) 4 2))))

  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
        (setq js-indent-level (if (= js-indent-level 2) 4 2))))

  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
             (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
             (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))

  (setq indent-tabs-mode nil))

(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)

;; js 多行注释 绑定快捷键: spc o m
(defun my-comment-region()
  (interactive)
  (save-restriction
    (narrow-to-region (region-beginning) (region-end))
    (goto-char (point-max))
    (unless (re-search-backward "\\*\\/" nil t)
      (insert "*/")
      (goto-char (point-min))
      (unless (re-search-forward "\\/\\*" nil t)
        (insert "/*\n")))
    ))

;; (defun mzy/test-123 ()
;;   (dolist (hook (list 'rjsx-mode-hook 'js2-mode-hook 'vue-mode-hook))
;;     (add-hook hook '(lambda ()
;;                       ;; This is not a good way for bind a key in a keymap
;;                       ;; (local-set-key (kbd "<SPC> o ;") 'my-comment-region)
;;                       ;; this way is fine, but it will be working in global
;;                       (define-key evil-normal-state-map (kbd "<SPC> o ;") 'my-comment-region)
;;                       ))
;;     ))
;; (mzy/test-123)

(defun smarter-yas-expand-next-field-complete ()
  "Try to `yas-expand' and `yas-next-field' at current cursor position.

If failed try to complete the common part with `company-complete-common'"
  (interactive)
  (if yas-minor-mode
      (let ((old-point (point))
            (old-tick (buffer-chars-modified-tick)))
        (yas-expand)
        (when (and (eq old-point (point))
                   (eq old-tick (buffer-chars-modified-tick)))
          (ignore-errors (yas-next-field))
          (when (and (eq old-point (point))
                     (eq old-tick (buffer-chars-modified-tick)))
            (company-complete-common))))
    (company-complete-common)))

(with-eval-after-load 'company
  (define-key company-active-map [tab] #'yas-expand)
  (define-key company-active-map (kbd "TAB") #'yas-expand))

;; (defun html/init-emmet-mode ()
;;   (use-package emmet-mode
;;     :defer t
;;     :init (spacemacs/add-to-hooks 'emmet-mode '(css-mode-hook
;;                                                 html-mode-hook
;;                                                 sass-mode-hook
;;                                                 scss-mode-hook
;;                                                 web-mode-hook))
;;     :config
;;     (progn
;;       (evil-define-key 'insert emmet-mode-keymap (kbd "<C-i>") 'spacemacs/emmet-expand)
;;       (evil-define-key 'insert emmet-mode-keymap (kbd "<C-i>") 'spacemacs/emmet-expand)
;;       (evil-define-key 'emacs emmet-mode-keymap (kbd "<C-i>") 'spacemacs/emmet-expand)
;;       (evil-define-key 'emacs emmet-mode-keymap (kbd "<C-i>") 'spacemacs/emmet-expand)
;;       (evil-define-key 'hybrid emmet-mode-keymap (kbd "<C-i>") 'spacemacs/emmet-expand)
;;       (evil-define-key 'hybrid emmet-mode-keymap (kbd "<C-i>") 'spacemacs/emmet-expand)
;;       (spacemacs|hide-lighter emmet-mode))))


;; ---------------------- auto save ----------------------
(defgroup auto-save nil
  "Auto save file when emacs idle."
  :group 'auto-save)

(defcustom auto-save-idle 1
  "The idle seconds to auto save file."
  :type 'integer
  :group 'auto-save)

(defcustom auto-save-slient nil
  "Nothing to dirty minibuffer if this option is non-nil."
  :type 'boolean
  :group 'auto-save)

(defun auto-save-buffers ()
  (interactive)
  (let ((autosave-buffer-list))
    (save-excursion
      (dolist (buf (buffer-list))
        (set-buffer buf)
        (if (and (buffer-file-name) (buffer-modified-p))
            (progn
              (push (buffer-name) autosave-buffer-list)
              (if auto-save-slient
                  (with-temp-message ""
                    (basic-save-buffer))
                (basic-save-buffer))
              )))
      ;; Tell user when auto save files.
      (unless auto-save-slient
        (cond
         ;; It's stupid tell user if nothing to save.
         ((= (length autosave-buffer-list) 1)
          (message "# Saved %s" (car autosave-buffer-list)))
         ((> (length autosave-buffer-list) 1)
          (message "# Saved %d files: %s"
                   (length autosave-buffer-list)
                   (mapconcat 'identity autosave-buffer-list ", ")))))
      )))

(defun auto-save-enable ()
  (interactive)
  (run-with-idle-timer auto-save-idle t #'auto-save-buffers)
  )

;; ---------------------- auto save end ----------------------

;; ----------- 设置 company 的前缀长度和时间, 为了解决 react-mode 里面的不正常行为.

;; (defun mzy/company-init ()
;;   "set my own company-idle-delay and company-minimum-prefix-length"
;;   (interactive)
;;   (setq-local company-idle-delay mzy/company-idle-delay)
;;   (set (make-local-variable 'company-minimum-prefix-length)
;;        mzy/company-minimum-prefix-length))
;; (defvar mzy/company-minimum-prefix-length 1
;;   "my own variable for company-minimum-prefix-length")
;; (defvar mzy/company-idle-delay 0.1
;;   "my own variable for company-idle-delay")
;; (add-hook 'company-mode-hook #'mzy/company-init)


;; ------------------- iterm -----------
;; mac上打开iterm2，并cd到当前编辑的文件所在目录
;;;###autoload
(defun cd-iterm2()
  (interactive)
  (let ((cmd (format "
tell application \"iTerm\"
  activate
  if (count of windows) = 0 then
    set w to (create window with default profile)
  else
    set w to current window
  end if

  tell w
    set targetSession to null

    activate current session
    tell current session of w
      if is at shell prompt then
        set targetSession to current session of w
      end if
    end tell
    if targetSession is null then
      repeat with aTab in tabs
        if targetSession is null then
          tell aTab
            select
            repeat with aSession in sessions
              if targetSession is null then
                tell aSession
                  select
                  if is at shell prompt then
                    set targetSession to aSession
                  end if
                end tell
              end if
            end repeat
          end tell
        end if
      end repeat
    end if
    if targetSession is null then
      create tab with default profile
      -- delay 0.1
      set targetSession to current session of w
    end if

    if targetSession is not null then
      tell targetSession
        select
        set cmd to \"cd \" & quote & \"%s\" & quote & \";clear\"
        write text cmd
      end tell

    end if
  end tell
end tell
" (expand-file-name default-directory))))
    (start-process "cd-iterm2" nil "osascript" "-e" cmd)))


(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

(defun add-semicolon ();
  (interactive)
  (evil-append-line 1)
  (insert ";")
  (evil-normal-state)
  )



(defun format-html ()
  (interactive)
  (let ((pos (line-beginning-position)))
    (message pos)
    (end-of-line)
    (set-mark pos))
  ;; (skip-chars-forward "-")
  ;; (evil-insert 1)
  ;; (insert "\n")
  )

(defun wrap-parenthesis-at-point ()
  "Select the word under cursor.
“word” here is considered any alphanumeric sequence with “_” or “-”."
  (interactive)
  (let (pt)
    (skip-chars-backward "-_A-Za-z0-9")
    (setq pt (point))
    (skip-chars-forward "-_A-Za-z0-9")
    (set-mark pt)
    )
  (let (
        (p1 (region-beginning))
        (p2 (region-end))
        )
    (goto-char p2)
    (insert ")")
    (goto-char p1)
    (insert "(")
    (goto-char (+ p2 1))
    (evil-insert 1)
    ;; (evil-append 1)
    )
  )

(defun mzy/open-cur-finder ()
  (interactive)
  (shell-command "open .")
  )

(defun mzy/edit-at-point-cut-word ()
  (interactive)
  (edit-at-point-word-cut)
  (evil-insert 1)
  )

(defun mzy/evil-ex-s ()
  (interactive)
  (evil-ex "'<,'>s/")
  )

(defun mzy/evil-ex-%s ()
  (interactive)
  (evil-ex "%s/")
  )

(defun mzy/jump-to-script-tag ()
  (interactive)
  (if (search-forward "<scrip" nil t)
      (search-backward "<scrip" nil t)
    (search-backward "<scrip" nil t)
    )
  )

(defun mzy/jump-to-data ()
  (interactive)
  (if (search-forward "data() {" nil t)
      (search-backward "data() {" nil t)
    (search-backward "data() {" nil t)
    )
  )

(defun mzy/jump-to-style ()
  (interactive)
  (if (search-forward "<style" nil t)
      (search-backward "<style" nil t)
    (search-backward "<style" nil t)
    )
  )
(defun mzy/jump-to-methods ()
  (interactive)
  (if (search-forward "methods:" nil t)
      (search-backward "methods:" nil t)
    (search-backward "methods:" nil t)
    )
  )

(defun mzy/format-html-to-mutiple-line()
  (interactive)
  (setq cur-line-txt
        (buffer-substring-no-properties
         (line-beginning-position)
         (line-end-position)
         ))
  (setq time (- (length (split-string cur-line-txt " ")) 1))
  (while (> time 0)
    (search-forward " " nil t)
    (replace-match "\n")
    (setq time (- time 1))
    )
  )

(defun mzy/addSymbalEqual ()
  (interactive)
  (skip-chars-backward "a-z")
  (insert "=")
  (skip-chars-forward "a-z")
  (insert "=")
  )

(defun mzy/go1 ()
  (interactive)
  (forward-line 0)
  )

(defun mzy/format-by-comma-for-js ()
  (interactive)
  (forward-line 0)

  (search-forward "{ " nil t)
  (replace-match "{\n  ")

  (setq cur-line-txt
        (buffer-substring-no-properties
         (line-beginning-position)
         (line-end-position)
         ))
  (setq time (- (length (split-string cur-line-txt ",")) 1))
  (while (> time 0)
    (search-forward "," nil t)
    (replace-match ",\n ")
    (setq time (- time 1))
    )

  (search-forward " } " nil t)
  (replace-match "\n} ")
  )

(defun mzy/remove-log ()
  (interactive)
  (let* (
         (cmd "ag console.log")
         (output (shell-command-to-string cmd))
         (lines (split-string output "[\n\r]+"))
         (rest '())
         )

    (setq lines (seq-filter (lambda (x) (> (length x) 0)) lines))

    (setq rest (mapcar (lambda (x)
                         (nth 0 (split-string x ":"))
                         ) lines))

    (setq rest (delete-duplicates rest :test #'string-equal))

    (mapcar (lambda (x)
              ;; (shell-command (format "sed -i\'\' -e '\/console.log/d\' %s" x))
              (shell-command (format "sed -i '' '\/console.log/d\' %s" x))
              ) rest)
    ))

(defun mzy/split-and-copy-window ()
  (interactive)
  (delete-other-windows)
  (split-window-right)
  )

(defun mzy/search-str-to-buffer ()
  )
;; (defun mzy/open-finder-by-fasd ()
;;   (interactive)
;;   (helm-fasd "front")
;;   )
