EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs
FILEIN=$1
$EMACS -Q --eval "(progn
    (add-to-list 'load-path (expand-file-name \"~/lib/emacs/org\"))
    (add-to-list 'load-path (expand-file-name \"~/lib/emacs\")))" \
    --load=$HOME/.org.el --batch --visit=$FILEIN \
    --funcall org-leanpub-export-to-markdown
