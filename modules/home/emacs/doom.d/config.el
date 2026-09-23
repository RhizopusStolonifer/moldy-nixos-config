;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Rhizopus Stolonifer"
      user-mail-address "you@protonmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13)
(setq doom-font (font-spec :family "Maple Mono" :size 16))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/sync/org")
(setq org-roam-directory "~/sync/org")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell (executable-find "zsh"))
(setq-default explicit-shell-file-name (executable-find "zsh"))

(use-package! evil-ledger
  :hook (ledger-mode . evil-ledger-mode))

(use-package! hledger-mode :mode ("\\.journal\\'" . hledger-mode) :config (setq hledger-jfile "~/sync/finance/ledger.journal"))
;; (load! "ob-hledger")
(after! org (add-to-list 'org-capture-templates '("l" "Ledger transaction" plain (file "~/sync/finances/ledger.journal") "\n%(org-read-date) * %^{Payee}\n Expenses:%^{Category} $%^{Amount}\n Liabilities:CIBC:MoldyCredit\n")))

(use-package org
  :config
  (org-babel-do-load-languages
   'org-babel-do-load-languages
   '((python . t)
     (R . t)
     (emacs-lisp . t)))
  (setq org-confirm-babel-evaluate nil)
  (setq org-babel-python-command "python3"))

(after! org-roam
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :target (file+head "${slug}.org" "#+title: ${title}\n")
           :unnarrowed t))))

;; org-roam-ui
(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(add-to-list 'load-path "/etc/profiles/per-user/myco/share/emacs/site-lisp/mu4e")

(after! mu4e
  (setq mu4e-maildir "~/mail/proton"
        mu4e-change-filenames-when-moving t
        mu4e-update-interval (* 10 60)
        mu4e-get-mail-command "mbsync -a"
        mu4e-compose-format-flowed t
        mu4e-maildir-shortcuts
        '(("/proton/inbox"    . ?i)
          ("/proton/Sent"     . ?s)
          ("/proton/Trash"    . ?t)
          ("/proton/Drafts"   . ?d)
          ("/proton/All Mail" . ?a)))

  (set-email-account! "proton"
                      '((mu4e-sent-folder     . "/proton/Sent")
                        (mu4e-drafts-folder   . "/proton/Drafts")
                        (mu4e-trash-folder    . "/proton/Trash")
                        (mu4e-refile-folder   . "/proton/All Mail")
                        (smtpmail-smtp-user   . "you@protonmail.com")
                        (smtpmail-smtp-server . "127.0.0.1")
                        (smtpmail-smtp-service . 1025)
                        (smtpmail-stream-type  . ssl)
                        (user-mail-address     . "raskpaul@protonmail.com"))
                      t)

  (setq auth-sources '("/run/secrets-rendered/mu4e-authinfo")))

(after! org-msg
  (setq org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil author:nil email:nil \\n:t"
        org-msg-startup "hidestars indent inlineimages"
        org-msg-default-alternatives '((new           . (text html))
                                       (reply-to-html . (text html))
                                       (reply-to-text . (text)))
        org-msg-convert-citation t)
  (org-msg-mode))
