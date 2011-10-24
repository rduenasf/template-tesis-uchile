\ProvidesClass{templates/uchile-tesis}

%  Tesis se parace mucho a un report
\LoadClass[11pt]{report}

% geometry - Margin package
\usepackage[right=2cm,left=3cm,top=2cm,bottom=2cm,headsep=0cm,footskip=1cm]{geometry}

%  amsmath, amsthm, amssymb - Mathematical packages
\usepackage{amsmath} \usepackage{amsthm} \usepackage{amssymb}

% subfig - Used to have subfigures within figures, or subtables within table floats
\usepackage{subfig}

% xspace - text macros
\usepackage{xspace}

% inputec, babel, blindtext ::  Español + UTF8
\usepackage[utf8x]{inputenc}

\usepackage[spanish, english, latin]{babel}
\usepackage{blindtext}
\selectlanguage{spanish}

\PrerenderUnicode{áéíóúÁÉÍÓÚüÜ}
\decimalpoint

% clrscode3e - Typeset pseudo-code "Intro to Algorithms" style
%\usepackage{packages/clrscode3e}
%\usepackage{packages/algorithmic}

% graphicx - logo and graphics
\usepackage[pdftex]{graphicx}
\graphicspath{{images/templates/}}
\DeclareGraphicsExtensions{.pdf,.png,.jpeg,.jpg}

% multirow - necesario para insertar bien el logo
\usepackage{multirow}

% Mostrar lista de cosas pendientes
\newif{\if@uchiletesis@showtodolist}
\@uchiletesis@showtodolisttrue
\DeclareOption{notodo}{\@uchiletesis@showtodolistfalse}

% Logo
\newif{\if@uchiletesis@bwlogo}
\@uchiletesis@bwlogofalse
\DeclareOption{bwlogo}{\@uchiletesis@bwlogotrue}

% Spacing
\DeclareOption{singlespace}{\gdef\@space{1.0}}%Espacio Simple
\DeclareOption{doublespace}{\gdef\@space{2.0}}%Espacio Doble
\DeclareOption{defaultspace}{\gdef\@space{1.5}}%Espacio y Medio
\ExecuteOptions{defaultspace}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

%% Definimos nuevos comandos para definir la portada
\newcommand{\departamento}{\gdef\@departamento}
\newcommand{\facultad}{\gdef\@facultad}
\newcommand{\trabajoygrado}{\gdef\@trabajoygrado}
\newcommand{\trabajoysubgrado}{\gdef\@trabajoysubgrado}
\newcommand{\pais}{\gdef\@pais}
\newcommand{\ciudad}{\gdef\@ciudad}
\newcommand{\yearpub}{\gdef\@year}
\newcommand{\monthpub}{\gdef\@month}
\newcommand{\profguia}{\gdef\@profguia}
\newcommand{\profcoguia}{\gdef\@profcoguia}
\newcommand{\profint}{\gdef\@profint}
\newcommand{\profinta}{\gdef\@profinta}
\newcommand{\profintb}{\gdef\@profintb}
\newcommand{\proyecto}{\gdef\@proyecto}

% hyperref - Pdftex hypertext
\usepackage[
    colorlinks=true
    , unicode=true
    , pdftex
    , pdfborderstyle={/S/U/W 0}
    , pdfusetitle
]{hyperref}

% cite - must go after hyperref, used to add cite references
\usepackage{cite}

\if@uchiletesis@showtodolist
\usepackage[colorinlistoftodos, textwidth=3cm]{todonotes}
\reversemarginpar
\setlength{\marginparwidth}{2.64cm}
\else
\usepackage[disable]{todonotes}
\fi

\if@uchiletesis@bwlogo
\gdef\@logofile{escudo}
\else
\gdef\@logofile{escudocolor}
\fi

%%%%%%%%%%%%%%%%%%%%%%
%Constants used in the class
%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\bibliographyname}{Referencias}

% Definimos el espacio a usar
\renewcommand{\baselinestretch}{\@space}

% Portada
\renewcommand{\maketitle}{%
    \thispagestyle{empty}
    \renewcommand{\baselinestretch}{1}
    \begin{tabular}{ll}
        \multirow{3}{*}{\includegraphics[height=84pt,width=42pt]{\@logofile}}
        &\\
        &\large{\MakeUppercase{Universidad de Chile}}\\
        &\large{\MakeUppercase{\@facultad}}\\
        &\large{\MakeUppercase{\@departamento}}\\
        &\\
    \end{tabular}
    \begin{center}
        \vskip 1.75cm%
            {\large \MakeUppercase{\@title}}\\
        \vskip 1.75cm%
            {\large \MakeUppercase{\@trabajoygrado}}\\
        \ifx \@trabajoysubgrado \undefined
            \vskip 0.33cm
            \vskip 0.75cm
            \vskip 11pt
        \else
            \vskip 0.75cm
                {\large \MakeUppercase{\@trabajoysubgrado}}\\
        \fi
        \vskip 1.75cm%
            {\large \MakeUppercase{\@author}}\\
        \vskip 1.0cm%
            \MakeUppercase{Profesor guía:}\\
            \MakeUppercase{\@profguia}\\
        \vskip 0.75cm
            \MakeUppercase{Miembros de la Comisión:}\\
            \MakeUppercase{\@profcoguia}\\
            \MakeUppercase{\@profint}\\
            \ifx \@profinta \undefined
                \vskip 0.33cm
                \vskip 11pt
            \else
                \MakeUppercase{\@profinta}\\
            \fi
            \ifx \@profintb \undefined
                \vskip 0.33cm
                \vskip 11pt
            \else
                \MakeUppercase{\@profintb}\\
            \fi
        \vskip 0.75cm%
            \begin{small}
                \MakeUppercase{\@ciudad{} de \@pais}\\
                \MakeUppercase{\@month{} \@year}\\
            \end{small}
        \vskip 1cm%
            \ifx \@proyecto \undefined
                {}
            \else
                \begin{footnotesize}
                    \begin{tabular}{c}
                        \hline
                        \\
                        \@proyecto\\
                        \\
                        \hline
                    \end{tabular}
                \end{footnotesize}
            \fi
    \end{center}
    \newpage
}

%% Cambiamos section cuando estamos en el prefacio
\let\oldsection=\section
\let\oldthesection=\thesection
\newenvironment{preface}{
        \pagenumbering{roman}
        \pagestyle{plain}
        \renewcommand{\section}[1]{%
            \cleardoublepage
            \phantomsection
            \addcontentsline{toc}{chapter}{##1}
            \chapter*{##1}
        }
}{
        \newpage
        \pagenumbering{arabic}
        \pagestyle{headings}
        \let\section=\oldsection
}
\newenvironment{additional}{
        \renewcommand{\section}[1]{%
            \cleardoublepage
            \phantomsection
            \addcontentsline{toc}{chapter}{##1}
            \chapter*{##1}
        }
}{
        \newpage
        \let\section=\oldsection
}

% Appendix
\renewenvironment{appendix}{
     \phantomsection
       \addcontentsline{toc}{chapter}{Apéndices}
    \chapter*{Apéndices}
        \setcounter{section}{0}

    \renewcommand{\thesection}{
        \Alph{section}
    }
}{
        \let\thesection=\oldthesection
}

% Insertar grafica
\newcommand{\grafica}[4]{
    \begin{figure}[!ht]
        \begin{center}
            \includegraphics[scale=#4]{#1}\\
        \end{center}
        \caption{{\small #2}}
        \label{#3}
    \end{figure}
}

%%%%%%%%%%%%%%%%%
%modifications to bibliography
%%%%%%%%%%%%%%%%%
%save the old bibliography
\let\oldbiblio=\bibliography
%redefine the bibliography in order to get the names we want and listed in the index
\renewcommand{\bibliography}[2]{
    %add it to the index
    \cleardoublepage
    \phantomsection
    \addcontentsline{toc}{chapter}{\bibliographyname}
    %change the name to what we want
    \renewcommand{\bibname}{\bibliographyname}
    %call the old bibilo command
    \oldbiblio{#1}{#2}
\newpage
}

\newcommand{\dedicatoria}[1]{
    \newpage
    \thispagestyle{empty}
    \subsubsection*{}
    \vskip 5cm
    \begin{flushright}
        \emph{#1}
    \end{flushright}
}


% Comandos personalizados para el paquete todonotes
\if@uchiletesis@showtodolist
% fillup - agregar un comentario rojo señalando que hay que llenar un texto
    \newcommand{\fillup}[1]{%
        \todo[color=red!20!white, inline, caption={Completar sección \thesubsection{}}]{%
        \begin{minipage}{\linewidth}\Blindtext[#1][1]\end{minipage}%
        }%
    }

% missing reg - agregar "citation needed " todos
    \newcounter{missingReferenceItems}
    \addtocounter{missingReferenceItems}{1}
    \newcommand{\missingref}[2][]{%
        \renewcommand{\@todonotes@text}{#2}%
        \renewcommand{\@todonotes@caption}{\protect\hypertarget{todo\themissingReferenceItems}{}\textbf{Agregar referencia:} #2}%
        \setkeys{todonotes}{noline, color=green!40, #1}%
        \if@todonotes@localdisable%
        \else%
            \addtocounter{@todonotes@numberoftodonotes}{1}%
            \if@todonotes@appendtolistoftodos%
                \phantomsection%
                \if@todonotes@captiongiven%
                \else%
                    \renewcommand{\@todonotes@caption}{\protect\hypertarget{todo:missingref:\themissingReferenceItems}{}\textbf{Agregar referencia \#\themissingReferenceItems:} #2}%
                \fi%
                \@todonotes@addElementToListOfTodos
            \fi%
            \textbf{\hyperlink{todo:missingref:\themissingReferenceItems}{[\themissingReferenceItems]}}%
            \addtocounter{missingReferenceItems}{1}%
        \fi}%
\else
% fillup - agregar un comentario rojo señalando que hay que llenar un texto
    \newcommand{\fillup}[2][]{}

% missing reg - agregar "citation needed " todos
    \newcommand{\missingref}[2][]{\textbf{[?]}}
\fi