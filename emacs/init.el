;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; inhibit startup messages
(setq inhibit-startup-message t)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
;(setq require-final-newline 'query)

;;
;; Here is self setting from Sherman Hsu
;;

;; show the column number
(setq column-number-mode t)

;; set the fill column with 60 line
;;(setq default-fill-column 60)

;; using paren mode to make parentheses highlight both side 
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;; default c-set-mode is linux
(setq c-default-style "linux")

;; Add Linux Kernal Coding Style
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
	 (column (c-langelem-2nd-pos c-syntactic-element))
	 (offset (- (1+ column) anchor))
	 (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))


; Using whitespace mode
(require 'whitespace)
(autoload 'whitespace-mode           "whitespace" "Toggle whitespace visualization."        t)
(autoload 'whitespace-toggle-options "whitespace" "Toggle local `whitespace-mode' options." t)

;; using ido buffer switch / ibuffer list buffer
(require 'ido)
(ido-mode t)
(global-set-key (kbd "C-x b") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;; using window move mode
(require 'windmove)
(global-set-key (kbd "C-x <up>") 'windmove-up) 
(global-set-key (kbd "C-x <down>") 'windmove-down) 
(global-set-key (kbd "C-x <right>") 'windmove-right) 
(global-set-key (kbd "C-x <left>") 'windmove-left) 

;; configure ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

;; read TAGS file
(setq tags-file-name "/home1/users/sherman_hsu/VOIP2G/dsp-fwk/dsp_TAGS")

;; Disable auto-save file
(setq auto-save-default nil)

;; using cscope
(require 'cc-mode)
(load-file "/usr/share/emacs/site-lisp/xcscope.el")
(require 'xcscope)
;; emacs will call C-c s I update Index will mismatch cscope -q
(setq cscope-do-not-update-database "t")

;; using octave mode when edit m files
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; when using octave mode, enable auto-fill and font-lock 
(add-hook 'octave-mode-hook
	  (lambda ()
	    (abbrev-mode 1)
	    (if (eq window-system 'x)
		(font-lock-mode 1))))

;; Hook when using LaTeX mode ;;
(mapc (lambda (mode)
	(add-hook 'LaTex-mode-hook mode))
      (list 'auto-fill-mode
	    'LaTex-math-mode
	    'turn-on-reftex
	    'linum-mode))

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (setq TeX-auto-untabify t     ; remove all tabs before saving
                  TeX-show-compilation t) ; display compilation windows
            (TeX-global-PDF-mode t)       ; PDF mode enable, not plain
            (setq TeX-save-query nil)
            (imenu-add-menubar-index)
            (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)))

;;; Python packages ;;;
;; Jedi ;;
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

;; Ipython ;;
(setq python-python-command "ipython")
;(setq
; python-shell-interpreter "ipython"
; python-shell-interpreter-args ""
;  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
; python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
; python-shell-completion-setup-code
;   "from IPython.core.completerlib import module_completion"
; python-shell-completion-module-string-code
;   "';'.join(module_completion('''%s'''))\n"
; python-shell-completion-string-code
;   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;; el-get ;;
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.
(setq el-get-sources
 '(el-get
   auto-complete
   autopair
   multi-term
   git-emacs
   doxymacs
   protobuf-mode
   smex
   )
)

(el-get 'sync)

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/el-get/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/el-get/auto-complete/dict")
(ac-config-default)

;; autopair
(add-to-list 'load-path "~/.emacs.d/el-get/autopair")
(require 'autopair)
(autopair-global-mode)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; multi-term
(add-to-list 'load-path "~/.emacs.d/el-get/multi-term")
(require 'multi-term)
(setq multi-term-program "/bin/bash")
(setq multi-term-buffer-name "term")
;(setq multi-term-dedicated-select-after-open-p t)
(global-set-key "\C-xtt" 'multi-term)
(global-set-key "\C-x," 'multi-term-next)
(global-set-key "\C-xts" 'shell)

;; git-emacs
(add-to-list 'load-path "~/.emacs.d/el-get/git-emacs")
(require 'git-emacs)

;; doxymacs
(add-to-list 'load-path "~/.emacs.d/el-get/doxymacs")
(require 'doxymacs)
(add-hook 'c-mode-common-hook 'doxymacs-mode)

;; protobuf-mode
(add-to-list 'load-path "~/.emacs.d/el-get/protobuf-mode")
(require 'protobuf-mode)
(setq auto-mode-alist  (cons '(".proto$" . protobuf-mode) auto-mode-alist))

;; smex
(add-to-list 'load-path "~/.emacs.d/el-get/smex")
(require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; disaster -- Disassemble C/C++ code under cursor in Emacs;;
(add-to-list 'load-path "~/.emacs.d/el-get/disaster")
(require 'disaster)
;;(define-key c-mode-base-map (kbd "C-c d") 'disaster) ;; conflict key binding with doxymacs

;; hideshow-org.el
(add-to-list 'load-path "~/.emacs.d/el-get/hideshow-org")
(require 'hideshow-org)

;; CEDET
;; Enable EDE (Project Management) features
(global-ede-mode 1)
(semantic-mode 1)
 
;; ==============using ECB====================

;; ; These lines are required for ECB
;; ;;(add-to-list 'load-path "/home1/users/sherman_hsu/emacs_plginfiles/cedet-1.0pre7/eieio/eieio.el")
;; ;;(add-to-list 'load-path "/home1/users/sherman_hsu/emacs_plginfiles/cedet-1.0pre7/semantic/semantic.el")
;; ;;(add-to-list 'load-path "/home1/users/sherman_hsu/emacs_plginfiles/cedet-1.0pre7/speedbar/speedbar.el")
;; ;;(setq semantic-load-turn-everything-on t)
;; ;;(require 'semantic-load)
;; ; This installs ecb - it is activated with M-x ecb-activate
;; (add-to-list 'load-path "~/emacs_plugins/ecb-2.40")
;; (load-file "~/emacs_plugins/ecb-2.40/ecb.el")
;; (require 'ecb-autoloads)

;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(ecb-layout-window-sizes (quote (("left9" (0.23387096774193547 . 0.9696969696969697)))))
;;  '(ecb-options-version "2.40")
;;  '(inhibit-startup-screen t))

;; ;; Binding ECB with hot-key F12/activate , Ctrl-F12/deactivate
;; (global-set-key [f12] 'ecb-activate)
;; (global-set-key [C-f12] 'ecb-deactivate)

;; ==============ending ECB===================

;; ;; Disable Semantic highlight edit mode
;; (global-semantic-highlight-edits-mode -1)

;; ;; Disable Semantic display the underscore with unmatched tag

;; ;; Only disable semantic-show-unmatched-syntax-mode is not useful 
;; ;; because global-semantic-show-unmatched-syntax-mode will call him 
;; ;(semantic-show-unmatched-syntax-mode -1)

;; (global-semantic-show-unmatched-syntax-mode -1)



;; ==============using yasnippet ====================
; newest yasnippet from elpa
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.8.0")
(require 'yasnippet)
(yas/global-mode 1)

;;==============publish org ====================
;; Temporary add this key binding
(add-hook 'org-mode-hook
          (lambda ()
;            (define-key org-mode-map [Control c .] 'org-time-stamp)))
            (local-set-key "\C-cq" 'org-time-stamp)
	    (flyspell-mode t)))

(setq org-publish-project-alist
      '(("note-org"
         :base-directory "~/Dropbox/org"
         :publishing-directory "~/Dropbox/org/publish"
         :base-extension "org"
         :recursive t
         :publishing-function org-publish-org-to-html
         :auto-index nil
         :index-filename "index.org"
         :index-title "index"
         :link-home "index.html"
         :section-numbers nil
         :style "<link rel=\"stylesheet\"
    href=\"./style/emacs.css\"
    type=\"text/css\"/>")
        ("note-static"
         :base-directory "~/Dropbox/org"
         :publishing-directory "~/Dropbox/org/publish"
         :recursive t
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt\\|el"
         :publishing-function org-publish-attachment)
        ("note" 
         :components ("note-org" "note-static")
         :author "sherman_hsu@5vtechnologies.com"
         )))
