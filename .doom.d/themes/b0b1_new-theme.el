(deftheme b0b1_new
  "Created 2020-08-16.")

(custom-theme-set-faces
 'b0b1_new
 '(default ((t (:family "agave Nerd Font" :foundry "PfEd" :width normal :height 113 :weight normal :slant normal :underline nil :overline nil :extend nil :strike-through nil :box nil :inverse-video nil :foreground "#f8f8f2" :background "#272727" :stipple nil :inherit nil))))
 '(cursor ((t (:background "#bd93f9"))))
 '(fixed-pitch ((t (:family "agave Nerd Font" :foundry "PfEd" :width normal :height 113 :weight normal :slant normal))))
 '(variable-pitch ((t (:family "Luxi Sans" :foundry "B&H " :width normal :height 98 :weight normal :slant normal))))
 '(escape-glyph ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "brown"))))
 '(homoglyph ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "brown"))))
 '(minibuffer-prompt ((t (:foreground "#bd93f9"))))
 '(highlight ((t (:background "#515151" :foreground "#000000"))))
 '(region ((t (:extend t :background "#44475a"))))
 '(shadow ((t (:foreground "#6272a4"))))
 '(secondary-selection ((t (:extend t :background "#565761"))))
 '(trailing-whitespace ((t (:background "#ff5555"))))
 '(font-lock-builtin-face ((t (:foreground "#ffb86c"))))
 '(font-lock-comment-delimiter-face ((t (:inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((t (:foreground "#6272a4"))))
 '(font-lock-constant-face ((t (:foreground "#8be9fd"))))
 '(font-lock-doc-face ((t (:foreground "#8995ba" :inherit (font-lock-comment-face)))))
 '(font-lock-function-name-face ((t (:foreground "#50fa7b"))))
 '(font-lock-keyword-face ((t (:foreground "#ff79c6"))))
 '(font-lock-negation-char-face ((t (:foreground "#bd93f9" :inherit (bold)))))
 '(font-lock-preprocessor-face ((t (:foreground "#bd93f9" :inherit (bold)))))
 '(font-lock-regexp-grouping-backslash ((t (:foreground "#bd93f9" :inherit (bold)))))
 '(font-lock-regexp-grouping-construct ((t (:foreground "#bd93f9" :inherit (bold)))))
 '(font-lock-string-face ((t (:foreground "#f1fa8c"))))
 '(font-lock-type-face ((t (:foreground "#bd93f9"))))
 '(font-lock-variable-name-face ((t (:foreground "#f8f8f2"))))
 '(font-lock-warning-face ((t (:inherit (warning)))))
 '(button ((t (:inherit (link)))))
 '(link ((t (:weight bold :underline (:color foreground-color :style line) :foreground "#bd93f9"))))
 '(link-visited ((t (:foreground "violet" :inherit (link)))))
 '(fringe ((t (:foreground "#565761" :inherit (default)))))
 '(header-line ((t (:foreground "#f8f8f2" :background "#282a36"))))
 '(tooltip ((t (:foreground "#f8f8f2" :background "#1E2029"))))
 '(mode-line ((t (:box nil :background "#282a36"))))
 '(mode-line-buffer-id ((t (:weight bold))))
 '(mode-line-emphasis ((t (:foreground "#bd93f9"))))
 '(mode-line-highlight ((t (:inherit (highlight)))))
 '(mode-line-inactive ((t (:box nil :foreground "#6272a4" :background "#242530"))))
 '(isearch ((t (:weight bold :inherit (lazy-highlight)))))
 '(isearch-fail ((t (:weight bold :foreground "#1E2029" :background "#ff5555"))))
 '(lazy-highlight ((t (:weight bold :foreground "#f8f8f2" :background "#0189cc"))))
 '(match ((t (:weight bold :foreground "#50fa7b" :background "#1E2029"))))
 '(next-error ((t (:inherit (region)))))
 '(query-replace ((t (:inherit (isearch))))))

(provide-theme 'b0b1_new)
