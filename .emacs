
(package-initialize)

(load "server")
(unless (server-running-p) (server-start))

;; (add-to-list 'load-path "~/.emacs.d/lisp")
(load-file "~/.emacs.d/lisp/self-package-session.el")
(load-file "~/.emacs.d/lisp/self-basic.el")
(load-file "~/.emacs.d/lisp/self-org-mode.el")
(load-file "~/.emacs.d/lisp/self-global-key.el")

;; http://www.yinwang.org/blog-cn/2013/04/11/scheme-setup
(load-file "~/.emacs.d/lisp/parenface.el")
(set-face-foreground 'paren-face "DimGray")


;; M-x customize-themes 管理主题, 或者 M-x color-theme-sanityinc-solarized-light
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (leuven)))
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
