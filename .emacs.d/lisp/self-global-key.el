
(global-set-key (kbd "C-x a") 'mark-whole-buffer)    ;; 全选 的默认键是 C-x h, 添加 C-x a 一种按键方式

(global-set-key (kbd "C-M-1") 'delete-other-windows) ;; 设置 C-A-1 跟 C-x 1 一样, 删除其他的 window
(global-set-key (kbd "C-M-2") 'split-window-below)   ;; 设置 C-A-2 跟 C-x 2 一样, 纵向切割
(global-set-key (kbd "C-M-3") 'split-window-right)   ;; 设置 C-A-3 跟 C-x 3 一样, 横向切割
(global-set-key (kbd "C-M-4") 'delete-window)        ;; 设置 C-A-4 跟 C-x 0 一样, 删除当前窗口

;; F5, C-c C-g 跳到指定行
(global-set-key (kbd "<f5>") 'goto-line)
(global-set-key (kbd "C-c C-g") 'goto-line)

(global-set-key (kbd "C-c space") 'set-mark-command)  ;; 标记, 默认是 C-space

;; (require 'neotree)                     ;; 加载目录树
(global-set-key [f8] 'neotree-toggle)     ;; 绑定 F8 打开关闭 neotree
(global-set-key (kbd "<C-f8>") 'neotree-click-changes-root-toggle)  ;; C+F8 更改 neotree 根节点

(global-set-key (kbd "C-c C-s") 'pinyin-search)           ;; 搜索时使用 ss 就能找到 "搜索" 两个字
(global-set-key (kbd "<C-f9>") 'org-twbs-export-to-html)  ;; org 生成 html


;; M-; 注释反注释代码
(defun l-comment-dwim-line (&optional arg)
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p))) ;; (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key (kbd "M-;") 'l-comment-dwim-line)


;; ctrl-alt-\ 格式化代码
(dolist (command '(yank yank-pop))
  (eval `(defadvice, command
		   (after indent-region activate)
		   (and (not current-prefix-arg)
				(member major-mode
						'(emacs-lisp-mode lisp-mode clojure-mode scheme-mode
										  haskell-mode ruby-mode rspec-mode
										  python-mode c-mode c++-mode java-mode
										  objc-mode	latex-mode js-mode plain-tex-mode))
				(let ((mark-even-if-inactive transient-mark-mode))
				  (indent-region (region-beginning) (region-end) nil))))))
;; 格式化选中的 json, 其语法非常严格: 必须是双引号, 不能有注释
(global-set-key (kbd "C-c C-f") 'json-reformat-region)


;; 处理缩进和反缩进
(defun indent-block(tab-width) (shift-region tab-width) (setq deactivate-mark nil))
(defun unindent-block(tab-width) (shift-region (- tab-width)) (setq deactivate-mark nil))

(defun shift-region(numcols)
  (if (< (point)(mark))
	  (if (not(bolp))
		  (progn (beginning-of-line)(exchange-point-and-mark) (end-of-line)))
    (progn (end-of-line)(exchange-point-and-mark)(beginning-of-line)))
  (setq region-start (region-beginning))
  (setq region-finish (region-end))
  (save-excursion
    (if (< (point) (mark)) (exchange-point-and-mark))
    (let ((save-mark (mark)))
      (indent-rigidly region-start region-finish numcols))))

(defun my-indent (tab)
  (interactive)
  (if mark-active (indent-block tab)
	(if (looking-at "\\>") (hippie-expand nil) (insert tab))))

(defun my-unindent(tab-width)
  (interactive)
  (if mark-active (unindent-block tab-width)
    (progn
      (unless(bolp)
        (if (looking-back "^[ \t]*")
            (progn
              (let ((a (length(buffer-substring-no-properties (point-at-bol) (point)))))
				(progn
                  (if (> a tab-width)
                      (delete-backward-char tab-width)
                    (backward-delete-char a)))))
          (progn
            (if(looking-back "[ \t]\\{2,\\}")
                (delete-horizontal-space)
              (backward-kill-word 1))))))))

(defun my-indent-two() (interactive) (my-indent "  "))
(defun my-unindent-two() (interactive) (my-unindent 2))
(defun my-indent-four() (interactive) (my-indent "    "))
(defun my-unindent-four() (interactive) (my-unindent 4))

(add-hook 'find-file-hooks
		  (function
		   (lambda()
			 (unless (eq major-mode 'org-mode)
			   ;; 不在 org mode 下时, S-tab 缩进四个空格
			   (local-set-key (kbd "<backtab>") 'my-unindent-four)))))

;; m-i 写两个空格
(global-set-key (kbd "M-i") 'my-indent-two)
;; M-p 缩进两个空格
(global-set-key (kbd "M-p") 'my-unindent-two)

;; 非 org mode 模式下, 制表和缩进都基于 4 空格
(unless (eq major-mode 'org-mode)
  (local-set-key (kbd "<tab") 'my-indent-four)
  (local-set-key (kbd "<backtab") 'my-unindent-four))

;; m-[ 写四个空格
(global-set-key (kbd "M-[") 'my-indent-four)
;; M-] 缩进四个空格
(global-set-key (kbd "M-]") 'my-unindent-four)


;; C-k 调用的方法
(defadvice kill-line (before check-position activate)
  (if (member major-mode
			  '(emacs-lisp-mode lisp-mode scheme-mode
								ruby-mode python-mode java-mode
                                c-mode c++-mode objc-mode js-mode
                                latex-mode plain-tex-mode))
      (if (and (eolp) (not (bolp)))
          (progn (forward-char 1) (just-one-space 0) (backward-char 1)))))

;; M-w 调用的方法
(defadvice kill-ring-save (before slick-copy activate compile)
  (interactive (if mark-active (list (region-beginning) (region-end))
                 (message "Copied line")
                 (list (line-beginning-position) (line-beginning-position 2)))))

;; C-w 调用的方法
(defadvice kill-region (before slick-cut activate compile)
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;; 复制光标到行尾的内容
(defun mk-copy-line (arg)
  (interactive "p")
  (kill-ring-save (point) (line-end-position))
  (message "copied current line with point"))

(global-set-key (kbd "M-k") 'mk-copy-line)        ;; M-k 复制光标至行尾的数据
(global-set-key (kbd "C-c C-c") 'kill-ring-save)  ;; C-c C-c 复制, 跟 M-w 一样的功能
(global-set-key (kbd "C-c C-v") 'yank)            ;; C-c C-v 粘贴. 跟 C-y 一样的功能


;; youdao 词典
;; Enable Cache
(setq url-automatic-caching t)
;; Example Key binding
(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point)

;; (require 'popwin)
;; (popwin-mode 1)
;; (push "*Youdao Dictionary*" popwin:special-display-config)
;; Set file path for saving search history
(setq youdao-dictionary-search-history-file "~/.emacs.d/.youdao")
;; Enable Chinese word segmentation support (支持中文分词)
(setq youdao-dictionary-use-chinese-word-segmentation t)
