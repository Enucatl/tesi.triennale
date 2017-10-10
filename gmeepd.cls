%
%
% gmeepd.cls - document style used at GMEE/unipd group
%
%

%
% this file is encoded ISO 8859-15
%

% - revision history ------------------------------------------------------
% 2009.11.11  fixed \Cover (work) bugs, 
%             amsmath package added
%             fontsize support for a4book page format
%             more up-to-date package 'subfig' included instead of 'subfigure'
% - revision history end ------------------------------------------------------


% =========================================================================
%    1. IDENTIFICATION
% =========================================================================

% identify itself

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gmeepd}[2009/11/11; complex documents (thesis, books, course material...) - ver.1.3]

% =========================================================================
%    2. INITIAL CODE
% =========================================================================

%% --- packages needed for initial processing
\RequirePackage{ifthen}  	% conditional expressions
\RequirePackage{calc}           % calculations
\RequirePackage{xkeyval} 	% key/values (options handling of this class)

% \className,\classVersion can be used (later or in the user document) for debugging purposes 
\newcommand{\className}{gmeepd}  
\newcommand{\classVersion}{1.3} 

% -----------------------------------------------------------------------
%   set default values for variables associated to class options
% -----------------------------------------------------------------------

\newcommand{\GMbookType}{a4book}        % bookType
\newcommand{\GMfileEncoding}{latin1}    % encoding (ISO 8859-15)
\newcommand{\GMfontsize}{12pt}          % fontsize
\newlength{\GMfontlength} \setlength{\GMfontlength}{12pt} % font size, length variable
\newcommand{\GMlanguage}{en}            % language
\newcommand{\GMcover}{nocover}          % cover type, 
\newcommand{\GMcoverFile}{} 	        % optional external file containing cover definition
\newcommand{\GMforeignCover}{false}     % foreignCover
\newcommand{\GMdocumentStatus}{normal}  % status
\newcommand{\GMusercmd}{res/usercmd.input.tex}  % user's macro


% \gmdocumentStatus determine the behavior of some macros: 
% - normal:   \showDraft does nothing, secret text will not be printed 
% - reserved: \showDraft prints 'reserved', secret text will be printed
% - draft :   \showDraft prints 'draft' secret text wil not be printed
% - debug: ... tobedone


% =========================================================================
%    3. DECLARATION OF OPTIONS
% =========================================================================

% --- class options 
% bookType: a4book, lulu6x9, utet
%           the book type determines page size, geometry.etc.
% encoding: utf8, latin1, iso8859-15
%           encoding determine the file encoding expected by latex (default: latin1)
% fontsize: 10pt, 11pt, 12pt
%           fontsize is the size of font alongsize the document
% language: it, italiano, en. english
%           language is default language that will be used
% cover:    nocover, work (elaborato), dispensa, libro, thesis (tesi), tesina, tesiphd, user
%           determine the cover format
% foreigncover (true if option specified, false otherwise)
%           determine additional white pages to be inserted at the beginning
% coverfile <path to file> (e.g. res/sample-cover.tex)
%           define the file name containing a user's defined cover (when cover=user)
% status:   normal, draft, reserved, debug
%           determine the behavior of some macros, and how some text is printed 
%           in the ps/pdf file
% usercmd:  path to file where user commands are defined (default: res/usercmd.input.tex)
%

% --- declaration of class options
\DeclareOptionX{booktype}{\renewcommand{\GMbookType}{#1}}
\DeclareOptionX{encoding}[latin1]{\renewcommand{\GMfileEncoding}{#1}}
\DeclareOptionX{fontsize}[12pt]{\renewcommand{\GMfontsize}{#1}}
% \setlength{\GMfontlength}{#1}
\DeclareOptionX{language}[it]{\renewcommand{\GMlanguage}{#1}}
\DeclareOptionX{cover}[nocover]{\renewcommand{\GMcover}{#1}}
\DeclareOptionX{coverfile}{\renewcommand{\GMcoverFile}{#1}}
\DeclareOptionX{foreigncover}{\renewcommand{\GMforeignCover}{true}}
\DeclareOptionX{status}[normal]{\renewcommand{\GMdocumentStatus}{#1}}
\DeclareOptionX{usercmd}[res/usercmd.input.tex]{\renewcommand{\GMusercmd}{#1}}


% =========================================================================
%    4. EXECUTION OF OPTIONS
% =========================================================================

\ProcessOptions\relax
\ProcessOptionsX

% =========================================================================
%    5. PACKAGE LOADING 
% =========================================================================



% -----------------------------------------------------------------------
%     load document class 
%     defines page geometry, figure captions, header and footers
% -----------------------------------------------------------------------

\ifthenelse{\equal{\GMbookType}{a4book}}
{%
  %\LoadClass[a4paper,11pt]{book}
  \LoadClass[a4paper,\GMfontsize]{book}
  \RequirePackage[a4paper, hmargin={4cm, 3cm}]{geometry}
  \renewcommand{\floatpagefraction}{.2}   % default: .5
  \renewcommand{\textfraction}{.05}       % default: .2
  \renewcommand{\bottomfraction}{.7}      % default: .3
  \renewcommand{\topfraction}{.9}      % default: .3
  % caption style
  \RequirePackage[scriptsize,bf]{caption}
  \captionsetup[table]{position=top}
}{}

% --- define headers -------------------------------------------------
\RequirePackage{lastpage}        % provides a \pageref{LastPage} command 
\RequirePackage{fancyhdr}        % fancy headers

\pagestyle{fancy}
%\fancyheadoffset[LE,RO]{\marginparsep+\marginparwidth}
%\renewcommand{\chaptermark}[1]{\markboth{\thechapter \ #1}{}} % print chapter numeber with chapter name
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
%\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}
\renewcommand{\subsectionmark}[1]{\markright{\thesection\ #1}}
\fancyhf{} %clears all header and footer fields
\fancyhead[LE,RO]{\thepage}
\fancyhead[LO]{\rightmark}
\fancyhead[RE]{\leftmark}
% redefine plain style for pagestyle
\fancypagestyle{plain}{%
   \fancyhead{} % get rid of headers
   \renewcommand{\headrulewidth}{0pt} % and the line
}
% redefine headings style for pagestyle
\fancypagestyle{headings}{%
   \fancyhead{} % get rid of headers
   \fancyhead[LE,RO]{\thepage}
   \fancyhead[LO]{\nouppercase{\rightmark}}
   \fancyhead[RE]{\scshape\leftmark}
}
\captionsetup[subfigure]{labelformat=empty}
\captionsetup[subtable]{labelformat=empty}
% on float pages do not print the heading line
\renewcommand{\headrulewidth}{\iffloatpage{0pt}{0.4pt}}
%


% -----------------------------------------------------------------------
%     load packages 
% -----------------------------------------------------------------------

% --- file encoding and support to special characters
% resolve alias iso8859-15 for latin1
\ifthenelse{\equal{\GMfileEncoding}{iso8859-15}}{\renewcommand{\GMfileEncoding}{latin1}}
\RequirePackage[\GMfileEncoding]{inputenc}  % support to file encoding (utf-8, iso8859-15, ...)

\RequirePackage[T1]{fontenc}                % support to special characters (e.g.\`e...)

% --- define the main language (english/italian)
% resolve alias
\ifthenelse{\equal{\GMlanguage}{italiano}}{\renewcommand{\GMlanguage}{it}}
\ifthenelse{\equal{\GMlanguage}{english}}{\renewcommand{\GMlanguage}{en}}
% set language
\ifthenelse{\equal{\GMlanguage}{it}}%
{\RequirePackage[english,italian]{babel}}% default: italian
{\RequirePackage[italian,english]{babel}}% default english


\RequirePackage{amssymb}
\RequirePackage{textcomp}
\RequirePackage[nointegrals]{wasysym}  % simboli della serie 'wasy', non definisce simboli di integrale doppio ecc. definiti invece in amsmath


\RequirePackage{amsmath}


\RequirePackage{makeidx}            % indice analitico

\RequirePackage[dvips]{graphicx}    % inclusione graph images (eps)
\RequirePackage{psfrag}             % modification of string stored inside .eps file

\RequirePackage{color}
\RequirePackage{eepic}      % exten. to picture environ. to be used with xfig generated files
\RequirePackage{overpic}    % exten. to picture environ. to be used with xfig generated files
\RequirePackage{subfig}     % v.1.3 update
\RequirePackage{array}      % array and tabular formatting
\RequirePackage{tabularx}   % tabular formatting

% pdf generation
\RequirePackage[ps2pdf,bookmarks=true,bookmarksnumbered=true]{hyperref}
\RequirePackage[ps2pdf]{thumbpdf}         % thumbnails in pdf


% =========================================================================
%    6. MAIN CODE 
% =========================================================================

% global variables, initialized to void
\newcommand{\GMSecret}{}
\newcommand{\GMDraft}{}
\newcommand{\GMDebug}{}


% commands that changes the value of global variables
\newcommand{\Secret}[1]{\renewcommand{\GMSecret}{#1}}
\newcommand{\Draft}[1]{\renewcommand{\GMDraft}{#1}}
\newcommand{\Debug}[1]{\renewcommand{\GMDebug}{#1}}

\newcommand{\CoverFile}[1]{\renewcommand{\GMcoverFile}{#1}}

% --- set default values --- --- ---
\ifthenelse{\equal{\GMdocumentStatus}{reserved}}%
{\Secret{true}}%
{\Secret{false}}

\ifthenelse{\equal{\GMdocumentStatus}{draft}}%
{\Draft{true}}%
{\Draft{false}}

\ifthenelse{\equal{\GMdocumentStatus}{debug}}%
{\Debug{true}}%
{\Debug{false}}


% -----------------------------------------------------------------------------
% ---  text styles --- --- ---

% paragraphs
\newcommand{\tBeginPar}[1]{\textbf{#1}}

% font styles
\newcommand{\tDef}[1]{\textit{#1}}
\newcommand{\tDefObj}[1]{\textit{#1}}
\newcommand{\tDefTxt}[1]{\textit{#1}}
\newcommand{\tRemark}[1]{\emph{#1}}
\newcommand{\tREMARK}[1]{\textbf{\emph{#1}}}
\newcommand{\tCode}[1]{\texttt{#1}}
\newcommand{\tForeign}[1]{\emph{#1}}
\newcommand{\tLatin}[1]{\emph{#1}}
\newcommand{\tExample}[1]{\textit{#1}}
\newcommand{\tStandard}[1]{\textsl{#1}}

% quoting text
\newcommand{\tQuote}[1]{\textit{#1}}
\newcommand{\tQuoteFig}[1]{\textit{#1}}
\newcommand{\tConcept}[1]{\textit{#1}}

% --- special text 

% quotation marks
\newcommand{\qmo}{``}  % usage: \qmo{}
\newcommand{\qmc}{''}  % usage: ...\qmc{}

% segno di spunta
\newcommand{\Checkmark}{$\surd$} %segno di spunta

% -----------------------------------------------------------------------------
% --- environments --- --- ---
\newenvironment{quoteStandard}
{\begin{quote} \noindent \slshape }
{\end{quote}}


% -----------------------------------------------------------------------------
% --- various macros
%

% \prefacePageNumberign
% this command determine the first page where numebring should be roman .
% blank pages followin table of contents are talen into account
% this command should be used once at the very beginning of the main document, 
%i.e. just below the command \chaper*{Preface} or the equivalent one 
\newcommand{\prefacePageNumbering}{%
\ifthenelse{\equal{\GMforeignCover}{true}}
  { \pagenumbering{Roman} \setcounter{page}{5} }
  { \pagenumbering{Roman} \setcounter{page}{3} }
}

\newcommand{\Preface}{%
\ifthenelse{\equal{\GMlanguage}{en}}
{\chapter*{Preface} \addcontentsline{toc}{chapter}{Preface} \prefacePageNumbering }
{\chapter*{Prefazione} \addcontentsline{toc}{chapter}{Prefazione} \prefacePageNumbering }
}

\newcommand{\resetPageNumbering}{%
\renewcommand{\thepage}{\arabic{page}} \setcounter{page}{1}% page numbering reset to '1'
\pagestyle{headings}% reset heading style
}

% \ShowDraft
% 

% --- \ShowDraft
\newcommand{\ShowDraft}{%
\ifthenelse{\equal{\GMDraft}{true}}
  { \RequirePackage[firsttwo,light]{draftcopy} }%
  {}%
\ifthenelse{\equal{\GMSecret}{true}}
  { \RequirePackage[firsttwo,light]{draftcopy} 
    \draftcopyName{RESERVED}{140}%
  }%
  {}%
\ifthenelse{\equal{\GMDebug}{true}}
  { \RequirePackage[firsttwo,light]{draftcopy} 
    \draftcopyName{DEBUG}{140}%
  }%
}


% --- secret text handling --- --- ---
% \tSecret{secret text},                 % the 'secret text' will be shown only if \GMSecret=true
% \tAltSecret{secret text}{public text}  % 'secret text' will be shown if \GMSecret=true, otherwise 'public text will be shown'


% 
%\Secret{false} means that the document (from this point on) will be public
%\Secret{true} means that the document (from this point on) will be reserved


% \tSecret{text}, 'text' will be shown only if \GMSecret=true
\newcommand{\tSecret}[1]{%
\ifthenelse{\equal{\GMDebug}{true}}%
{\tRemark{ secret:}#1{}\marginpar{\tCode{tSecret}}}% 
{\ifthenelse{\equal{\GMSecret}{true}}{#1}}% show the secret text
}

% \tAltSecret{secret text}{public text}, 'secret text' will be shown if \GMSecret=true
%                                        otherwise the 'public text' will be shown
\newcommand{\tAltSecret}[2]{%
\ifthenelse{\equal{\GMDebug}{true}}%
{\tRemark{ secret:}#1{}\tRemark{ public:}#2{}\marginpar{\tCode{tAltsecret}}}
{%
\ifthenelse{\equal{\GMSecret}{true}}%
{#1} % secret text
{#2} % public (maybe fake), text
}}

% --- debug information handling --- --- --- 
% if ( \Debug definito e uguale a true) {
%    - abilita inverse search
%    - definisce \Index in modo che invochi \index E \ShowIndex }
% else {
%    definisce "\newcommand{\Index}[1]{\index{#1}}"
% }

%\ifthenelse{\isundefined{\Debug}}
%  { \newcommand{\Index}[1]{\index{#1}} }
%  {\ifthenelse{\equal{\Debug}{true}}
%     {%
%       \newcommand{\Index}[1]{\index{#1} \ShowIndex{#1}}
%     }%
%  { \newcommand{\Index}[1]{\index{#1}}  }}

% --- \ShowIndex --- --- ---
% mostra nota a margine con argomento 1
% \ShowIndex{index term}
\newcommand{\ShowIndex}[1]{\marginpar{index:\\ #1}}


\ifthenelse{\equal{\GMDebug}{true}}
{ \newcommand{\Index}[1]{\index{#1} \ShowIndex{#1}} }
{ \newcommand{\Index}[1]{\index{#1}}  }

% --- \PrintIndex ---
% adds to table of contents a proper entry depending on language, 
% then \printindex
\newcommand{\PrintIndex}{%
\clearpage
\ifthenelse{\equal{\GMlanguage}{it}}
{\addcontentsline{toc}{chapter}{Indice analitico}}
{\addcontentsline{toc}{chapter}{Index}}
\printindex \clearpage
}

\newcommand{\ListOfTables}{%
\clearpage
\ifthenelse{\equal{\GMlanguage}{it}}
{\addcontentsline{toc}{chapter}{Elenco delle tabelle}}
{\addcontentsline{toc}{chapter}{List of Tables}}
\listoftables \clearpage
}

\newcommand{\ListOfFigures}{%
\clearpage
\ifthenelse{\equal{\GMlanguage}{it}}
{\addcontentsline{toc}{chapter}{Elenco delle figure}}
{\addcontentsline{toc}{chapter}{List of Figures}}
\listoffigures \clearpage
}


%\Fig{eps-file}{short-caption}{caption}{label}
\newcommand{\Fig}[4]{%
\begin{figure}[hbp]%
    \centering
\includegraphics{images/#1}%
\caption[~#2]{#3} %
\label{fig:#4}%
\end{figure}%
}

% ----------------------------------------------------------------------------------------
% -----------------------------------------------------

%\FigPos{position}{eps-file}{short-caption}{caption}{label}
\newcommand{\FigPos}[5]{%
\begin{figure}[#1]%
    \centering
\includegraphics{images/#2}%
\caption[~#3]{#4}%
\label{fig:#5}%
\end{figure}%
}


%\FigScaled{eps-file}{short-caption}{caption}{label}{width}
\newcommand{\FigScaled}[5]{%
\begin{figure}[hbp]%
    \centering
\includegraphics[width=#5]{images/#1}%
\caption[~#2]{#3} %
\label{fig:#4}%
\end{figure}%
}

% \FigScaledLarge{position}{eps-file}{short-caption}{caption}{label}
\newcommand{\FigScaledLarge}[4]{\FigScaled{#1}{#2}{#3}{#4}{\textwidth}}


%\FigScaledPos{position}{eps-file}{short-caption}{caption}{label}{width}{position}
% inserts a figure, position is where the graphics is inserted (e.g. hb)
\newcommand{\FigScaledPos}[6]{%
\begin{figure}[#1]%
    \centering
\includegraphics[width=#6]{images/#2}%
\caption[~#3]{#4} %
\label{fig:#5}%
\end{figure}%
}



%    \FigRotatedScaled{eps-file}{short caption}{caption}{label}{height}
\newcommand{\FigRotatedScaled}[5]{%
\begin{figure}[hbp]%
    \centering
\includegraphics[angle=90,height=#5]{images/#1}%
\caption[~#2]{#3} %
\label{fig:#4}%
\end{figure}%
}
%\FigTwoVScaled{eps-file-top}{eps-file-bottom}{short-caption}{caption}{label}{width-top}{

% ----------------------------------------------------------------------------------------
% -----------------------------------------------------width-bottom}
\newcommand{\FigTwoVScaled}[7]{%
\begin{figure}[hbp]%
    \centering
    \subfloat[][]{\includegraphics[width=#6]{images/#1}}\\
    \subfloat[][]{\includegraphics[width=#7]{images/#2}}
\caption[~#3]{#4} \label{fig:#5}%
\end{figure}%
}

%\FigTwoHScaled{eps-file-left}{eps-file-right}{short-caption}{caption}{label}{width-right}{width-left}
\newcommand{\FigTwoHScaled}[7]{%
\begin{figure}[hbp]%
    \centering
    \makebox[\textwidth]{
    \subfloat[][]{\includegraphics[width=#6]{images/#1}}
    \subfloat[][]{\includegraphics[width=#7]{images/#2}}}
\caption[~#3]{#4} \label{fig:#5}%
\end{figure}%
}


% ----------------
%label=<lab> will be referred by in the amin text \ref{fig:<lab>}
%
\makeatletter
\def\GMdefaultFigfile{placeholder}% default file name of figure

% --- some useful graphixs rules
\DeclareGraphicsRule{.gif}{eps}{.gif.bb}{`convert #1 -monochrome 'eps:-' }
\DeclareGraphicsRule{.jpg}{eps}{.jpg.bb}{`convert #1 'eps:-' }
\DeclareGraphicsRule{.png}{eps}{.png.bb}{`convert #1 'eps:-' }
\DeclareGraphicsRule{.bmp}{eps}{.bmp.bb}{`convert #1 'eps:-' }
\DeclareGraphicsRule{.pdf}{eps}{.pdf.bb}{`convert #1 'eps:-' }
% --- --- ---


% --- graphics inclusion with optional width, height (and angle in any case specified)
\def\GMtmpA{}
%\GMincludeGraphics{\Figwidth}{\Figheight}{\Figangle}{\Figfile}
\newcommand{\GMincludeGraphics}[4]{% {\Figwidth}{\Figheight}{\Figangle}{\Figfile}
\ifthenelse{\equal{#3}{}}{\def\GMtmpA{0}}{\def\GMtmpA{#3}}
\ifthenelse{\equal{#1}{} \and \equal{#2}{} }% width, height not specified 
{\includegraphics[angle=\GMtmpA]{#4}}{}%
\ifthenelse{\equal{#1}{} \and \not \equal{#2}{}}% width specfied 
{\includegraphics[height=#2,angle=\GMtmpA]{#4}}{}%
\ifthenelse{\not \equal{#1}{} \and  \equal{#2}{}}% height specified
{\includegraphics[width=#1,angle=\GMtmpA]{#4}}{}%
\ifthenelse{\not \equal{#1}{} \and  \not \equal{#2}{}}% width and height specified
{\includegraphics[width=#1,height=#2,angle=\GMtmpA]{#4}}{}%
}%\GMincludeGraphics{\Figwidth}{\Figheight}{\Figangle}{\Figfile}

% counters for figure width and height 
\newlength{\IW} \newlength{\IH}
\newlength{\GMtmpLen}

%\define@boolkey{Fig}{shortcaption}[true]{}
%\define@boolkey{Fig}{eps}[true]{}
\define@key{Fig}{file}{\def\Figfile{images/#1.eps}}%
\define@key{Fig}{pos}{\def\Figpos{#1}}%
\define@key{Fig}{width}{\def\Figwidth{#1}}%
\define@key{Fig}{height}{\def\Figheight{#1}}%
\define@key{Fig}{label}{\def\Figlabel{#1}}%
\define@key{Fig}{shortcaption}{\def\Figshortcaption{#1}}%
\define@key{Fig}{angle}{\def\Figangle{#1}}
\define@boolkey{Fig}{rotate}[false]{}

\define@key{Fig}{fileL}{\def\FigfileL{images/#1.eps}}% left figure,   \Fig[]{}
\define@key{Fig}{fileR}{\def\FigfileR{images/#1.eps}}% right figure,  \Fig[]{}
\define@key{Fig}{widthL}{\def\FigwidthL{#1}}%
\define@key{Fig}{widthR}{\def\FigwidthR{#1}}%
\define@key{Fig}{heightL}{\def\FigheightL{#1}}%
\define@key{Fig}{heightR}{\def\FigheightR{#1}}%
\define@key{Fig}{angleL}{\def\FigangleL{#1}}%
\define@key{Fig}{angleR}{\def\FigangleR{#1}}%

\define@key{Fig}{fileUp}{\def\FigfileUp{images/#1.eps}}% top figure,   \Fig[]{}
\define@key{Fig}{fileDw}{\def\FigfileDw{images/#1.eps}}% bottom figure,\Fig[]{}
\define@key{Fig}{widthUp}{\def\FigwidthUp{#1}}%
\define@key{Fig}{widthDw}{\def\FigwidthDw{#1}}%
\define@key{Fig}{heightUp}{\def\FigheightUp{#1}}%
\define@key{Fig}{heightDw}{\def\FigheightDw{#1}}%
\define@key{Fig}{angleUp}{\def\FigangleUp{#1}}%
\define@key{Fig}{angleDw}{\def\FigangleDw{#1}}%

\define@key{Fig}{mode}{\def\Figmode{#1}}% left figure,   \Fig[]{}
% mode={}: one figure
% mode=horiz: two figures, fileL, fileR specify images
% mode=vert: two figures; fileUp,fileDw specify images
%% (not implemented yet) mode=tile: 4 figures: fileUpL, fileUpR, fileDwL, fileDwR specify images


%
%\define@key{Fig}{wi}{#1}%
%\define@key{Fig}{lw}{\GMiw{#1}} %\settowidth{\IW}{\includegraphics{#1}}}%
%\define@key{Fig}{hw}{\GMih{#1}} %\settoheight{\IH}{\includegraphics{#1}}}%
%
\presetkeys{Fig}%
 {file=\GMdefaultFigfile,pos={},width={},height={},label={},shortcaption={},angle=0,rotate=false,mode={},fileL=\GMdefaultFigfile,fileR=\GMdefaultFigfile,widthL={},widthR={},heightL={},heightR={},angleL=0,angleR=0,%
 fileUp=\GMdefaultFigfile,fileDw=\GMdefaultFigfile,widthUp={},widthDw={},heightUp={},heightDw={},angleUp={},angleDw={}}%
 {%lw=images/\usevalue{file}.eps,%
 %hw=images/\usevalue{file}.eps %
}
\savekeys{Fig}{shortcaption,eps,file,width,height,label,shortcaption,angle,rotate,mode,fileL,fileR,widthL,widthR,heightL,heightR,angleL,angleR,fileUp,fileDw,widthUp,widthDw,heightUp,heightDw,angleUp,angleDw}

\newcommand*\Figure[2][]{%
\setkeys{Fig}{#1}{%
  \ifthenelse{\equal{\Figwidth}{}}% width=... not used: set width to figure width 
  {\settowidth{\GMtmpLen}{\includegraphics{\Figfile}} \def\Figwidth{\GMtmpLen}} {}
  % if figure wider than textwidth resize to textwidth
  \ifthenelse{\lengthtest{\Figwidth > \textwidth}}{\def\Figwidth{\textwidth}}{}
  % if rotate=true: set angle=90
  \ifKV@Fig@rotate \def\Figangle{90} \fi {}
%
% -- debug code
\ifthenelse{\equal{\GMDebug}{true}}{%
 \mbox{} \\ \begin{center} --------- \texttt{\textbackslash{}Figure} ---------\\ \end{center}
 \noindent file=\Figfile{}  \par
 label='\Figlabel'{}  
 \ifthenelse{\not \equal{\Figlabel}{}}
 {\ref{fig:\Figlabel}}{}
 ~ pos=`\Figpos'{} 
 % non inserire: ~  width='\Figwidth'{} ~ height='\Figheight'{}  NON funziona! 
 ~ angle=`\Figangle{}' 
 \ifKV@Fig@rotate rotate figure \else (no rotate)\fi {} \par
 shortcaption=`{\Figshortcaption}' \par
 caption=`#2' \mbox{} \\
 \ifthenelse{\equal{\Figmode}{horiz}} 
 { Two  figures; mode=\Figmode\ \FigfileL\ \FigfileR\ }{}
 \ifthenelse{\equal{\Figmode}{vert}} 
 { Two  figures; mode=\Figmode\ \FigfileUp\ \FigfileDw\ }{}
}{}% end if \Debug
% - end debug ------
% --- show figure
\ifthenelse{\equal{\Figpos}{}}% 
{\begin{figure}} % pos not specified
{\begin{figure}[\Figpos]}% 
\begin{center}
\ifthenelse{\equal{\Figmode}{}}%
{\GMincludeGraphics{\Figwidth}{\Figheight}{\Figangle}{\Figfile}}{}
%
\ifthenelse{\equal{\Figmode}{horiz}}%
{% 
\begin{tabular}{@{}cc@{}}% 
\GMincludeGraphics{\FigwidthL}{\FigheightL}{\FigangleL}{\FigfileL}&%
\GMincludeGraphics{\FigwidthR}{\FigheightR}{\FigangleR}{\FigfileR}\tabularnewline%
\end{tabular}%\GMincludeGraphics{\Figwidth}{\Figheight}{\Figangle}{\Figfile}%
}{}% end if horiz
%
\ifthenelse{\equal{\Figmode}{vert}}%
{% 
\begin{tabular}{@{}c@{}}% 
\GMincludeGraphics{\FigwidthUp}{\FigheightUp}{\FigangleUp}{\FigfileUp}\tabularnewline%
\GMincludeGraphics{\FigwidthDw}{\FigheightDw}{\FigangleDw}{\FigfileDw}\tabularnewline%
\end{tabular}%
}{}% end if vert
%
% includegraphics:  \includegraphics[options]{\Figfile}
% test combination of width/height equal to {} or something
%---\caption
\ifthenelse{\equal{\Figshortcaption}{}}
{\caption{~#2}}
{\caption[~\Figshortcaption]{#2}}
%--- \label{}
\ifthenelse{\equal{\Figlabel}{}}%
{}% skip label 
{\label{fig:\Figlabel}}% insert label
\end{center}%
\end{figure}%
}% end \setkeys
}% end \newcommand Figi


% --- end \Figure -----------------------------------------------------------



% --- end figure macros --- --- ---
% -----------------------------------------------------------------------------


% -----------------------------------------------------------------------------
%  Cover definition
% 

% ---Interface---
% the user may use invoke the following commands in order to define the author name, 
% the title, etc: 
%
% \Author{<value>}                    all cover types
% \Title{<value>}                     all cover
% \Subtitle{<value>}                  [work], thesis
% \Date{<value>}                      work, thesis 
% \Advisor{<value>}                   tesi, phdthesis
% \CoAdvisor{<value>}                 [tesi]
% \Course{<value>}                    tesi
% \PhDCourse{<value>}                 phdthesis (ciclo dottorato)
% \Director{<value>}                  phdthesis
% 
% then, the macro '\Cover'  actually prints the cover
%
%
% --- Internals:
% 1. \GMcover  holds the cover type definition, 
%    it is defined by the 'cover=<coverType>' class option; possible values are:
%    nocover, work (elaborato) , tesina, thesis (tesi) thesis, phdthesis, user
%  when \GMcover=user, \GMcoverFile stores the name of an optional external file containing the
%   definition of the cover
%
% 2. the commands \Author{}, \Title{} modify corresponding macro \GMAuthor, \GMTitle, etc.
%    such commands stores useful strings
%
%  3. 'elaborato' is an alias for 'work'; 'elaborato'  is a deprecated value
% the commands \Author{}, \Title{} 
%
% --- default values for various title fields
% where this option is used [in brackets if optional]
%

%
% --- macro-key associated to user choiches '[]' denotes a key optionally defined by user
%
\newcommand{\GMAuthor}{}                    % all
\newcommand{\GMTitle}{}                     % all
\newcommand{\GMSubtitle}{}                  % [work], thesis
\newcommand{\GMDate}{\today}                % elaborato, thesis 
\newcommand{\GMAdvisor}{}                   % tesi, phdthesis
\newcommand{\GMCoAdvisor}{}                 % [tesi]
\newcommand{\GMCourse}{}                    % tesi
\newcommand{\GMphdCourse}{}                 % phdthesis
\newcommand{\GMDirector}{}                  % phdthesis
%
% ---user commands: they change the value of a corresponding macro-key 
%
\newcommand{\Author}[1]{\renewcommand{\GMAuthor}{#1}}
\newcommand{\Title}[1]{\renewcommand{\GMTitle}{#1}}
\newcommand{\Subtitle}[1]{\renewcommand{\GMSubtitle}{#1}}
\newcommand{\Date}[1]{\renewcommand{\GMDate}{#1}}
\newcommand{\Advisor}[1]{\renewcommand{\GMAdvisor}{#1}}
\newcommand{\CoAdvisor}[1]{\renewcommand{\GMCoAdvisor}{#1}}
\newcommand{\Course}[1]{\renewcommand{\GMCourse}{#1}}
\newcommand{\PhDCourse}[1]{\renewcommand{\GMphdCourse}{#1}} %CicloDottorato
\newcommand{\Director}[1]{\renewcommand{\GMDirector}{#1}}
%
% e.g. the user modify \GMAuthor by invoking \Autor{new value}
% othe class macros can use the value \GMAutor defined by the \Autor{} macro
% 

% --- defalt values for commands --- --- ---
% they may be re-defined by user
\newcommand{\Cover}{} 

% the command \PageTitleEnd{} should be called at the end of page tile defintion, 
% just after '\end{pagetitle}'
\newcommand{\CoverEnd}{%
\renewcommand{\thepage}{}%         % nessuna numerazione di pagina
\ifthenelse{\equal{\GMforeignCover}{true}}%
   {\mbox{} \newpage \mbox{}} \newpage % 1^ e 2^ pagina bianca
}%end \CoverEnd


% ----------------------------------------------------------------------------
% --- userCover (cover=user, coverfile=<file>) 
% ----------------------------------------------------------------------------
\ifthenelse{\equal{\GMcover}{user}}
{%
\IfFileExists{\GMcoverFile}%
{ \renewcommand{\Cover}{\input{\GMcoverFile}} }%
{% se file non trovato mostra warning se \Debug=false altrimenti attiva errore 
\ifthenelse{\equal{\GMDebug}{true}}
{\ClassError{\className}{\GMcoverFile:{} file not found}{check if file exists or its permissions}}
{\ClassWarning{\className}{\GMcoverFile:{} file not found, cover cannot be printed}%
}%
}%
}%ifthenelse

%  --- resolve aliases
\ifthenelse{\equal{\GMcover}{elaborato}}{\renewcommand{\GMcover}{work}}{}
\ifthenelse{\equal{\GMcover}{tesi}}{\renewcommand{\GMcover}{thesis}}{}

%\ifthenelse{\equal{\GMcover}{elaborato}}{\renewcommand{\GMcover}{cdoc}}
%\ifthenelse{\equal{\GMcover}{tesi}}{\renewcommand{\GMcover}{thesis}}

% ----------------------------------------------------------------------------
% --- work
% ----------------------------------------------------------------------------



\ifthenelse{\equal{\GMcover}{work}}
{% cover 'elaborato'
\renewcommand{\Cover}{%
\begin{titlepage} %
   \begin{flushright}
      \mbox{}\vspace{3cm}\
      {\Huge \sf \bf \flushright
         \GMTitle\ % titolo
      }
      \rule[-1mm]{\textwidth}{2mm}\\
     {{\ifthenelse{\equal{\GMSubtitle}{}}
        { \mbox{}\\ }% sottotitolo vuoto
        { {\Large \sf \bf  \GMSubtitle\ \\ }} % sottotitolo
     }}%
       \vspace{6cm}
        { {\Large \sf \GMAuthor{}\mbox{}\\}} % autore
   \end{flushright}
   \vspace{5cm}
   \begin{flushleft} {
       \large \sf \em
       \GMDate{} 
%{\includegraphics[width=1cm]{images/unipd-bn.eps} }
   }
   \end{flushleft}
\end{titlepage} %
\CoverEnd
}%renewcommand
}% endif



% ----------------------------------------------------------------------------
% --- tesi 
% ----------------------------------------------------------------------------
\ifthenelse{\equal{\GMcover}{thesis}}
{%
\renewcommand{\Cover}{%
\begin{titlepage}
  \begin{center}
     \begin{figure}[h]
        \centering
        \includegraphics[width=3cm]{images/unipd-bn.eps}
     \end{figure}
    {\Large \bf Universit\`a degli Studi di Padova}\\
    \vspace{0.2cm}
    {\large Facolt\`a di Ingegneria}\\
    \vspace{0.2cm}
    {\ifthenelse{\equal{\GMCourse}{}} {\mbox{}} {\GMCourse{} } }\\
    \vspace{2cm}
    {tesi di laurea\\ 
    %\vspace*{\stretch{1}}%
    \vspace{1cm}}
    {\Huge \bf \GMTitle{} }\\
    % sottotitolo
    \vspace{.5cm}
    {{\ifthenelse{\equal{\GMSubtitle}{}}
        { \mbox{}\\ }% sottotitolo vuoto
        { {\LARGE \sf \bf  \GMSubtitle{} \\ }} % sottotitolo
    }}%
  %\vspace*{\stretch{2}}
  \end{center}
  \vspace{4cm}
  \begin{flushleft}
     \begin{tabular}{ll}
       {\bf Relatore:} & \GMAdvisor{}\\
        \ifthenelse{\equal{\GMCoAdvisor}{}} %
           {\mbox{} \tabularnewline }% \Cotutor vuoto
           {{\bf Correlatore: } & \GMCoAdvisor{} \tabularnewline }
     \end{tabular}
  \end{flushleft}
  \vspace{1cm}
  \begin{flushright}
    {\bf Laureando:} \GMAuthor{}
  \end{flushright}
  \vspace{1cm}
  \begin{center}
    {\small \GMDate{}}
  \end{center}%
\end{titlepage}%
\CoverEnd %
}%renewcommand
}% endif

% ----------------------------------------------------------------------------
% --- tesina 
% ----------------------------------------------------------------------------
\ifthenelse{\equal{\GMcover}{tesina}}
{%
\renewcommand{\Cover}{%
\begin{titlepage}
  \begin{center}
     \begin{figure}[h]
        \centering
        \includegraphics[width=3cm]{images/unipd-bn.eps}
     \end{figure}
    {\Large \bf Universit\`a degli Studi di Padova}\\
    \vspace{0.2cm}
    {\large Facolt\`a di Ingegneria}\\
    \vspace{0.2cm}
    {\GMCourse{} }\\
    \vspace{2cm}
    {tesina\\ 
    %\vspace*{\stretch{1}}%
    \vspace{1cm}}
    {\Huge \bf \GMTitle{} }\\
    % sottotitolo
    \vspace{.5cm}
    {{\ifthenelse{\equal{\GMSubtitle}{}}
        { \mbox{}\\ }% sottotitolo vuoto
        { {\LARGE \sf \bf  \GMSubtitle{} \\ }} % sottotitolo
    }}%
  %\vspace*{\stretch{2}}
  \end{center}
  \vspace{4cm}
  \begin{flushleft}
     \begin{tabular}{ll}
       {\bf Relatore:} & \GMAdvisor{}\\
        \ifthenelse{\equal{\GMCoAdvisor}{}} %
           {\mbox{} \tabularnewline }% \Cotutor vuoto
           {{\bf Correlatore: } & \GMCoAdvisor{} \tabularnewline }
     \end{tabular}
  \end{flushleft}
  \vspace{1cm}
  \begin{flushright}
    {\bf Laureando:} \GMAuthor{}
  \end{flushright}
  \vspace{1cm}
  \begin{center}
    {\small \Date{}}
  \end{center}
\end{titlepage}
\CoverEnd
}%renewcommand
}%endif

% ----------------------------------------------------------------------------
% --- phdthesis 
% ----------------------------------------------------------------------------
\ifthenelse{\equal{\GMcover}{phdthesis}}
{%
\renewcommand{\Cover}{%
\begin{titlepage}
  \begin{center}
     \begin{figure}[h]
     \centering
      \includegraphics[width=3cm]{images/unipd-bn.eps}
     \end{figure}
   {\Large \bf Universit\`a degli Studi di Padova}\\
    \vspace{0.2cm}
   {\large Dipartimento di Ingegneria dell'Informazione}\\
   \vspace{0.2cm}
   {Scuola di Dottorato in Ingegneria dell'Informazione}\\

   {\GMphdCourse{}}\\
    \vspace{2.5cm}
   \end{center}
   \begin{flushright}
   {Ph.D thesis}
   %\rule[1mm]{\textwidth}{1mm}\\
   \end{flushright}

   \begin{center} 
   {\LARGE \bf \GMTitle{} }\\
     \end{center}

   \vspace{2.5cm}
   \begin{flushleft}
   \begin{tabular}{ll}
     {\bf Director:} & \GMDirector{}\\
     & \\ 
      {\bf Advisor:} & \GMAdvisor{} \\
      \ifthenelse{\equal{\GMCoAdvisor}{}} %
        {\mbox{} \tabularnewline }% \Cotutor vuoto
        {{\bf Coadvisor: } & \GMCoAdvisor{} \tabularnewline }
    \end{tabular}
   \end{flushleft}
   \vspace{1cm}
   \begin{flushright}
   {\bf ph.D student:} \GMAuthor{}
   \end{flushright}
   \vspace{1cm}
   \begin{center}
   {\small \GMDate{}}
   \end{center}
\end{titlepage} %end title
\CoverEnd
}%renewcommand
}%endif


% --- end cover --- --- ---

% ------------------------------------------------------------------------
% --- debug macros 


\newcommand{\GMclassVarTable}%
{
\begin{table}
\begin{tabular}{lll}
\hline
class option & var name & value\\
\hline \\[-7pt]
\emph{read only variables} \\[3pt]
booktype        & \tCode{\textbackslash{}GMbookType}        & \GMbookType \\
encoding        & \tCode{\textbackslash{}GMfileEncoding}    & \GMfileEncoding \\
font size       & \tCode{\textbackslash{}GMfontsize} (test)        & \GMfontsize \\
font length     & \tCode{\textbackslash{}Gmfontlength} (length)      & \the\GMfontlength \\
language        & \tCode{\textbackslash{}GMlanguage}        & \GMlanguage \\
cover type      & \tCode{\textbackslash{}GMcover}           & \GMcover \\
cover file      & \tCode{\textbackslash{}GMcoverFile}       & \GMcoverFile \\
foreign cover   & \tCode{\textbackslash{}GMforeignCover}    & \GMforeignCover \\
document status & \tCode{\textbackslash{}GMdocumentStatus}  & \GMdocumentStatus \\
user commands   & \tCode{\textbackslash{}GMusercmd}         & \GMusercmd \\
\hline \\[-7pt]
\emph{global variables} \\[2pt]
& \tCode{\textbackslash{}className} & \className \\
& \tCode{\textbackslash{}classVersion} & \classVersion \\& \tCode{\textbackslash{}GMDebug} & \GMDebug \\
& \tCode{\textbackslash{}GMDraft} & \GMDraft \\
& \tCode{\textbackslash{}GMSecret} 	&   	\GMSecret \\
\hline 
\end{tabular}
\caption[~\emph{debug}: class variables]{Class variables.}\label{tab:tabvar}
\end{table}

}

\newcommand{\ShowDebugInfo}{%
\ifthenelse{\equal{\GMDebug}{true}}%
{% if
\clearpage 
\chapter*{Debug Information}

This chapter has been added by the class \tCode{\className} for debug purposes.
Moreover, margin text alongside the whole document highlights the usage of the macro \tCode{\textbackslash{}Index}, while text defined by using the \tCode{\textbackslash{}tAltSecret} or \tCode{\textbackslash{}tAltSecret} macros will be in any case displayed.\par
All debug information will be no longer displayed by loading this class without the option 
\tCode{status=debug}.\\

\section*{Debug information}
\noindent The table \ref{tab:tabvar} shows, variables defined by class \tCode{\className{}} (ver.\classVersion).\\

\GMclassVarTable

\clearpage
}%end if
}% \ShowDebugInfo



% ------------------------------------------------------------------------
%
\AtEndDocument{\ifthenelse{\equal{\GMDebug}{true}}{ \ShowDebugInfo } }% \AtEndDocument



% ------------------------------------------------------------------------
%    
\AtEndOfClass{%
\InputIfFileExists{\GMusercmd}{}
{% file not found
\ifthenelse{\equal{\GMDebug}{true}}
{\ClassError{\className}{\GMusercmd:{} file not found}{check if file exists or its permissions}}
{\ClassWarning{\className}{\GMusercmd:{} file not found, cover cannot be printed} }
} %end 'file not found'
} %\AtEndOfClass
% ------------------------------------------------------------------------
%
%
% ------------------------------------------------------------------------
% memento:
%   \newcommand{nome}[parms num.]{def}
%   \newenvironment{nome}[parms num.]{before}{after}
%
% altro promemoria
% \newcommand{\Index}[2]{\index{#1} \ifthenelse{\lengthtest{#2}>0}{ index #1 (#2) }{}}
% ------------------------------------------------------------------------
% \newcommand{\x}{}
% \newcommand{\x}[1]{\renewcommand{\GMx}{#1}}
%
