
;; (require 'package)
(setq package-archives
      '(
        ("gnu" . "http://elpa.gnu.org/packages/")         ;; 官方源
        ("popkit" . "http://elpa.popkit.org/packages/")   ;; 网友做的国内源
      )
)

;; (package-initialize)             ;; 初始化包
(setq package-enable-at-startup t)  ;; emacs 启动时就启用包, require 时需要先保证 emacs 有启用包

;; 打开上次的文件记录
(if window-system (desktop-load-default))
(if window-system (desktop-read))
;; 当 emacs 退出时保存文件打开状态
(if window-system (add-hook 'kill-emacs-hook '(lambda() (desktop-save "~/.emacs.d/"))))
;; (require 'package)
(add-hook 'after-init-hook 'session-initialize)

;; 保存时删除行尾空白符
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; 保存时将制表换成空格
(add-hook 'before-save-hook (lambda () (untabify (point-min) (point-max))))
