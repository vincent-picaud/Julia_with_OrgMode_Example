;; Use your own packages for classical stuff
(package-initialize)
;; requires Emacs speaks statistics, Org
(require 'ess-site)
(require 'org)

;; removes ugly horizontal lines in html-exported code 
;; (not mandatory)
(setq org-html-keep-old-src t)

;; As ob-julia.el and ox-bibtex are less common, 
;; we use a local repository.
;;
;; Usage: emacs -q --load emacs_files/init.el
;;
;; In a more usual setting one should use:
;; (require 'ob-julia.el)
;; (require 'ox-bibtex)
(load-file "emacs_files/ob-julia.el") ; works with ess-site, our notebook engine
(load-file "emacs_files/ox-bibtex.el"); used for bibliography HTML-export 

;; allows julia src block (requires ob-julia.el)
(setq org-confirm-babel-evaluate nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((julia . t)))

;; defines image width in the OrgMode buffer (this is not for html
;; exports, for this you must use #+HTML_ATTR: :width 900px for
;; instance)
;;
;; This is not mandatory, but useful when one uses the gr() Plots.jl
;; backend as it exports wide .png files. CAVEAT: use imagemagick for
;; image resizing.
;;
(setq org-image-actual-width (/ (display-pixel-width) 4))

;; uses the minted package instead of the listings one
(setq org-latex-listings 'minted)

;; defines how to generate the pdf file using lualatex + biber
(setq org-latex-pdf-process
      '("lualatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "biber %b"
	"lualatex -shell-escape -interaction nonstopmode -output-directory %o %f"
	"lualatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
