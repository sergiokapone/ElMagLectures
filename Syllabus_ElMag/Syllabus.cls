\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{Syllabus}[2024/02/18]
\LoadClass[a4,12pt]{article}
\PassOptionsToPackage{table}{xcolor}
\ProcessOptions\relax


%=====================================================================
%
%										Геометрія сторінки
%
%=====================================================================
\RequirePackage[%
	a4paper,%
	footskip=1cm,%
	headsep=0cm,%
	top=1.5cm, %поле сверху
	bottom=1.5cm, %поле снизу
	left=1.5cm, %поле ліворуч
	right=1.5cm, %поле праворуч
]{geometry}

%=====================================================================
%
%					Налаштування мови та компіляторів
%
%=====================================================================

\RequirePackage{ifluatex,ifxetex}
\newif\ifxetexorluatex
\ifxetex
	\xetexorluatextrue
\else
	\ifluatex
		\xetexorluatextrue
	\else
		\xetexorluatexfalse
	\fi
\fi
\ifxetexorluatex
    \usepackage[]{fontsetup}
	\setsansfont{Arial}
	\setmainfont{Calibri}
%    \usepackage[symbolmisc]{mathastext}
\else
	\RequirePackage[T2A,T1]{fontenc}
	\RequirePackage[utf8]{inputenc}
	\input{glyphtounicode}
	\pdfgentounicode=1
	%\RequirePackage{pscyr}
	\RequirePackage{cmap}
	\renewcommand{\sfdefault}{fos}
	\renewcommand{\bfdefault}{b}
\fi
\RequirePackage[english,ukrainian]{babel}


%-------------Подавление висячих строк--------------------------------
\clubpenalty =10000
\widowpenalty=10000
%-------------Інтервали-------------------------------------------
\setlength{\parskip}{0.5ex}%
\setlength{\parindent}{2em}%
\renewcommand{\baselinestretch}{1}
%-----------------------------------------------------------------
%=====================================================================
%
%										Пакети
%
%=====================================================================
\RequirePackage{microtype}
\RequirePackage{tikz}
\usetikzlibrary{tikzmark, calc}
\RequirePackage{indentfirst}
\RequirePackage{mhchem, chemfig}
\RequirePackage{titlesec}
\titlelabel{\thetitle.\quad}
\RequirePackage{etoolbox}
\RequirePackage{xintexpr}
%=====================================================================
%
%										Таблиці
%
%=====================================================================
\RequirePackage{caption}
\captionsetup[table]{labelsep=space,
	justification=centering, singlelinecheck=off, labelsep=period}
\RequirePackage{tabularray}
\UseTblrLibrary{counter}
\RequirePackage{multirow}
\RequirePackage{array}
\newcolumntype{P}[1]{>{\centering\arraybackslash}p{#1}}
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}
\RequirePackage{rotating}
\RequirePackage{makecell}
\renewcommand\theadfont{\normalsize}
\RequirePackage{longtable}
\RequirePackage{ctable, hhline}
\RequirePackage{spreadtab}
\RequirePackage{xcolor}
\definecolor{main}{RGB}{13, 13, 89}
\definecolor{maintext}{RGB}{0, 112, 192}
\definecolor{rowfill}{RGB}{219, 229, 241}
\definecolor{airforceblue}{rgb}{0.36, 0.54, 0.66}
\definecolor{infotablecolor}{RGB}{149,179,215}
\RequirePackage{boldline}
\RequirePackage{spreadtab}
\RequirePackage{graphics}
\RequirePackage{titlesec}
\RequirePackage{tcolorbox}
\titleformat*{\section}{\normalsize\sffamily\bfseries\color{main}}
\titleformat*{\subsection}{\normalsize\sffamily\color{main}}
\newcounter{magicrownumbers}
\NewDocumentCommand{\rownumber}{}{\stepcounter{magicrownumbers}\arabic{magicrownumbers}}
\setlength{\arrayrulewidth}{1pt}
\RequirePackage[bottom]{footmisc}

\newcounter{tablchapter}
\newcounter{tabltheme}


\NewDocumentCommand{\chapcount}{}{\stepcounter{tablchapter}\setcounter{tabltheme}{0}\arabic{tablchapter}}
\NewDocumentCommand{\themecount}{}{\stepcounter{tabltheme}\arabic{tablchapter}.\arabic{tabltheme}}

%=====================================================================
%
%										Бібліографія
%
%=====================================================================

%\RequirePackage[%
%  parentracker=true,
%  backend=biber,
%  url=false,
%  maxbibnames=9,
%  hyperref=auto,
%  language=auto,
%  autolang=other,
%  bibstyle=gost2008,
%  style=numeric,
%  sorting=none,
%]{biblatex}
\RequirePackage[%
	url = false,
	backend=biber,
	bibencoding=utf8,
	sorting=none,
	maxcitenames=2,
	maxbibnames=9,
	%    style=gost-footnote,
	language=auto,
	autolang=other,
	bibstyle=numeric,
	opcittracker=false,
	pagetracker,
]{biblatex}
\RequirePackage{xurl}

\newcommand*{\addtocategoryNoCi}[2]{\addtocategory{#1}{#2}\nocite{#2}}

%\DeclareFieldFormat{abstract}{\par\footnotesize#1}
%\renewbibmacro*{finentry}{\color{maintext}\printfield{abstract}\finentry}
%\DeclareFieldFormat{annotation}{\par\footnotesize#1}
%\renewbibmacro*{finentry}{\color{maintext}\printfield{annotation}\finentry}
\AtEveryBibitem{\clearlist{language}}
\DeclareBibliographyCategory{Main}
\DeclareBibliographyCategory{Problems}
\DeclareBibliographyCategory{Additional}
\DeclareBibliographyCategory{Applications}
\DeclareBibliographyCategory{OnlineResources}
\DeclareBibliographyCategory{SciArticles}
\DeclareBibliographyCategory{LabPract}
\DeclareFieldFormat{labelnumberwidth}{#1\adddot}
\setlength{\biblabelsep}{5pt}
\newbibmacro{string+url}[1]{%
	\iffieldundef{url}{#1}{\href{\thefield{url}}{#1}}%
}
\DeclareFieldFormat{title}{\usebibmacro{string+url}{#1}}

%%============ Bibliography spacing ========================%%
\setlength{\bibitemsep}{.1\baselineskip plus .05\baselineskip minus .05\baselineskip}
\newlength{\bibparskip}\setlength{\bibparskip}{0pt}
\let\oldthebibliography\thebibliography
\renewcommand\thebibliography[1]{%
	\oldthebibliography{#1}%
	\setlength{\parskip}{\bibitemsep}%
	\setlength{\itemsep}{\bibparskip}%
}

%=====================================================================
%
%					           hyperref
%
%=====================================================================

\RequirePackage[colorlinks=true,
	citecolor = green!40!black,
	urlcolor = blue!80!black,
    linkcolor = red!60!black,
	bookmarks = true,
	bookmarksnumbered=true,
	unicode,
	linktocpage = true,
	hypertexnames=false,
	pdftoolbar=false,
	pdfpagelayout=TwoPageRight,
	pdfauthor={Ponomarenko S.M.},
	pdfdisplaydoctitle=true,
	pdfkeywords={},
	pdfencoding=auto
]%
{hyperref}

%=====================================================================
%
%										Переліки та списки
%
%=====================================================================

\RequirePackage{enumitem}
\setlist[enumerate]{%
	topsep=0pt,
	labelsep=8pt,%
	labelindent=\parindent,%
	itemindent=0pt,%
	leftmargin=*,%
	listparindent=-\leftmargin,%
	noitemsep%
}
\newlist{Rozdil}{enumerate}{2}

\setlist[Rozdil,1]{
	label={Частина \Roman*.},
	ref={\Roman*},
	labelindent=0pt,
	itemindent=0pt,
	leftmargin=*,
	widest*=7,       % найширша мітка — «Частина VII.»
	align=left,
	labelsep=0.5em,
	listparindent=0pt
}

\setlist[Rozdil,2]{
	labelsep=8pt,%
	labelindent=\parindent,%
	itemindent=0pt,%
	leftmargin=*,%
	listparindent=-\leftmargin,
	label={Розділ\ \arabic{Rozdili}.\arabic*},ref={\arabic{Rozdili}.\arabic*},
}



\RequirePackage{readarray}
\newread\readquastions
\NewDocumentCommand{\loaditemsfromfile}{O{enumerate} m}{%
	\IfFileExists{#2}{%
		\openin\readquastions=#2
		\begin{#1}  % Use an itemize enviroment with #1 as name of the env.
		\loop\unless\ifeof\readquastions%
		\read\readquastions to \localvariable
		\ifeof\readquastions
		\else
			\item \localvariable
		\fi
		\repeat
		\end{#1} % close the environment
		\closein\readquastions%  \close the file
	}{}%
}

\NewDocumentCommand{\Repeat}{m m}{
	\newcounter{i}
	\loop \ifnum\value{i} < #1
	#2%
	\stepcounter{i}%
	\repeat
}

%=====================================================================
%
%					Команди для титульних сторінок
%
%=====================================================================

\NewDocumentCommand{\syllabuschapter}{ m }{%
	\vspace{1em}%
	\noindent\fcolorbox{gray!50}{gray!50}{\parbox{0.985\textwidth}{\centering\bfseries\textcolor{main}{#1}}}%
	\vspace{1em}%
}

\newcounter{tmark}\setcounter{tmark}{0}
\NewDocumentCommand{\mfield}{m m m m m}{%
	\stepcounter{tmark}
	% #1 = total width
	% #2 = text on the left
	% #3 = text on the right
	% #4 = text above the rule
	% #5 = text below the rule
	#2\rule[-0.35\baselineskip]{#1}{0.5pt}\tikzmark{\thetmark}#3%
	\begin{tikzpicture}[overlay,remember picture]
		\node at ([xshift=-(#1/2),yshift=.15\baselineskip]pic cs:\thetmark) {#4};
		\node at ([xshift=-(#1/2),yshift=-.6\baselineskip]pic cs:\thetmark) {\scriptsize #5};
	\end{tikzpicture}%
}



\NewDocumentCommand{\field}{m m m m}{%
	% #1 = total width
	% #2 = text on the left
	% #3 = text above the rule
	% #4 = text below the rule
	%\par\noindent
	\parbox{#1}{
		\makebox[#1][s]{#2\ \lowrule{\fill}\makebox[0pt]{#3}\lowrule{\fill}}\\*
		\makebox[#1][s]{\hphantom{#2}\ \hfill\makebox[0pt]{\scriptsize#4}\hfill}%
	}
}

\NewDocumentCommand{\datefield}{m m m}{%
	% #1 = total width
	% #3 = text on the right
	% #2 = text above the rule
	%\par\noindent
	\parbox{#1}{
		\makebox[#1][s]{\lowrule{\fill}\makebox[0pt]{#2}\lowrule{\fill} #3}\\*
	}
}

\NewDocumentCommand{\inlinefield}{m m m m}{%
	% #1 = total width
	% #2 = text on the left
	% #3 = text above the rule
	% #4 = text below the rule
	%\par\noindent
	\parbox{#1}{
		\makebox[#1][s]{#2\ \lowrule{\fill}\makebox[0pt]{#3}\lowrule{\fill}}\\*
		\makebox[#1][s]{\hphantom{#2}\ \hfill\makebox[0pt]{\scriptsize#4}\hfill}%
	}
}

\NewDocumentCommand{\lowrule}{ m }{%
	\leaders\hrule height \dimexpr-\dp\strutbox+0.4pt\relax depth \dp\strutbox\hskip#1\relax
}

\let\@status\@empty
\let\@cycle\@empty
\let\@level\@empty
\let\discipline\@empty
\let\@methodcomday\@empty
\let\@methodcommonth\@empty
\let\@methodcomnum\@empty
\let\@methodcomyear\@empty
\let\@kafday\@empty
\let\@kafmonth\@empty
\let\@kafnum\@empty
\let\@kafyear\@empty
\let\@code\@empty
\let\@shedule\@empty

\newcounter{count}

\ExplSyntaxOn
\int_new:N \l_counter_int
\int_new:N \l_creator_int
\int_new:N \l_lecturer_int
\int_new:N \l_practicer_int
\int_new:N \l_laborer_int

\seq_new:N \g_syllabus_class_creator_name_seq
\seq_new:N \g_syllabus_class_creator_email_seq
\seq_new:N \g_syllabus_class_creator_seq
\seq_new:N \g_syllabus_class_lecturer_name_seq
\seq_new:N \g_syllabus_class_lecturer_email_seq
\seq_new:N \g_syllabus_class_lecturer_seq
\seq_new:N \g_syllabus_class_practicer_name_seq
\seq_new:N \g_syllabus_class_practicer_email_seq
\seq_new:N \g_syllabus_class_practicer_seq
\seq_new:N \g_syllabus_class_laborer_name_seq
\seq_new:N \g_syllabus_class_laborer_email_seq
\seq_new:N \g_syllabus_class_laborer_seq


\cs_new_protected:Nn \syllabus_class_data_add:nnn
{
	\seq_gput_right:cn { g_syllabus_class_#1_name_seq } { #3 }
	\seq_gput_right:cn { g_syllabus_class_#1_email_seq } { #2 }
	\tl_if_blank:nTF {#2} { \seq_gput_right:cn { g_syllabus_class_#1_seq } { #3      }    }
	{ \seq_gput_right:cn { g_syllabus_class_#1_seq } { #3\ (\url{#2}) }   }
}

\NewDocumentCommand{\retrieve}{mm}
{
	\seq_item:cn { g_syllabus_class_#1_name_seq } { #2 }
}

\NewDocumentCommand{\retrievelist}{m}
{
	\seq_use:cnnn { g_syllabus_class_#1_seq } { \ та\newline  } { ,\newline } { \ та\newline  } {.}
}

\NewDocumentCommand{\creator}{O{}m}
{
	\int_incr:N \l_creator_int
	\syllabus_class_data_add:nnn { creator } { #1 } { #2 }
}
\NewDocumentCommand{\totalcreator}{}{\int_use:N \l_creator_int}

\NewDocumentCommand{\lecturer}{O{}m}
{
	\int_incr:N \l_lecturer_int
	\syllabus_class_data_add:nnn { lecturer } { #1 } { #2 }
}
\NewDocumentCommand{\totallecturer}{}{\int_use:N \l_lecturer_int}

\NewDocumentCommand{\practicer}{O{}m}
{
	\int_incr:N \l_practicer_int
	\syllabus_class_data_add:nnn { practicer } { #1 } { #2 }
}
\NewDocumentCommand{\totalpracticer}{}{\int_use:N \l_practicer_int}

\NewDocumentCommand{\laborer}{O{}m}
{
	\int_incr:N \l_laborer_int
	\syllabus_class_data_add:nnn { laborer } { #1 } { #2 }
}

\NewDocumentCommand{\totallaborer}{}{\int_use:N \l_laborer_int}

\int_new:N \g_totalkafs_int

\NewDocumentCommand\kafname{ m }
{
	\seq_gput_right:Nn \g_syllabus_kafname_seq { #1 }
}

\seq_new:N \g_syllabus_kafname_seq
\NewDocumentCommand\totalkafs{}
{
	\seq_count:N \g_syllabus_kafname_seq
}

\NewDocumentCommand{\@kafname}{}
{
	\seq_use:Nnnn  \g_syllabus_kafname_seq { \ та\ кафедра\  } { ,\ кафедра\ } { \ та\ кафедра\  }
}

\NewDocumentCommand{\thekaf}{ O{1} }
{
	\seq_item:Nn \g_syllabus_kafname_seq { #1 }
}

\seq_new:N \g_syllabus_Credits_seq
\fp_new:N \g__syllabus_Credits_fp
\seq_new:N \g_syllabus_TotalHours_seq
\fp_new:N \g__syllabus_TotalHours_fp


\seq_new:N \g_syllabus_LecHours_seq
\int_new:N \g_syllabus_LecHours_int
\int_new:N \g__syllabus_LecHours_int

\seq_new:N \g_syllabus_PracHours_seq
\int_new:N \g_syllabus_PracHours_int
\int_new:N \g__syllabus_PracHours_int

\seq_new:N \g_syllabus_ComPracHours_seq
\int_new:N \g_syllabus_ComPracHours_int
\int_new:N \g__syllabus_ComPracHours_int

\seq_new:N \g_syllabus_LabHours_seq
\int_new:N \g_syllabus_LabHours_int
\int_new:N \g__syllabus_LabHours_int


\seq_new:N \g_syllabus_SRSHours_seq
\int_new:N \g_syllabus_SRSHours_int

\NewDocumentCommand{\AudDistribHours}{ m m m m O{0} }
{
	\fp_set:Nn \g__syllabus_Credits_fp    {#1}
	\fp_set:Nn \g__syllabus_TotalHours_fp {30*#1}
	\seq_gput_right:Nn \g_syllabus_Credits_seq       { #1 }
	\seq_gput_right:Nn \g_syllabus_TotalHours_seq  {\fp_to_int:n {30*#1} }
	%---------------- Lectures ------------------------------------
	\seq_gput_right:Nn \g_syllabus_LecHours_seq      { #2 }

	\tl_if_blank:nTF {#2} {\int_zero:N \g__syllabus_LecHours_int}
	{
		\int_set:Nn \g__syllabus_LecHours_int {#2}
		\int_add:Nn \g_syllabus_LecHours_int {#2}
	}
	%---------------- Practics ------------------------------------
	\seq_gput_right:Nn \g_syllabus_PracHours_seq     { #3 }
	\tl_if_blank:nTF {#3} {\int_zero:N \g__syllabus_PracHours_int}
	{
		\int_set:Nn \g__syllabus_PracHours_int {#3}
		\int_add:Nn \g_syllabus_PracHours_int {#3}
	}
	%---------------- Labor ------------------------------------
	\seq_gput_right:Nn \g_syllabus_LabHours_seq      { #4 }
	\tl_if_blank:nTF {#4} {\int_zero:N \g__syllabus_LabHours_int}
	{
		\int_set:Nn \g__syllabus_LabHours_int {#4}
		\int_add:Nn \g_syllabus_LabHours_int {#4}
	}
	%---------------- ComPrac ------------------------------------
	\seq_gput_right:Nn \g_syllabus_ComPracHours_seq  { #5 }
	\tl_if_blank:nTF {#5} {\int_zero:N \g__syllabus_ComPracHours_int}
	{
		\int_set:Nn \g__syllabus_ComPracHours_int {#5}
		\int_add:Nn \g_syllabus_ComPracHours_int {#5}
	}
	%---------------- SRS ------------------------------------
	\int_set:Nn \g_syllabus_SRSHours_int
	{
		\fp_to_int:N \g__syllabus_TotalHours_fp - \g__syllabus_LecHours_int - \g__syllabus_PracHours_int - \g__syllabus_LabHours_int - \g__syllabus_ComPracHours_int
	}
	\seq_gput_right:NV \g_syllabus_SRSHours_seq  \g_syllabus_SRSHours_int
}

\NewDocumentCommand{\totallectures}{}
{
	\int_use:N \g_syllabus_LecHours_int
}

\NewDocumentCommand{\totalprac}{}
{
	\int_use:N \g_syllabus_PracHours_int
}

\NewDocumentCommand{\totallabs}{}
{
	\int_use:N \g_syllabus_LabHours_int
}

\NewDocumentCommand{\totalcomprac}{}
{
	\int_use:N \g_syllabus_ComPracHours_int
}


\NewDocumentCommand{\Credits}{}
{
	\seq_use:Nnnn \g_syllabus_Credits_seq  {/}{/}{/}
}

\NewDocumentCommand{\TotalHours}{}
{
	\seq_use:Nnnn \g_syllabus_TotalHours_seq  {/}{/}{/}
}

\NewDocumentCommand{\LecHours}{}
{
	\seq_use:Nnnn \g_syllabus_LecHours_seq  {/}{/}{/}
}


\NewDocumentCommand{\PracHours}{}
{
	\seq_use:Nnnn \g_syllabus_PracHours_seq  {/}{/}{/}
}

\NewDocumentCommand{\LabHours}{}
{
	\seq_use:Nnnn \g_syllabus_LabHours_seq  {/}{/}{/}
}

\NewDocumentCommand{\ComPracHours}{}
{
	\seq_use:Nnnn \g_syllabus_ComPracHours_seq  {/}{/}{/}
}


\NewDocumentCommand{\SRSHours}{}
{
	\seq_use:Nnnn \g_syllabus_SRSHours_seq  {/}{/}{/}
}


\seq_new:N \g_syllabus_control_seq

\NewDocumentCommand\controltype{  m  }
{
	\seq_gput_right:Nn \g_syllabus_control_seq { #1 }
}

\NewDocumentCommand\control{  O{1}  }
{
	\seq_item:Nn \g_syllabus_control_seq { #1 }
}

\NewDocumentCommand\Control{  O{1}  }
{
	\text_titlecase:n {\seq_item:Nn \g_syllabus_control_seq { #1 } }
}


\NewDocumentCommand\controls{}
{
	\seq_use:Nnnn \g_syllabus_control_seq { / }{ / }{ / }
}

\seq_new:N \g_syllabus_semestr_seq

\NewDocumentCommand\semestr{  m  }
{
	\seq_gput_right:Nn \g_syllabus_semestr_seq { #1 }
}

\NewDocumentCommand\totalsemestrs{}
{
	\seq_count:N \g_syllabus_semestr_seq
}

\NewDocumentCommand\semestrs{}
{
	\seq_use:Nnnn \g_syllabus_semestr_seq { / }{ / }{ / }
}

\seq_new:N \g_syllabus_course_seq

\NewDocumentCommand\course{  m  }
{
	\seq_gput_right:Nn \g_syllabus_course_seq { #1 }
}

\NewDocumentCommand\totalcourses{}
{
	\seq_count:N \g_syllabus_course_seq
}

\NewDocumentCommand\courses{}
{
	\seq_use:Nnnn \g_syllabus_course_seq { / }{ / }{ / }
}

\seq_new:N \g_syllabus_kursurl_seq

\NewDocumentCommand\kursurl{  m  }
{
	\seq_gput_right:Nn \g_syllabus_kursurl_seq { \url{#1} }
}
\NewDocumentCommand\kursurls{}
{
	\seq_use:Nnnn \g_syllabus_kursurl_seq { \newline }{ \newline }{ \newline }
}

\NewExpandableDocumentCommand \firstcap { m } {  \text_titlecase:n  {#1} }

\tl_new:N \l_efield_tl

\NewDocumentCommand \efield{  m  }
{
	\tl_set:Nn  \l_efield_tl {#1}
}

\NewDocumentCommand \@efield{}
{
	\tl_use:N  \l_efield_tl
}

\tl_new:N \l_speciality_tl

\NewDocumentCommand \speciality{  m  }
{
	\tl_set:Nn  \l_speciality_tl {#1}
}

\NewDocumentCommand \@speciality{}
{
	\tl_use:N  \l_speciality_tl
}

% ---

\tl_new:N \l_teachingprogramm_tl

\NewDocumentCommand \teachingprogramm{  m  }
{
	\tl_set:Nn  \l_teachingprogramm_tl {#1}
}

\NewDocumentCommand \@teachingprogramm{}
{
	\tl_use:N  \l_teachingprogramm_tl
}




\ExplSyntaxOff

\DeclareDocumentCommand{\itemR}{O{} m }{%
	\ifblank{#1}{\item #2}{\item[#1] #2}%
	\protected@edef\@currentlabelname{#2}%
}

\DeclareDocumentCommand{\nref}{m}
{
	\ref{#1}. \nameref{#1}
}


\def\status#1{%
	\ifx#1\empty\detokenize{#1}\relax
	\else
		\def\@status{#1}
	\fi
}

\def\cycle#1{%
	\ifx#1\empty\detokenize{#1}\relax
	\else
		\def\@cycle{#1}
	\fi
}

\def\level#1{%
	\ifx#1\empty\detokenize{#1}\relax
	\else
		\def\@level{#1}
	\fi
}

\def\disciplinename#1{%
	\ifx#1\empty\detokenize{#1}\relax
	\else
		\edef\discipline{\unexpanded{#1}\relax}%
	\fi
}


\def\disciplinecode#1{%
	\ifx#1\empty\detokenize{#1}\relax
	\else
		\def\@disciplinecode{#1}
	\fi
}


\def\@logokaf{Syllabus-apdlogo.png}

\newcommand{\logokaf}[1][]{%
	\ifx&#1&%
		% пустой аргумент
	\else
		\def\@logokaf{#1}%
	\fi
}

\def\methodcomday#1{%
	\ifx#1\empty\detokenize{#1}\relax
	\else
		\def\@methodcomday{#1}
	\fi
}

\def\methodcommonth#1{%
	\ifx#1\empty\detokenize{#1}\relax
	\else
		\def\@methodcommonth{#1}
	\fi
}

\def\methodcomnum#1{%
	\ifx#1\empty\detokenize{#1}\relax
	\else
		\def\@methodcomnum{#1}
	\fi
}

\def\methodcomyear#1{%
	\ifx#1\empty\detokenize{#1}\relax
	\else
		\def\@methodcomyear{#1}
	\fi
}

%--
\def\kafday#1{%
	\if\relax\detokenize{#1}\relax
	\else
		\def\@kafday{#1}
	\fi
}

\def\kafmonth#1{%
	\ifx#1\empty\detokenize{#1}\relax
	\else
		\def\@kafmonth{#1}
	\fi
}

\def\kafnum#1{%
	\ifx#1\empty\detokenize{#1}\relax
	\else
		\def\@kafnum{#1}
	\fi
}

\def\kafyear#1{%
	\ifx#1\empty\detokenize{#1}\relax
	\else
		\def\@kafyear{#1}
	\fi
}


\def\code#1{%
	\ifx#1\empty\relax\detokenize{#1}
	\else
		\def\@code{#1}
	\fi
}

\def\shedule#1{%
	\ifx#1\empty\relax\detokenize{#1}
	\else
		\def\@shedule{\url{#1}}
	\fi
}



\let\@mkr\@empty
\let\@dkr\@empty
\let\@rgr\@empty
\let\@referat\@empty

\def\MKR#1{%
	\if\relax\detokenize{#1}\relax
	\else
		\def\@mkr{модульна контрольна робота}
	\fi
}

\def\DKR#1{%
	\if\relax\detokenize{#1}\relax
	\else
		\def\@dkr{домашня контрольна робота}
	\fi
}

\def\RGR#1{%
	\if\relax\detokenize{#1}\relax
	\else
		\def\@rgr{розрахунково-графічна робота}
	\fi
}

\def\Referat#1{%
	\if\relax\detokenize{#1}\relax
	\else
		\def\@referat{реферат}
	\fi
}

% ================================================
%          Таблиця з даними дисципліни
% ================================================
\NewDocumentCommand{\bluetableprint}{}{%
	\begin{center}\color{black}\small
		\begin{tblr}{
            colspec={Q[l,m,0.3\linewidth,fg=main]X[l,m,fg=main]},
            row{odd} = {rowfill},
            hlines = {1-Z}{infotablecolor},
            vlines = {1-Z}{infotablecolor},
        }
			Рівень вищої освіти                         & \@level                                                                                                       \\
			Галузь знань                                & \@efield                                                                                                      \\
			Спеціальність                               & \@speciality                                                                                                  \\
			Освітня програма                            & \@teachingprogramm                                                                                            \\
			Статус дисципліни                           & \@status                                                                                                      \\
			Форма навчання                              & очна (денна)                                                                                                  \\
			Рік підготовки, семестр                     & \courses{} курс\ifnum\totalcourses=1\relax\else и\fi, \semestrs~семестр\ifnum\totalsemestrs=1\relax\else и\fi \\
			Обсяг дисципліни                            & Загальна кількість: (\Credits~кр.)\ \TotalHours~год.
			\ifnum\totallectures=0\relax\else\newline Лекційних занять:\       \LecHours~год.\fi
			\ifnum\totalprac=0\relax\else\newline Практичних занять:\      \PracHours~год.\fi
			\ifnum\totallabs=0\relax\else\newline Лабораторних занять:\    \LabHours~год.\fi
			\ifnum\totalcomprac=0\relax\else\newline Комп'ютерний практикум:\ \ComPracHours~год.\fi
			\newline Самостійна робота студентів:\ \SRSHours~год.
			\\
			Семестровий контроль / контрольні заходи    & \controls, поточний контроль%
			\ifx\@mkr\@empty\relax\else,\ \@mkr\fi
			\ifx\@dkr\@empty\relax\else,\ \@dkr\fi
			\ifx\@rgr\@empty\relax\else,\ \@rgr\fi
			\ifx\@referat\@empty\relax\else,\ \@referat\fi
			\\
			Розклад занять                              & \@shedule                                                                                                     \\
			Мова викладання                             & Українська                                                                                                    \\
			Інформація про керівника курсу / викладачів &
			\ifnum\totallecturer=0\relax\else Лектор\ifnum\totallecturer=1\relax\else и\fi: \retrievelist{lecturer}\fi
			\ifnum\totalpracticer=0\relax\else\newline Практика:\ \retrievelist{practicer}\fi
			\ifnum\totallaborer=0\relax\else\newline Лабораторні:\ \retrievelist{laborer}\fi
			\\
			Розміщення курсу                            & \kursurls
		\end{tblr}
	\end{center}
}

%\usepackage{showframe}
\NewDocumentCommand{\printhead}{}{%
	%\hspace{-\parindent}%
	\noindent%
	\begin{minipage}[t][][l]{0.7\textwidth}\sffamily\bfseries\color{main}
		\noindent%
		\begin{minipage}{1.25cm}
			\includegraphics[width=1\linewidth]{Syllabus-kpilogo.png}
		\end{minipage}\hspace{5pt}
		\begin{minipage}{0.75\linewidth}\small
			Національний технічний університет України \\
			<<КИЇВСЬКИЙ ПОЛІТЕХНІЧНИЙ ІНСТИТУТ\\ імені ІГОРЯ СІКОРСЬКОГО>>
		\end{minipage}
	\end{minipage}%
	\hfill%
	\IfFileExists{\@logokaf}{%
		\tikz[remember picture, overlay] { \node[anchor=north east] {\includegraphics[width=2.5cm]{\@logokaf}};}}{}%
	\begin{minipage}[t][][l]{0.34\textwidth}\sffamily\bfseries\color{maintext}
		\begin{flushleft}
			\vspace*{5.1pt}
			Навчально-науковий\\
			фізико-технічний інститут\\
			Кафедра \@kafname
		\end{flushleft}
	\end{minipage}
	\\[1em]
	\begin{center}\color{main}\bfseries\sffamily\LARGE\MakeUppercase
		\discipline
		\ifdefined\@disciplinecode%
			\ (\@disciplinecode)%
		\else%
			\relax%
		\fi%
		\\[1em]
		{\Large Робоча програма навчальної дисципліни (Силабус)}%\\[1ex]
		%(тимчасовий, на період дії особливого стану)
	\end{center}
}

\NewDocumentCommand{\printrequisites}{}{%
	\setcounter{count}{1}
	\begin{flushleft}
		\newsavebox{\protocolbox}
		\savebox{\protocolbox}{{(протокол № \mfield{1.5cm}{}{}{}{} від \mfield{2.3cm}{}{}{}{} \@kafyear~р.)}}

		\noindent\textbf{Робочу програму навчальної дисципліни (силабус)}:
		\vskip2em

		\ifnum\totalcreator>0%
			\foreach \i in {1,...,\totalcreator} {
					\noindent\inlinefield{1\textwidth}{\ifnum\i=1\textbf{Складено:}\else\phantom{Складено:}\fi}{\retrieve{creator}{\i}}{(посада, науковий ступінь, вчене звання, ПІБ)}
				}
		\fi%


		\foreach \i in {1,...,\totalkafs} {%
				\noindent\inlinefield{\textwidth-\wd\protocolbox-5pt}{\ifnum\i=1\textbf{Ухвалено:}\else\phantom{Ухвалено:}\fi\space кафедрою}{\thekaf[\i]}{(повна назва кафедри)}
				\raisebox{0.5\baselineskip}{(протокол № \mfield{1.5cm}{}{}{\@kafnum}{} від \mfield{2.3cm}{}{}{\@kafday\ \@kafmonth}{} \@kafyear~р.)}
			}


		\noindent\inlinefield{\textwidth-\wd\protocolbox-5pt}{\textbf{Затверджено: }Метод. комісією}{НН ФТІ}{(назва інституту)}
		\raisebox{0.5\baselineskip}{(протокол № \mfield{1.5cm}{}{}{\@methodcomnum}{} від \mfield{2.3cm}{}{}{\@methodcomday\ \@methodcommonth}{} \@methodcomyear~р.)}
	\end{flushleft}
}
\endinput