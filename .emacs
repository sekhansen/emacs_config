;; overwrite selected text

(delete-selection-mode 1)

;; for text highlighting

(transient-mark-mode t)

;; increase highlight color

(set-face-attribute 'region nil :background "#bbb")

;; use-package information from
;; https://emacs.stackexchange.com/questions/27885/
;; how-to-get-the-same-emacs-environment-on-a-different-computer/27889

;; setup the package library
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; boostrap use-package

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))

;; use use-package to both install and configure packages

;; ESS

(use-package ess
	     :ensure t
	     :init (require 'ess-site))

;; elpy

;; if this becomes slow, see
;; https://emacs.stackexchange.com/questions/10065/
;; how-can-i-defer-loading-elpy-using-use-package

(use-package elpy
	     :ensure t
	     :init (elpy-enable)
	     :config
	     (setq python-shell-interpreter "ipython")
	     (setq python-shell-interpreter-args "--simple-prompt -i"))

;; emacs color theme

(use-package moe-theme
	     :ensure t
	     :init (require 'moe-theme)
	     :config
	     (moe-dark))


;; multiple cursors

(use-package multiple-cursors
	     :ensure t
	     :init (require 'multiple-cursors)
	     :config
	     (global-set-key (kbd "C->") 'mc/mark-next-like-this)
	     (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
	     (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

;; LaTex and associated packages
;; see https://www.reddit.com/r/emacs/comments/cd6fe2/how_to_make_emacs_a_latex_ide/

(use-package reftex
	     :ensure t
	     :defer t
	     :config
	     (setq reftex-cite-prompt-optional-args t)) ;; Prompt for empty optional arguments in cite

(use-package auto-dictionary
	     :ensure t
	     :init(add-hook 'flyspell-mode-hook (lambda () (auto-dictionary-mode 1))))

(use-package tex
	     :ensure auctex
	     :mode ("\\.tex\\'" . latex-mode)
	     :config (progn
		       (setq TeX-PDF-mode t)
		       (setq TeX-source-correlate-mode t)
		       (setq TeX-source-correlate-method 'synctex)
		       (setq TeX-auto-save t)
		       (setq reftex-plug-into-AUCTeX t)
		       (setq TeX-view-program-selection '((output-pdf "Okular"))
			     TeX-source-correlate-start-server t)
		       (add-hook 'LaTeX-mode-hook
				 (lambda ()
				   (reftex-mode t)
				   (flyspell-mode t)))
		           ))

;; (use-package auctex
;; 	     :ensure t
;; 	     :init
;; 	     (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; 	     :config
;; 	     (setq reftex-plug-into-AUCTeX t)
;; 	     )



;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(TeX-PDF-mode t)
;;  '(TeX-source-correlate-method 'synctex)
;;  '(TeX-source-correlate-mode t)
;;  '(TeX-source-correlate-start-server t)
;;  '(TeX-view-program-selection '((output-pdf "Okular")))
;;  '(package-selected-packages '(moe-theme multiple-cursors ess elpy auctex)))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )
