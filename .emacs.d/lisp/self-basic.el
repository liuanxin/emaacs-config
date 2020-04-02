
;; 撤消操作 C-/, C-x u, C-_(Ctrl + Shift + -)
;; C-g 等同于 按三次 Esc

;; M-;        注释反注释选择区域
;; M-c        单词首字母转为大写
;; M-u        整个单词转为大写
;; M-l        整个单词转为小写(小写字母 L)
;; M-- M-c    单词首字母转为大写
;; M-- M-u    整个单词转为大写
;; M-- M-l    整个单词转为小写
;; c-x c-l    选定区域全部改为小写
;; C-x C-u    选定区域全部改为大写
;; C-S-Back   删除整行内容(包括换行符)
;; C-u C-x =  查看当前光标处所在字体的相关信息

;; F1 与 C-h 功能一样, 当某些环境 F1 被占用了, 可以用 C-h 替代
;; C-h v 可以查看全局变量(variable)的细节
;; C-h f 可以查看全局函数(function)的细节
;; C-h k 再按下想要查看的键(key), 就可以看到键对应的调用方法
;; C-h w 查看函数对应的按键, 对应: M-x where-is
;; F1 t 查看快速指南

(global-linum-mode t)               ;; 显示行号
(global-hl-line-mode 1)             ;; 高亮当前行
(global-font-lock-mode t)           ;; 打开语法高亮
(global-auto-revert-mode t)         ;; 自动加载最新文件

(setq menu-bar-mode nil)            ;; 菜单条隐藏
(setq tool-bar-mode nil)            ;; 工具条隐藏
(setq inhibit-startup-screen t)     ;; 关闭起动时闪屏
(setq smooth-scroll-margin 2)       ;; 触发滚动的行数
(setq isearch-allow-scroll t)       ;; 搜索后滚屏只在当前屏幕显示
(setq column-number-mode t)         ;; 显示列号
(setq windmove-wrap-around t)       ;; window 切换时环绕, 也就是到了第一个, 再跳到上一个 window 就切换到最后一个
;;(setq x-select-enable-clipboard t)  ;; 与外部程序共享剪切版
(setq make-backup-files nil)        ;; 去掉自动备份
(setq auto-save-default nil)        ;; 默认是 t, 改成 nil 将不生成 ## 的备份文件, 异常后有备份的话 M-x recover-file 可以恢复
(setq backup-by-copying t)          ;; 默认是 nil, 改成 t 后将开启拷贝模式, 也就是不生成 file-name~ 这个文件
(setq-default indent-tabs-mode nil) ;; 不插入 tab 字符
(setq-default tab-width 4)          ;; 制表符设置成 4 个空格
(setq c-basic-offset 4)             ;; 缩进的基本单位: 4 空格

;; (setq tramp-default-method "ssh")
(setq tramp-verbose 10)
(setq tramp-debug-buffer t)

(unless (display-graphic-p) (menu-bar-mode -1)) ;; 在 termial 中不显示菜单栏

(setq display-time-format "%Y/%m/%d %H:%M")     ;; 时间格式
;; (setq display-time-interval 1)               ;; 每 1 秒更新一次. 默认是更新分钟
(display-time-mode 1)                           ;; 显示时间

(auto-image-file-mode t)            ;; 让 Emacs 可以直接打开、显示图片
(fset 'yes-or-no-p 'y-or-n-p)       ;; 用 y/n 代表 yes/no

(show-paren-mode t)                            ;; 括号匹配
(set-face-foreground 'show-paren-match "red")  ;; 定义括号匹配的前景色
(set-face-foreground 'linum "yellow")          ;; 定义行号的颜色
(set-face-bold-p 'show-paren-match t)          ;; 加粗显示括号匹配

(defun self-font()
  (interactive)
  (set-frame-font (format "%s:pixelsize=%d" "Monaco" 13) t)
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
                      (font-spec :family "Hiragino Sans GB W3" :size 16))))

;; (add-to-list 'after-make-frame-functions
;;              (lambda (new-frame)
;;                (select-frame new-frame)
;;                (if window-system (self-font))))

;; 只在 x 底下才设置等比字体
(if window-system (self-font))


;; 窗口位置, 只在 x 底下才需要设置
(setq window-system-default-frame-alist
      '((x (height . 40) (width . 120) (menu-bar-lines . 20) (tool-bar-lines . 0))))

;; 设置 x 下标题显示文件名和大小(用户@系统名 >> 文件大小 >> 完整文件名), 在 terminal 忽略
(if window-system
    (setq frame-title-format
          (list '(buffer-file-name "%f" (dired-directory dired-directory "%b"))
                "  >>  %I  >>  " (user-login-name)  "@"  (system-name))))

;; 打开指定的后缀时, 使用指定的模式
;; (add-to-list 'auto-mode-alist '("\\.jade$" . sws-mode))
