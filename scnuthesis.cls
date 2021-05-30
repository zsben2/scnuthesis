% !TeX root = ./main.tex
% !TeX program = xelatex

\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\ProvidesExplClass{scnuthesis}{2020/09/07}{v0.1}{zsben}
\RequirePackage { xparse, xtemplate, l3keys2e }
\cs_new:Npn \__scnu_msg_new:nn   { \msg_new:nnn { scnuthesis } }
\cs_new:Npn \__scnu_msg_error:nn { \msg_error:nnn { scnuthesis } }
\cs_generate_variant:Nn \__scnu_msg_error:nn { nx } % 20171128
\__scnu_msg_new:nn { l3-too-old }
  {
    Package ~ "#1" ~ is ~ too ~ old. \\\\
    Please ~ update ~ an ~ up-to-date ~ version ~ of ~ the ~ bundles \\
    "l3kernel" ~ and ~ "l3packages" ~ using ~ your ~ TeX ~ package \\
    manager ~ or ~ from ~ CTAN.
  }
\clist_map_inline:nn { expl3, xparse, xtemplate, l3keys2e }
  {
    \@ifpackagelater { #1 } { 2017/01/01 } { }
      { \__scnu_msg_error:nn { l3-too-old } { #1 } }
  }
\__scnu_msg_new:nn { unsupported-engine }
  {
    The~ scnuthesis~ class~ requires~ either~ xeTeX \\
    "#1"~ is~ not~ supported~ at~ present.~ You~ must~ change \\
    your~ typesetting~ engine~ to~ "xelatex".
  }
\sys_if_engine_xetex:F
  {
    \__scnu_msg_error:nx { unsupported-engine } { \c_sys_engine_str }
  }

\LoadClass [
  twoside,
  openright,
  zihao = -4,
  UTF8
] { ctexbook }

\setCJKmainfont { SimSun } [ AutoFakeBold = 3 ]
\setmainfont { Times ~ New ~ Roman }

\ctexset {
  secnumdepth = subsubsection,
  chapter = {
    number = \thechapter,
    format = \bfseries\zihao{3}\centering,
    beforeskip = 2.4ex,
    afterskip = 2.4ex,
    tocline = \heiti\zihao{3}\CTEXnumberline{#1}#2,
  },
  section = {
    format = \bfseries\zihao{-3},
    beforeskip = 2ex plus 1ex minus .2ex,
    afterskip = 2ex plus .2ex,
    % tocline = \heiti\zihao{-3}\CTEXnumberline{#1}#2,
  },
  subsection = {
    format = \bfseries\zihao{4},
    beforeskip = 2ex plus 1ex minus .2ex,
    afterskip = 2ex plus .2ex,
    % tocline = \heiti\zihao{4}\CTEXnumberline{#1}#2,
  },
  subsubsection = {
    format = \bfseries\zihao{-4},
    beforeskip = 1ex plus .2ex minus .2ex,
    afterskip = 0ex plus .2ex,
  },
  % appendix = {
  %   name = 附录,
  % },
}

\RequirePackage
  {
    amsmath, amssymb, amsthm, array, tabularx, booktabs,
    geometry, graphicx, subfigure, titlesec, titletoc, ulem,
    caption, fancyhdr, pifont, wasysym, newtxmath, enumitem,
    hyperref
  }
\RequirePackage [
  backend = biber,
  style = gb7714-2015,
] { biblatex }
\RequirePackage [ perpage ] { footmisc }

\geometry {
  a4paper,
  includeheadfoot,
  top           = 25mm,
  bottom        = 25mm,
  left          = 20mm,
  right         = 20mm,
  bindingoffset = 10mm,
  headheight    = 9mm,
  headsep       = 1mm,
  footskip      = 10mm,
}

\graphicspath { { fig/ } }

\fancyhf { }
\fancyhead [ C ] { \c__scnu_title_cn_tl }
\fancyfoot [ C ] { \zihao { 5 } \thepage }
\fancypagestyle { plain }
  {
    \fancyhead [ C ] { \c__scnu_title_cn_tl }
    \fancyfoot [ C ] { \zihao { 5 } \thepage }
  }
\RenewDocumentCommand \headrulewidth { } { .4pt }

\RenewExpandableDocumentCommand \theequation { } { \thechapter - \arabic { equation } }
\RenewExpandableDocumentCommand \thefigure { } { \thechapter - \arabic { figure } }
\RenewExpandableDocumentCommand \thetable { } { \thechapter - \arabic { table } }
\RenewExpandableDocumentCommand \thefootnote { } { \__scnu_circle_num:n { footnote } }


\box_new:N \l__scnu_content_box
\dim_new:N \l__scnu_content_wd_dim
\cs_new_protected:Npn \__scnu_content_to_wd:nn #1#2
  { \hbox_to_wd:nn { #1 } { \hfil #2 \hfil } }
\cs_new_protected:Npn \__scnu_content_min_wd:nn #1#2
  {
    \hbox_set:Nn \l__scnu_content_box { #2 }
    \dim_set:Nn \l__scnu_content_wd_dim
      { \box_wd:N \l__scnu_content_box }
    \dim_compare:nNnTF \l__scnu_content_wd_dim > { #1 }
      { #2 }
      { \__scnu_content_to_wd:nn { #1 } { #2 } }
  }
\cs_new_protected:Npn \__scnu_cover_head_underline:N #1
  { \__scnu_content_to_wd:nn { 3.2cm } { #1 } }
\cs_new_protected:Npn \__scnu_cover_mid_underline:n #1
  { \__scnu_content_min_wd:nn { 6cm } { #1 } }

%带圈数字
\cs_new_protected:Npn \__scnu_circle_num:n #1 {%参数是计数器名
  \ding %使用pifont包里\ding产生的带圈数字1~10
    { %181是黑底圈，191是白底圈，可根据需要自行修改
      \numexpr191 + \value{ #1 }
    }
}

\cs_new_protected:Npn \__scnu_statement_title:n #1
  {
    \group_begin:
      \__scnu_vspace_star:n { 2.4ex }
      \centering \zihao { 3 } \heiti
      #1
      \skip_vertical:N 2.4ex
    \group_end:
  }
\cs_new_protected:Npn \__scnu_statement_sign:n #1
  {
    \hfill 学位论文作者签名：
    \IfBooleanT { #1 } { \hphantom }%幻影
    \c__scnu_name_cn_tl
    \par
    \hfill 日期：\today
  }

\cs_new_protected:Npn \__scnu_vspace_star:n { \vspace* }
\cs_new_protected:Npn \__scnu_hspace_star:n { \hspace* }
\cs_new_protected:Npn \__scnu_exp_content_wd:nn #1#2
  {
    \__scnu_hspace_star:n { #1 }
    #2
    \__scnu_hspace_star:n { #1 }
  }
\cs_new_protected:Npn \__scnu_expwd_one_ex:n #1
  { \__scnu_exp_content_wd:nn { 1ex } { #1 } }
\cs_new_protected:Npn \__scnu_expwd_one_em:N #1
  { \__scnu_exp_content_wd:nn { 1em } { #1 } }



\NewDocumentCommand \scnusetup { m }
  { \keys_set:nn { scnu } { #1 } }
\keys_define:nn { scnu }
  {
    分类号   .tl_set:N = \c__scnu_category_tl,
    UDC     .tl_set:N = \c__scnu_udc_tl,
    密级    .tl_set:N = \c__scnu_secrets_tl,
    学号    .tl_set:N = \c__scnu_sno_tl,
    学位类型 .tl_set:N = \c__scnu_type_tl,
    培养层次 .tl_set:N = \c__scnu_level_tl,
    题目     .tl_set:N = \c__scnu_title_cn_tl,
    title   .tl_set:N = \c__scnu_title_en_tl,
    姓名     .tl_set:N = \c__scnu_name_cn_tl,
    name    .tl_set:N = \c__scnu_name_en_tl,
    专业名称 .tl_set:N = \c__scnu_major_cn_tl,
    major   .tl_set:N = \c__scnu_major_en_tl,
    研究方向 .tl_set:N = \c__scnu_field_tl,
    学院    .tl_set:N = \c__scnu_college_tl,
    导师姓名 .tl_set:N = \c__scnu_tutor_cn_tl,
    tutor   .tl_set:N = \c__scnu_tutor_en_tl,
    导师职称 .tl_set:N = \c__scnu_tutor_title_tl,
    bib文件名  .code:n = { \addbibresource { #1 } },
  }

\NewDocumentCommand \makecover { }
  {
    \pagestyle { empty }
    \begin { center }
      \group_begin:
        \zihao { 4 }
        \begin { tabularx } { \linewidth } { @{}llXll@{} }
        分类号： &
        \__scnu_cover_head_underline:N \c__scnu_category_tl &&
        密级： &
        \__scnu_cover_head_underline:N \c__scnu_secrets_tl \\ \cline{2-2}\cline{5-5}
        UDC &
        \__scnu_cover_head_underline:N \c__scnu_udc_tl &&
        学号： &
        \__scnu_cover_head_underline:N \c__scnu_sno_tl \\ \cline{2-2}\cline{5-5}
        \end { tabularx }
      \group_end: \\[1.5cm]

      \includegraphics [ width=11cm ] { scnuname.pdf } \\

      \group_begin:
        \zihao { 3 } \bfseries \itshape
        South ~ China ~ Normal ~ University
      \group_end: \\[1mm]

      \group_begin:
        \zihao{ 1 } \bfseries \ziju { .2 }
        \c__scnu_level_tl 学位论文
      \group_end: \\[2mm]

      \parbox [ c ] [ 2cm ] [ t ] { 5cm }
        {
          \centering
          \tl_if_eq:NnF \c__scnu_level_tl { 博士 }
            {
              \zihao { -3 }
              ( \c__scnu_type_tl 学位 )
            }
        } \\

      \group_begin:
        \zihao { -2 } \bfseries
        \parbox { 9cm } { \centering \c__scnu_title_cn_tl }
      \group_end: \\

      \vfill

      \group_begin:
        \zihao { 4 }
        \begin { tabular } { lc }
          学位申请人 &
          \__scnu_cover_mid_underline:n \c__scnu_name_cn_tl \\ \cline{2-2}
          专业学位名称 &
          \__scnu_cover_mid_underline:n \c__scnu_major_cn_tl \\ \cline{2-2}
          专业学位领域 &
          \__scnu_cover_mid_underline:n \c__scnu_field_tl \\ \cline{2-2}
          所在院系 &
          \__scnu_cover_mid_underline:n \c__scnu_college_tl \\ \cline{2-2}
          导师姓名及职称 &
          \__scnu_cover_mid_underline:n
            { \c__scnu_tutor_cn_tl \ \c__scnu_tutor_title_tl } \\ \cline{2-2}
        \end { tabular }
      \group_end: \\[2cm]
      
      \today
    \end { center }
  }


\RenewDocumentCommand \frontmatter { }
  {
    \cleardoublepage
    \@mainmatterfalse
    \pagenumbering{Roman}
    \pagestyle { fancy }
  }

\NewDocumentEnvironment { cnabstract } { }
  {
    \cleardoublepage
    \__scnu_vspace_star:n { 2.4ex }
    \begin { center }
      \zihao { 3 } \heiti
      \c__scnu_title_cn_tl
      \skip_vertical:N \baselineskip

      \zihao { -4 } \songti
      \begin { tabular } { l l }
      专业名称： &
      \c__scnu_major_cn_tl \\
      申请者： &
      \c__scnu_name_cn_tl \\
      导师： &
      \c__scnu_tutor_cn_tl \\
      \end { tabular }
    \end { center }
    \skip_vertical:N 3\baselineskip

    \noindent
    \zihao { -3 } \heiti
    摘 \quad 要

    \zihao { -4 } \songti 
    \skip_vertical:N \baselineskip %\par
  }
  { \skip_vertical:N \baselineskip }

\NewDocumentCommand \cnkeywords { m }
  {
    \noindent
    \zihao { 4 } \heiti
    关键词：
    \zihao { -4 } \songti
    #1
  }

\NewDocumentEnvironment { enabstract } { }
  {
    \cleardoublepage
    \__scnu_vspace_star:n { 2.4ex }
    \begin { center }
      \zihao { -3 } \sffamily
      \skip_set:Nn \tabcolsep { 0pt }
      \begin { tabularx } { \linewidth } { p{2.5em} X p{2.5em} }
      & \centering \text_uppercase:n \c__scnu_title_en_tl &
      \end { tabularx }
      \skip_vertical:N \baselineskip
    
      \zihao { -4 } \normalfont
      \skip_set:Nn \tabcolsep { 6pt }
      \begin { tabular } { l l }
      Major: &
      \c__scnu_major_en_tl \\
      Name: &
      \c__scnu_name_en_tl \\
      Supervisor: &
      \c__scnu_tutor_en_tl \\
      \end { tabular }
    \end { center }
    \skip_vertical:N 3\baselineskip

    \noindent
    \zihao { 4 } \sffamily
    ABSTRACT

    \zihao { -4 } \normalfont
    \skip_vertical:N \baselineskip %\par
  }
  { \skip_vertical:N 2\baselineskip }

\NewDocumentCommand \enkeywords { m }
  {
    \noindent
    \zihao { -4 } \sffamily
    KEY ~ WORDS: ~
    \normalfont
    #1
  }

\NewDocumentCommand \statement { s }
  {
    \cleardoublepage
    \addcontentsline { toc } { chapter }
      { \zihao { 3 } \heiti 学位论文原创性声明、学位论文使用授权声明 }
    \__scnu_statement_title:n { 华南师范大学位论文原创性声明 }
    本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究工作所取得的成果。除文中己经注月引用的内容外，本论文不含任何其他个人或集体己经发表或撰写过的作品成果。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。
    \par
    本人完全意识到本声明的法律结果由本人承担。
    \skip_vertical:N \baselineskip
    \__scnu_statement_sign:n { #1 }
    \skip_vertical:N \baselineskip

    \__scnu_statement_title:n { 华南师范大学位论文授权使用声明 }
    本人完全了解华南师范大学有关保留、使用学位论文的规定，学校有权保留学位论文并向国家主管部门或其指定机构送交论文的电子版和纸质版。有权将学位论文用于非贏利目的的少量复制并允许论文进入学校图书馆被查阅。有权将学位论文的内容编入有关数据库进行检索。有权将学位论文的标题和摘要汇编出版。保密的学位论文在解密后适用本规定。
    \skip_vertical:N \baselineskip
    \__scnu_statement_sign:n { #1 }
  }

\NewDocumentCommand \publication { s }
  {
    \cleardoublepage
    \__scnu_statement_title:n { 《学位论文出版授权书》 }
    本人完全同意《中国优秀博硕士学位论文全文数据库出版章程》（以下简称“章程”），愿意将本人的学位论文提交“中国学术期刊（光盘版）电子杂志社”在《中国博士学位论文全文数据库》、《中国优秀硕士学位论文全文数据库》中全文发表。《中国博士学位论文全文数据库》、《中国优秀硕士学位论文全文数据库》可以以电子、网络及其他数字媒体形式公开出版，并同意编入《中国知识资源总库》，在《中国博硕士学位论文评价数据库》 中使用和在互联网上传播，同意按“章程”规定享受相关权益。
    \skip_vertical:N \baselineskip

    \hfill 作者签名：
    \IfBooleanT { #1 } { \hphantom }%幻影
    \underline { \__scnu_expwd_one_em:N \c__scnu_name_cn_tl  }
    \par
    \hfill
    \underline { \__scnu_expwd_one_ex:n { \the \year } } 年
    \underline { \__scnu_expwd_one_ex:n { \the \month } } 月
    \underline { \__scnu_expwd_one_ex:n { \the \day } } 日
    \skip_vertical:N \baselineskip

    \noindent
    \begin { tabularx } { \linewidth }
      {
        | c |
        X < { \centering } |
        c |
        X < { \centering } |
        *2 { c| }
      }
    \hline
    论文题目 & \multicolumn { 5 } { c| } { \c__scnu_title_cn_tl } \\ \hline
    研究生学号 & \c__scnu_sno_tl & 所在院系 & \c__scnu_college_tl & 学位年度 & \the \year \\ \hline
    论文级别 & \multicolumn { 5 } { l| }
      { 
        \begin { tabularx } { .79\linewidth } { X X r }
        \CheckedBox 硕士 & \Square 专业学位硕士 \\
        \Square 直博(含提前攻博) & \Square 普博(含论文博士) \\
        & & (请在方框上画勾)
        \end{tabularx}
      } \\ \hline
    作者电话 & \c__scnu_name_cn_tl & 作者 Email & \multicolumn { 3 } { c| } { } \\ \hline
    第一导师姓名 & \c__scnu_tutor_cn_tl & 导师电话 & \multicolumn { 3 } { c| } { } \\ \hline
    第二导师姓名 & \c__scnu_tutor_cn_tl & 导师电话 & \multicolumn { 3 } { c| } { } \\ \hline
    \end { tabularx }
  }
