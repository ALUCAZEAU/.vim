" ----------------------------------------------------------------------------------------------------
"
" @file         .vimrc
" @description  Fichier de configuration mini pour vim
" @author       Alexandre LUCAZEAU
" @version      23112017
" A lire https://github.com/mhinz/vim-galore#undo-files
" ----------------------------------------------------------------------------------------------------
"
" Syntax
" ======
" Active la coloration syntaxique
" ----------------------------------------------------------------------------------------------------
syntax on

" Definit la coloration syntaxique sur sh
" ----------------------------------------------------------------------------------------------------
"set ft=sh

" On desactive la detection automatique du type de fichier. On l'active plus tard. Necessaire pour assurer un chargement correcte de vundle
" ----------------------------------------------------------------------------------------------------
filetype off

" Chiffrage du fichier en blowfish2 avec :X
" =========================================
set cm=blowfish2

" Recherche
" =========
" Active la recherche incrémentale (fait la recherche au fur et a mesure qu'on la tappe)
" ----------------------------------------------------------------------------------------------------
set incsearch

" Ignore la casse des caractères lors d'une recherche
" ----------------------------------------------------------------------------------------------------
set ignorecase

" Si on utilise une majuscule dans la recherche, celle-ci redevient sensible à la casse
" ----------------------------------------------------------------------------------------------------
set smartcase

" coloration des mots recherchés
" ----------------------------------------------------------------------------------------------------
set hlsearch

" Historique
" ==========
" Concerve 50 commandes et 50  motifs de recherche
" ----------------------------------------------------------------------------------------------------
set history=50

" Affichage
" =========
" Fond sombre
" ----------------------------------------------------------------------------------------------------
set background=dark 

" Affiche la position courante en bas à droite de la fenêtre
" ----------------------------------------------------------------------------------------------------
set ruler

" Affiche la commande en cours, à gauche de la commande précédente - ou les caractères/lignes sélectionnees en mode visuel
" ----------------------------------------------------------------------------------------------------
set showcmd

" Affiche le mode courant en bas à gauche de la fénétre
" ----------------------------------------------------------------------------------------------------
set showmode

" Affiche la ligne contenant le curseur : mode MVS active :-)
" ----------------------------------------------------------------------------------------------------
set  cursorline 

" Affiche la parenthèse correspondante
" ----------------------------------------------------------------------------------------------------
set showmatch

" % permet de naviguer de ( à ) ou de [ à ] ou { à } while done ou if ou ... - specifique vim 8
" ----------------------------------------------------------------------------------------------------
packadd! matchit

" Affiche le numéro des lignes
" ----------------------------------------------------------------------------------------------------
set nu

" Active le mode 256 couleurs (pour le mode terminal)
" ----------------------------------------------------------------------------------------------------
if ! has("gui_running")
	set t_Co=256
endif

" Schémas de couleurs par defaut a desert
" ----------------------------------------------------------------------------------------------------
colorscheme desert

" Définition de la police du GUI
" ----------------------------------------------------------------------------------------------------
set guifont=Courier\ 14

" Completion
" ==========
" Affiche le menu
" ----------------------------------------------------------------------------------------------------
set  wildmenu

" Affiche toute les possibilités
" ----------------------------------------------------------------------------------------------------
set  wildmode =list:longest,list:full

" Raccourcis clavier
" ==================
" En mode visuel : la commande p écrase la sélection visuel avec son contenu
" ----------------------------------------------------------------------------------------------------
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

" Active la completion avec les touches ctrl-espace
" ----------------------------------------------------------------------------------------------------
imap  <C-Space> <C-X><C-O> 

" Supprime tout les blancs en début de ligne
" ----------------------------------------------------------------------------------------------------
nmap _s :%s/^\s\+//<CR>

" Supprime tout les blancs en début de ligne
" ----------------------------------------------------------------------------------------------------
nmap _S :%s/\s\+$//<CR>

" Supprime tout les ^MD 
" ----------------------------------------------------------------------------------------------------
nmap _m :%s/^M//<CR>

" Exécute le fichier actuel avec sh
" ----------------------------------------------------------------------------------------------------
map <F9> :!/bin/sh %<cr>

" Permettre l'utilisation du <Shift> Insert pour coller
" ----------------------------------------------------------------------------------------------------
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse> 

" Affiche ou non les espaces et tabulations via la touche F12
" ----------------------------------------------------------------------------------------------------
noremap <F12> :call AfficheTab()<cr>
inoremap <F12> <Esc>:call AfficheTab()<cr>a

" Backups
" ----------------------------------------------------------------------------------------------------
set backup

" sauvegarder les fichier ~ dans ~/.vim/backup avec création du répertoire si celui-ci n'existe pas
if filewritable(expand("~/.vim/backup")) == 2
	set backupdir=$HOME/.vim/backup
else
	if has("unix") || has("win32unix")
		call system("mkdir $HOME/.vim/backup -p")
		set backupdir=$HOME/.vim/backup
	endif
endif

" Fichiers swp
" ----------------------------------------------------------------------------------------------------
" sauvegarder les fichier ~ dans ~/.vim/swap avec création du répertoire si celui-ci n'existe pas
if filewritable(expand("~/.vim/swap")) == 2
	set directory=$HOME/.vim/swap
else
	if has("unix") || has("win32unix")
		call system("mkdir $HOME/.vim/swap -p")
		set directory=$HOME/.vim/swap
	endif
endif

" Fichiers undo - active la persistence des undo et les sauvegardes dans le
" repertoire ~/.vim/undofile
" ----------------------------------------------------------------------------------------------------
set undofile
" sauvegarder les fichier undo dans ~/.vim/undofile avec création du répertoire si celui-ci n'existe pas
if filewritable(expand("~/.vim/undofile")) == 2
	set undodir=$HOME/.vim/undofile
else
	if has("unix") || has("win32unix")
		call system("mkdir $HOME/.vim/undofile -p")
		set undodir=$HOME/.vim/undofile
	endif
endif

" Affiche ou non les espaces et tabulations
" ----------------------------------------------------------------------------------------------------
function! AfficheTab()
	if &list
		set nolist
	else
		set list
	end
endfunction

" Divers
" ======
" Désactivation de la rétrocompatibilite
" ----------------------------------------------------------------------------------------------------
set nocp

" Une tabulation = 4 caractères
" ----------------------------------------------------------------------------------------------------
set ts=4

" Place automatiquement un buffer modifié en mode caché lorsqu'on le quitte. Permet de passer d'un
" buffer à l'autre même en cas de changements non enregistré - visible par un
" h devant le nom du fichier lors de l'utilisation de la commande :ls
" ----------------------------------------------------------------------------------------------------
set hidden

" indentation automatique
" ----------------------------------------------------------------------------------------------------
set smartindent

" Nombre d'espace ajouter par >
" ----------------------------------------------------------------------------------------------------
set shiftwidth=4

" Inserer des espaces lorsque l'on utilise la touche tabulation ou > - si
" autoindent est activé
" ----------------------------------------------------------------------------------------------------
set expandtab

" Remplace le bip par un flash d'écran lors d'erreurs 
" ----------------------------------------------------------------------------------------------------
set noerrorbells visualbell t_vb=

" Permet au backspace de supprimer l'espace blanc au début d'une ligne, a supprimer une coupure de ligne et aussi les caractères avant la position d'o l'insertion avait debutee.
" ----------------------------------------------------------------------------------------------------
set backspace=indent,eol,start

" Defini des >--- pour chaque tabulation et - pour chaque espace de fin de lignes
" Pour afficher les espaces et tabulations : set list
" ----------------------------------------------------------------------------------------------------
set listchars=tab:>-,trail:-

" Place le curseur ou il etait lors de la fermeture du fichier
" ----------------------------------------------------------------------------------------------------
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

function! FyleType()
let type =  &fileformat
        return type
endfunction

function! TypeDist()
let DIST = matchstr( bufname('%'), '[a-z]\{3}')
if DIST == 'ftp'
    return '['.DIST.'] '
elseif DIST == 'scp'
	return '['.DIST.'] '
else
    let DIST = ''
    return DIST
endif
endfunction

""""""""""""""""""""""""""""""
" ag au lieu de grep
" ============================
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
"set statusline=\ %{HasPaste()}%F%m%r%\ %w\ \ WorkDir:\ %r%{getcwd()}%h\ \ \ Line:\ %l/%L:%c
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
set statusline=\ %{HasPaste()}\ %{TypeDist()}%f%m%r%h\ %w\ \ [%{FyleType()}]\ CWD:\ %r%{getcwd()}%h\ \ \ Hexa:\ %B\ %=Ligne:\ %l/%L\ %P\ Colonne:%c\ Buffer:%n

" Vundle
" ======
" On ajoute le repertoire de vundle au path de vim
" ----------------------------------------------------------------------------------------------------
set rtp+=~/.vim/bundle/vundle/

" On charge vundle
call vundle#rc()
" ----------------------------------------------------------------------------------------------------

" Les plugins que l'on desire gerer avec vundle, vundle est le premier :D
" ----------------------------------------------------------------------------------------------------
Bundle 'gmarik/vundle'

" peaksea => plugin couleur
" ----------------------------------------------------------------------------------------------------
Bundle 'peaksea'
colorscheme peaksea

Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'

" Pour du markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" Templates
Plugin 'git://github.com/aperezdc/vim-template.git'
" On active l'indentation automatique si les commandes automatiques sont activees
" ----------------------------------------------------------------------------------------------------
if has("autocmd") 
  filetype plugin indent on 
endif 


au! BufNewFile,BufRead *.csv setf csv
