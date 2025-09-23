\ProvidesClass{Preport}
\LoadClass{ctexart}
\RequirePackage{graphicx, xcolor, tikz}
\RequirePackage{geometry, titlesec, fancyhdr}
\RequirePackage{listings, cncolours}
\RequirePackage{indentfirst, enumitem, zhnumber}
\RequirePackage{fontspec, stackengine}
\RequirePackage{silence}
\WarningFilter{latexfont}{Some font shapes}
\WarningFilter{latexfont}{Font shape}
\RequirePackage{float, siunitx}
\RequirePackage{booktabs, tabularx, array, subcaption, hyperref}
\RequirePackage{currfile}
\hypersetup{
    colorlinks=true,
}
\RequirePackage{comment}
\newcommand{\@reporttitle}{}
\newif\ifpreviewreport

% 声明选项 'yuxi'
% 当在 \documentclass 中检测到 'yuxi' 时，执行以下所有操作
\DeclareOption{yuxi}{
  \renewcommand{\@reporttitle}{物理实验预习报告}
  \excludecomment{fullreportonly}
  \previewreporttrue
}

% 声明选项 'bg'
% 当在 \documentclass 中检测到 'bg' 时，执行以下所有操作
\DeclareOption{bg}{
  \renewcommand{\@reporttitle}{物~理~实~验~报~告}
  % \includecomment 是 comment 宏包的命令，确保环境生效
  \includecomment{fullreportonly}
  \previewreportfalse
}

% 3. ★★★ 设置默认值并执行选项 ★★★
% 如果用户没有提供任何选项，则默认执行 'bg' 选项
\ExecuteOptions{bg}

% 现在，处理用户在 \documentclass[...]{...} 中实际传入的选项
% 它会覆盖上面的默认设置
\ProcessOptions\relax

\newcommand{\templatedir}{./}
\newcommand{\settemplatedir}[1]{\renewcommand{\templatedir}{#1}}

\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}
% 设置版式
\linespread{1.2}
\geometry{top=1in,bottom=1in,left=1.91cm,right=1.91cm}

% 设置标题和字体格式
\setCJKmainfont[ItalicFont={KaiTi},BoldFont={SimHei}]{SimSun}
\setmonofont{DejaVu Sans Mono}
\setCJKfamilyfont{KaiTi}[AutoFakeBold=2.5]{KaiTi}

% 伪粗宋体
\newCJKfontfamily\fakeboldsong{SimSun}[AutoFakeBold = 2.5]
\newcommand{\fbsong}[1]{{\fakeboldsong\bfseries #1}}
% 伪粗仿宋体
\newCJKfontfamily\fakeboldfangsong{FangSong}[AutoFakeBold = 2.5]
\newcommand{\fbfangsong}[1]{{\fakeboldfangsong\bfseries #1}}

\setcounter{secnumdepth}{3}
\renewcommand\thesection{\zhnumber{\arabic{section}}、\hspace{-5.53mm}}
\renewcommand\thesubsection{\arabic{subsection}\hspace{-2.415mm}}
\renewcommand\thesubsubsection{\arabic{subsection}.\arabic{subsubsection}\hspace{-2.415mm}}
\setlist[enumerate,1]{label=(\arabic*)}
\setlist[enumerate,2]{label=\alph*.}
\titleformat{\section}[hang]{\Large\fakeboldsong\bfseries}{\textrm{\thesection}}{1em}{}
\titleformat{\subsection}[hang]{\large\fakeboldsong\bfseries}{\textrm{\thesubsection}}{1em}{}
\titleformat{\subsubsection}[hang]{\normalsize\fakeboldsong\bfseries}{\textrm{\thesubsubsection}}{1em}{}

% 代码格式和颜色定义
\colorlet{keyword}{松花绿}
\colorlet{comment}{漆黑!50}
\colorlet{emph1}{靛蓝}
\colorlet{emph2}{琥珀}
\lstset{
  frame=tb,
  framerule=0.5pt,
  numbers=none,
  breaklines=true,
  breakatwhitespace=true,
  keywordstyle = \bfseries\color{keyword},
  commentstyle = \itshape\color{comment},
  emphstyle    = [1]\itshape\color{emph1},
  emphstyle    = [2]\color{emph2},
  basicstyle   = {\small\ttfamily},
}

% 信息
%\newcommand\major[1]{\def\@major{#1}}
%\newcommand\course[1]{\def\@course{#1}}
\newcommand\exname[1]{\def\@exname{#1}}
%\newcommand\extable[1]{\def\@extable{#1}}
\newcommand\instructor[1]{\def\@instructor{#1}}

\newcommand\class[1]{\def\@class{#1}}
\newcommand\name[1]{\def\@name{#1}}
\newcommand\stuid[1]{\def\@stuid{#1}}


\newcommand\nyear[1]{\def\@nyear{#1}}
\newcommand\nmonth[1]{\def\@nmonth{#1}}
\newcommand\nday[1]{\def\@nday{#1}}
\newcommand\nweekday[1]{\def\@nweekday{#1}}

\newcommand\redate[1]{\def\@redate{#1}}
\newcommand\resitu[1]{\def\@resitu{#1}}
\newcommand\daypart[1]{\def\@daypart{#1}}
%\newcommand\college[1]{\def\@college{#1}}
%\newcommand\lab[1]{\def\@lab{#1}}
%\newcommand\grades[1]{\def\@grades{#1}}
%\newcommand\expname[1]{\def\@expname{#1}}
%\newcommand\exptype[1]{\def\@exptype{#1}}
%\newcommand\partner[1]{\def\@partner{#1}}
\graphicspath{{figures/}}
\newcommand{\insertnotes}{%
  % 在插入文件前，先用 \IfFileExists 检查文件是否存在
  \IfFileExists{\templatedir note.tex}
  {% 如果文件存在 (TRUE block)
    \input{\templatedir note} % 执行插入操作
  }
  {% 如果文件不存在 (FALSE block)
    % 在编译日志(.log)和终端中打印一条明确的警告信息
    \PackageWarning{myphydreport}{
      Notes file not found! I was looking for it at the exact path: '\templatedir/note'
    }
  }%
}
\renewcommand{\figurename}{图}
\renewcommand{\tablename}{表}
\pagestyle{plain}
%\lhead{实验名称：\@expname}
%\chead{姓名：\@name}
%\rhead{学号：\@stuid}

% 下划线定义
\newcommand{\underlinetext}[2][3cm]{%
  \stackunder[0.8ex]{\makebox[#1][c]{#2}}{\rule{#1}{1pt}}%
}

% 封面
\newcommand{\makecover}{

    \phantom{\fontsize{42pt}{50.4pt}\selectfont wcnm的LaTeX}

    \begin{center}
    %   \begin{fullreportonly}
    %   \begin{center}
    %   \includegraphics[width=0.4\linewidth]{figures/浙江大学}
    %   \end{center}
    % \end{fullreportonly}
    \ifpreviewreport
    \else
      % 如果是正式报告 (开关为假)，则显示 Logo
      % 我们先检查用户是否真的用 \logo{} 命令提供了图片
      \begin{center}
        \includegraphics[width=0.4\linewidth]{\templatedir figures/浙江大学}
      \end{center}
    \fi
    {\fontsize{36pt}{6pt}\selectfont \fbsong{\@reporttitle}}\\
    \vspace{15.18mm}
    \vspace{17.712mm}

    \Large
    \centering
    \renewcommand\arraystretch{2}
    \begin{tabular}{l@{}l}
      \fbsong{实验名称：} & \underlinetext[69.125mm]{\@exname} \\
      \fbsong{指导教师：} & \underlinetext[69.125mm]{\@instructor}
    \end{tabular}

    \vspace{19.08mm}
    \large
    \centering
    \renewcommand\arraystretch{2}
    \begin{tabular}{l@{}l}
      \fbsong{班级：} & \underlinetext[79.695mm]{\@class}  \\
      \fbsong{姓名：} & \underlinetext[79.695mm]{\@name}   \\
      \fbsong{学号：} & \underlinetext[79.695mm]{\@stuid}
    \end{tabular}

    \vspace{8.694mm}

    \begin{center}
      \large{\fbsong{实验日期：}\underlinetext[9.66mm]{\@nyear}\fbsong{年}\underlinetext[9.66mm]{\@nmonth}\fbsong{月}\underlinetext[9.66mm]{\@nday}\fbsong{日}\hspace{7.245mm}\fbsong{星期}\underlinetext[7.245mm]{\@nweekday}\fbsong{\@daypart 午}}

      \vspace{8.694mm}

    \large{浙江大学物理实验教学中心}
    \end{center}
  \end{center}
  \thispagestyle{plain}
  \setcounter{page}{0}
  \newpage
}
\endinput

% 三线表使用方法
% \begin{table}[H]
%   \centering
%   \caption{}
%   \begin{tabular}{C{.3\textwidth}C{.3\textwidth}C{.3\textwidth}}
%   \toprule
%   读取值  & 测量值  & 计算误差 \\
%   \midrule
%   10000$\Omega$  & 10001$\Omega$  & 0.01\%  \\
%   100$\Omega$    & 100.4$\Omega$  & 0.40\%  \\
%   100k$\Omega$ & 100.25k$\Omega$ & 0.25\%  \\
%   \bottomrule
%   \end{tabular}
% \end{table}