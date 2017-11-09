
;; 两个反斜线 \\ 换行
;; org-mode 下, 输入 <s, 再按 TAB 就可以生成 #+BEGIN_SRC ... #+END_SRC, 其他的依下面的
;; 来自 : http://orgmode.org/manual/Easy-Templates.html#Easy-Templates
;; s  #+BEGIN_SRC ... #+END_SRC           -n 显示行号, -t 清除格式, -h 7 设置高度为 7, -w 40 设置宽度为 40
;; e  #+BEGIN_EXAMPLE ... #+END_EXAMPLE   生成 <pre class="example" /> 块, 如果是单行, 使用 : 开头即可
;; q  #+BEGIN_QUOTE ... #+END_QUOTE       生成 <blockquote /> 块
;; v  #+BEGIN_VERSE ... #+END_VERSE       生成 <p class=verse" /> 块, 换行不需要使用 \\, 直接换行即可
;; c  #+BEGIN_CENTER ... #+END_CENTER     生成 <div class="center" /> 块, 保证居中得看 css 实现
;; h  #+BEGIN_HTML ... #+END_HTML         多行 html 代码
;; H  #+HTML:                             单行 html 代码
;; l  #+BEGIN_LaTeX ... #+END_LaTeX
;; L  #+LaTeX:
;; a  #+BEGIN_ASCII ... #+END_ASCII
;; A  #+ASCII:
;; i  #+INDEX: line
;; I  #+INCLUDE: "file"


;; ox-twbs.el
;; "<link href=\"https://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css\" rel=\"stylesheet\">
;; <script src=\"https://cdn.bootcss.com/jquery/1.11.3/jquery.min.js\"></script>
;; <script src=\"https://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js\"></script>"
;;
;; ;; "<link  href=\"https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/css/bootstrap.min.css\" rel=\"stylesheet\">
;; ;; <script src=\"https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.3/jquery.min.js\"></script>
;; ;; <script src=\"https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/js/bootstrap.min.js\"></script>"


;; C-c | 或 |-  新建表格
;; C-c C-x f    添加脚注
;; 要在表格中添加 |, 使用 \vert, 如 abc\vert{}xyz, 将显示 abc|xyz --> http://orgmode.org/manual/Built_002din-table-editor.html

;; C-c C-l  org-insert-link
;; 如果想要在 org 文件中显示完整 link, 使用「M-x org-toggle-link-display」: http://orgmode.org/manual/Link-format.html


;; 让表格有边框(在 M-x org-html-export-to-html 时有效) >> #+ATTR_HTML: :border 2 :rules all :frame border
;; 编辑 table 时， 回车 跳到下一行的第一个, 如果没有下一行则新建
;; M-<left> 当前列向左移, M-S-<left> 删除当前列, M-S-right 在当前列的左边添加一列, C-c - 增加一行分隔线

;; 定义锚点 <<link>>, 基于锚点生成链接 [[link][desc]]

;; (add-hook 'org-mode-hook (lambda() (setq truncate-lines nil))) ;; 实现自动换行
;; (add-hook 'text-mode-hook 'turn-on-auto-fill)
;; (add-hook 'text-mode-hook '(lambda() (set-fill-column 80)))
;; (setq org-startup-truncated nil)            ;; 自动换行

;; M-x org-md-export-as-markdown 可以将当前 org 文件转换成 md 并在一个新 buffer 中显示
;; M-x org-md-export-to-markdown 将当前 org 文件转换成 md 文件, 与当前 org 同目录同名
(eval-after-load "org" '(require 'ox-md nil t)) ;; C-c C-e 里面导出成 markdown 格式的选项

;; (setq org-startup-indented 'indent)      ;; 缩进, 开启后会在段落间自动缩进
(setq org-support-shift-select t)           ;; shift + 方向键可以选取
(setq org-src-fontify-natively t)           ;; 代码编辑时高亮
(setq org-export-with-toc t)                ;; 生成目录表
(setq org-export-with-sub-superscripts nil) ;; 禁用下划线转义

(setq org-html-postamble 'auto)      ;; 如果想不生成尾, 这里可以设置成 nil
(setq org-html-validation-link nil)  ;; 不生成 w3c 那个检查链接

(setq org-twbs-postamble 'auto)      ;; 跟上面的类似, 只不过这是 tw
(setq org-twbs-validation-link nil)

;; org-impress-js-export-to-html 报错: org-impress-js-headline: Symbol's function definition is void: org-export-get-headline-id
;; org-html5slide-export-to-html 报错: org-html5slide-headline: Symbol's function definition is void: org-html-format-headline--wrap

;; org-html-export-to-html 生成的是最原始的 html 文件
;; org-twbs-publish-to-html 基于 bootstrap 生成的 html 文件
;; org-ioslide-export-to-html 导出的 html 炫酷有了...
;; org-gfm-export-to-markdown 可以把 org 转换成 md. 比 C-c C-e 里面的好很多

;; 当 M-x org-publish-project 之后显示 Skipping unmodified file, 使用 C-u M-x org-publish

(setq org-publish-project-alist
	  (list
	   '("local"
		 :base-directory "~/org/"
		 :publishing-directory "~/org/"
         :publishing-function org-twbs-publish-to-html)

	   '("remote"
	     :base-extension "org"
		 :base-directory "~/org/"
		 :publishing-directory "/ssh:user@ip:~/interface/"
         :publishing-function org-twbs-publish-to-html)
))
