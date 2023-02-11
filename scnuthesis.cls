% !TeX root = ./main.tex
% !TeX program = xelatex
%%
%% This is file `scnuthesis.cls',
%% Template download from https://github.com/zsben2/scnuthesis
%% scnuthesis.cls 2020/09/26 version v0.1 created by Sunben Chiu
%% scnuthesis.cls 2022/12/26 version v0.2 created by Sunben Chiu
%% scnuthesis.cls 2023/02/05 version v0.3 created by Sunben Chiu
%% scnuthesis.cls 2023/02/10 version v0.4 created by Sunben Chiu
%% scnuthesis.cls 2023/02/11 version v0.5 created by Sunben Chiu

\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\ProvidesExplClass{scnuthesis}{2023-02-11}{0.5}{Typesetting thesis for South China Normal University}
\RequirePackage { xparse, xtemplate, l3keys2e }
\tl_const:Nn \c__scnu_name_tl { 华南师范大学 }
\cs_new:Npn \__scnu_msg_new:nn   { \msg_new:nnn   { scnuthesis } }
\cs_new:Npn \__scnu_msg_error:nn { \msg_error:nnn { scnuthesis } }
\cs_generate_variant:Nn \str_range_ignore_spaces:nnn { Vnn }
\cs_generate_variant:Nn \prg_new_conditional:Npnn { cpnn }
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
    \@ifpackagelater {#1} { 2017/01/01 } { }
      { \__scnu_msg_error:nn { l3-too-old } {#1} }
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


\clist_new:N \g__scnu_std_options_clist
\clist_set:Nn \g__scnu_std_options_clist { zihao = -4, UTF8 }



\tl_new:N \g__scnu_edition_tl
\seq_const_from_clist:Nn \c__scnu_edition_seq { debug, electronic, print, blindreview }
\keys_define:nn { scnu / option }
  {
    edition .choices:xn = { \seq_use:Nn \c__scnu_edition_seq { , } }
      { \tl_gset_eq:NN \g__scnu_edition_tl \l_keys_choice_tl },
    edition  .initial:n = { electronic }
  }
\ProcessKeysOptions { scnu / option }

\prg_new_conditional:Npnn \__scnu_edition_if_in:n #1 { T, F, TF }
  {
    \clist_if_in:nVTF {#1} \g__scnu_edition_tl
      { \prg_return_true: } { \prg_return_false: }
  }
\seq_map_inline:Nn \c__scnu_edition_seq
  {
    \prg_new_conditional:cpnn { __scnu_edition_if_ #1 : } { T, F, TF }
      {
        \__scnu_edition_if_in:nTF {#1}
          { \prg_return_true: } { \prg_return_false: }
      }
  }

\__scnu_edition_if_print:TF
  {
    \clist_gput_right:Nn \g__scnu_std_options_clist { twoside }
    \clist_gput_right:Nn \g__scnu_std_options_clist { openright }
  }
  {
    \clist_gput_right:Nn \g__scnu_std_options_clist { oneside }
    \clist_gput_right:Nn \g__scnu_std_options_clist { openany }
  }
\PassOptionsToClass { \g__scnu_std_options_clist } { ctexbook }
\LoadClass { ctexbook }



\RequirePackage { xeCJKfntef }

% 分别修改 \songti, \heiti, \kaishu, \normalfont 的字体设置
\setCJKfamilyfont { zhsong } { SimSun } [ Mapping = fullwidth-stop ]
\setCJKfamilyfont { zhhei  } { SimHei } [ Mapping = fullwidth-stop, AutoFakeBold = 2 ]
\setCJKfamilyfont { zhkai  } { KaiTi  } [ Mapping = fullwidth-stop ]
\setCJKmainfont   { SimSun } [
  AutoFakeBold = 3,
  Mapping      = fullwidth-stop,
  ItalicFont   = KaiTi,
  BoldFont     = SimHei,
]



\setmainfont { Times ~ New ~ Roman }

\xeCJKsetup {
  AutoFallBack   = true,
  underline/skip = false,
}

\ctexset {
  % contentsname = { 目\quad 录 },
  secnumdepth  = subsubsection,
  chapter = {
    number     = \arabic{chapter},
    % nameformat = \heiti\zihao{2},
    % format    += \bfseries,
    format     = \bfseries\heiti\zihao{2}\centering,
    beforeskip = 2ex,
    afterskip  = 3ex plus 1ex minus .2ex,
    % tocline    = \CTEXnumberline{#1}#2,
  },
  section = {
    % nameformat = \zihao{3}\bfseries,
    format     = \bfseries\heiti\zihao{3},
    beforeskip = 2ex plus 1ex minus .2ex,
    afterskip  = 2ex plus .2ex,
    % tocline    = \heiti\zihao{-3}\CTEXnumberline{#1}#2,
  },
  subsection = {
    format     = \heiti\zihao{-3},
    beforeskip = 2ex plus 1ex minus .2ex,
    afterskip  = 2ex plus .2ex,
    % tocline    = \heiti\zihao{4}\CTEXnumberline{#1}#2,
  },
  subsubsection = {
    format     = \heiti\zihao{-4},
    beforeskip = 1ex plus .2ex minus .2ex,
    afterskip  = 1ex plus .2ex,
  },
}



\__scnu_edition_if_print:TF
  { \RequirePackage { lscape } }
  {
    \RequirePackage { pdflscape }
    \ctex_hypersetup:n
      {
        colorlinks,
        linkcolor = red,
        citecolor = green,
        urlcolor = blue
      }
  }
\ctex_hypersetup:n { bookmarksnumbered, pdfdisplaydoctitle }
\RequirePackage
  {
    mathtools, amsthm, amssymb, tabularx, booktabs, pdfpages,
    graphicx, subfigure, caption, fancyhdr, stfloats, xpatch,
    wasysym, siunitx, mathrsfs, longtable, hyperref, cleveref, hyperxmp,
  }
% 自定义宏包
\clist_map_inline:nn { l3group, tblrhook, circlenum }
  { \RequirePackage { tools / #1 } }
\cs_undefine:N \Bbbk
\RequirePackage { mtpro2 }
\RequirePackage [
  backend      = biber,
  style        = gb7714-2015,
  defernumbers = true
] { biblatex }
\RequirePackage [ perpage ] { footmisc } % 重置文档每页的脚注编号
% 页面设置
\RequirePackage [
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
] { geometry }
\RequirePackage [
  shortlabels,
  inline
] { enumitem }
% 枚举设置
\setlist [ enumerate ] {
  label* = (\arabic*),
  font   = \upshape\rmfamily\mdseries
}
% 引用设置
\crefname { figure }   { 图 } { 图 }
\crefname { table }    { 表 } { 表 }
\crefname { appendix } { 附录 } { 附录 }
% \crefname { equation } { 式 } { 式 } % 设置 \cref@equation@name
% \crefformat { equation } { ( #2 #1 #3 ) \cref@equation@name }
\crefformat { equation } { ( #2 #1 #3 ) 式 }
\crefformat { chapter }  {  第 ~ #2 #1 #3 ~ 章 }
\crefrangelabelformat { proposition } { #3 #1 #4 ~ 至 ~ #5 #2 #6 }
% 图片文件夹
\graphicspath { { fig/ } }
% 脚注在 b 选项的浮动体下
\fnbelowfloat


% 页眉页脚
\fancyhf { }
% \fancyhead [ C ] { \g__scnu_title_cn_tl }
\fancyfoot [ C ] { \zihao { 5 } \thepage }
\fancypagestyle { plain }
  {
    % \fancyhead [ C ] { \g__scnu_title_cn_tl }
    \fancyfoot [ C ] { \zihao { 5 } \thepage }
  }
% \RenewDocumentCommand \headrulewidth { } { .4pt }
\RenewDocumentCommand \headrulewidth { } { 0pt }


% 计数器
\RenewExpandableDocumentCommand \theequation { } { \thechapter . \arabic { equation } }
\RenewExpandableDocumentCommand \thefigure   { } { \thechapter . \arabic { figure   } }
\RenewExpandableDocumentCommand \thetable    { } { \thechapter . \arabic { table    } }
\RenewExpandableDocumentCommand \thefootnote { } { \circlenum_printing:n { footnote } }


% 数学元素

% 设置数学冒号垂直居中
\mathtoolsset { centercolon }
% align等环境允许换页
\allowdisplaybreaks [ 4 ]

% amsthm宏包调整定理环境前后额外间距的方式
% \setlength\topsep{0pt}
% 通过查amsthm.sty文件第434行，消除证明环境前后额外间距，需要etoolbox或xpatch
% \AtBeginEnvironment{proof}{
%   \vspace{-6\p@\@minus6\p@}
% }
% \AtEndEnvironment{proof}{
%   \vspace{-6\p@\@minus6\p@}
% }
% 修改证明标签的字体样式
% 参考自 https://tex.stackexchange.com/a/44114
\xpatchcmd { \proof } { \itshape } { \kaishu } { } { }


% 定理环境统一设置

% 定理环境风格汉化
\newtheoremstyle { cnplain } % name
  { } % Space above
  { } % Space below
  { \kaishu } % body font
  { } % indent amount
  { \bfseries } % theorem head font
  { . } % punctuation after theorem head
  { 5pt plus 1pt minus 1pt } % space after theorem head
  { } % theorem head spec (cna be left empty, meaning `normal')
\newtheoremstyle { cndefinition }
  { }
  { }
  { \normalfont }
  { }
  { \bfseries }
  { . }
  { 5pt plus 1pt minus 1pt }
  { }
\newtheoremstyle { cnremark }
  { }
  { }
  { \normalfont }
  { }
  { \kaishu }
  { . }
  { 5pt plus 1pt minus 1pt }
  { }

% 使用方法 \addtheorem[<style>]{<environment name>=<Chinese name>, <environment name>, ...}[<super counter>]
\NewDocumentCommand \addtheorem { O{cndefinition} m O{} }
  {
    \keyval_parse:nnn
      { \__scnu_new_english_theorem:nnn  {#1} {#3} }
      { \__scnu_new_chinese_theorem:nnnn {#1} {#3} }
      {#2}
  }

% 定理环境定义
% #1: style, #2: super counter, #3: environment name, #4: label name
\cs_new_protected:Npn \__scnu_new_theorem_body:nnnn #1#2#3#4
  {
    \theoremstyle {#1}
    % \newtheorem 不会展开第 2 个参数，因此要人为展开。
    % \exp_last_unbraced:Ne 也可用 :Nx 参数
    \exp_last_unbraced:Ne \newtheorem { {#3} {#4} [#2] } % 有编号环境
    \exp_last_unbraced:Ne \newtheorem { * {#3*} {#4} } % amsthm 宏包无编号环境定义
    \crefname {#3} {#4} {#4} % 引用设置
  }
% #1: style, #2: super counter, #3: environment name
\cs_new_protected:Npn \__scnu_new_english_theorem:nnn #1#2#3
  {
    \__scnu_new_theorem_body:nnnn {#1} {#2} {#3} { \text_titlecase:n {#3} }
  }
% #1: style, #2: super counter, #3: environment name, #4: chinese name
\cs_new_protected:Npn \__scnu_new_chinese_theorem:nnnn #1#2#3#4
  {
    \__scnu_new_theorem_body:nnnn {#1} {#2} {#3} {#4}
  }




% 定宽盒子，居中文字
\box_new:N \l__scnu_content_box
\dim_new:N \l__scnu_content_wd_dim
\cs_new_protected:Npn \__scnu_content_to_wd:nn #1#2
  { \hbox_to_wd:nn {#1} { \hfil #2 \hfil } }
\cs_new_protected:Npn \__scnu_content_min_wd:nn #1#2
  {
    \hbox_set:Nn \l__scnu_content_box {#2}
    \dim_set:Nn \l__scnu_content_wd_dim
      { \box_wd:N \l__scnu_content_box }
    \dim_compare:nNnTF \l__scnu_content_wd_dim > {#1}
      {#2}
      { \__scnu_content_to_wd:nn {#1} {#2} }
  }
\cs_new_protected:Npn \__scnu_cover_head_underline:N #1
  { \__scnu_content_to_wd:nn { 3.2cm } {#1} }
\cs_new_protected:Npn \__scnu_cover_mid_underline:n #1
  { \__scnu_content_min_wd:nn { 6cm } {#1} }
% 生成 \__scnu_cover_mid_underline:V, \__scnu_content_min_wd:nV
\cs_generate_variant:Nn \__scnu_cover_mid_underline:n { V }
\cs_generate_variant:Nn \__scnu_content_min_wd:nn { nV }

% 原创声明元素
\group_cs_new:Npn \__scnu_statement_title:n #1
  {
    \__scnu_vspace_star:n { 2.4ex }
    \centering \zihao { 3 } \heiti
    #1
    \skip_vertical:N 2.4ex
  }
\cs_new_protected:Npn \__scnu_statement_signature:
  {
    \hfill 学位论文作者签名：
    \__scnu_edition_if_in:nT { print, blindreview } { \hphantom }%幻影
    \g__scnu_signature_tl
    \par
    \hfill 日期：
    \g__scnu_date_tl
  }


\cs_new_protected:Npn \__scnu_vspace_star:n #1 { \vspace* { \dim_eval:n {#1} } }
\cs_new_protected:Npn \__scnu_hspace_star:n #1 { \hspace* { \dim_eval:n {#1} } }
\cs_new_protected:Npn \__scnu_exp_content_wd:nn #1#2
  {
    \__scnu_hspace_star:n {#1}
    #2
    \__scnu_hspace_star:n {#1}
  }
\cs_new_protected:Npn \__scnu_expwd_one_ex:n #1
  { \__scnu_exp_content_wd:nn { 1ex } {#1} }
\cs_new_protected:Npn \__scnu_expwd_one_em:N #1
  { \__scnu_exp_content_wd:nn { 1em } {#1} }
\cs_new_protected:Npn \__scnu_CJK_fill_twosides:nn #1#2
  {
    \CJKfilltwosides {#1}
    #2
    \endCJKfilltwosides
  }
\cs_new_protected:Npn \__scnu_skip_one_line:
  { \skip_vertical:N \baselineskip }
% 这里用 \cs_new_protected:Npn 会报错，确实不能限制展开
\cs_new:Npn \__scnu_cover_noalign_skip:
  { \noalign { \skip_vertical:n { 5mm } } }



\NewDocumentCommand \scnusetup { m }
  { \keys_set:nn { scnu } {#1} }
\keys_define:nn { scnu }
  {
    分类号	  .tl_set:N = \g__scnu_category_tl,
    学校代码	.tl_set:N = \g__scnu_udc_tl,
    密级	    .tl_set:N = \g__scnu_secrets_tl,
    学号	    .tl_set:N = \g__scnu_sno_tl,
    学位类型	.tl_set:N = \g__scnu_type_tl,
    培养层次	.tl_set:N = \g__scnu_degree_tl,
    题目	    .tl_set:N = \g__scnu_title_cn_tl,
    title   .tl_set:N = \g__scnu_title_en_tl,
    姓名	    .tl_set:N = \g__scnu_name_cn_tl,
    name    .tl_set:N = \g__scnu_name_en_tl,
    手机号	  .tl_set:N = \g__scnu_phone_tl,
    email   .tl_set:N = \g__scnu_email_tl,
    专业名称	.tl_set:N = \g__scnu_major_cn_tl,
    major   .tl_set:N = \g__scnu_major_en_tl,
    研究方向	.tl_set:N = \g__scnu_field_tl,
    学院		  .tl_set:N = \g__scnu_college_tl,
    导师姓名	.tl_set:N = \g__scnu_tutor_cn_tl,
    tutor   .tl_set:N = \g__scnu_tutor_en_tl,
    导师职称	.tl_set:N = \g__scnu_tutor_title_tl,
    date    .tl_set:N = \g__scnu_date_tl,

    bib文件名	.code:n = { \addbibresource {#1} },
    签名图	    .code:n =
      {
        \file_if_exist:nTF { fig / #1 }
          {
            \tl_gset:Nn \g__scnu_signature_tl
              { \includegraphics [ width = 2.5cm ] {#1} }
          }
          { \tl_gset_eq:NN \g__scnu_signature_tl \g__scnu_name_cn_tl }
      },
    答辩通过证明 .code:n =
      {
        \tl_set:Nn \l__scnu_passdefense_filename_tl { fig / #1 }
      },
    原创授权声明 .code:n =
      {
        \file_if_exist:nTF { fig / #1 }
          {
            \tl_set:Nn \l__scnu_statement_tl
              { \includepdf [ pages = -, landscape, fitpaper ] { fig / #1 } }
          }
          { \tl_set:Nn \l__scnu_statement_tl { \l__scnu_statement_text_tl } }
      },

    分类号	  .initial:n = { },
    学校代码	.initial:n = { },
    密级	    .initial:n = { },
    学号	    .initial:n = { },
    学位类型	.initial:n = { },
    培养层次	.initial:n = { },
    题目	    .initial:n = { },
    title   .initial:n = { },
    姓名	    .initial:n = { },
    name    .initial:n = { },
    手机号	  .initial:n = { },
    email   .initial:n = { },
    专业名称	.initial:n = { },
    major   .initial:n = { },
    研究方向	.initial:n = { },
    学院		  .initial:n = { },
    导师姓名	.initial:n = { },
    tutor   .initial:n = { },
    导师职称	.initial:n = { },
    date    .initial:n = { \today },
    签名图	  .initial:n = { \g__scnu_name_cn_tl },
    答辩通过证明 .initial:n = { },
    原创授权声明 .initial:n = { },
  }



\AtBeginDocument
  {
    \__scnu_edition_if_blindreview:T
      {
        \tl_gclear:N \g__scnu_name_cn_tl
        \tl_gclear:N \g__scnu_name_en_tl
        \tl_gclear:N \g__scnu_email_tl
        \tl_gclear:N \g__scnu_tutor_cn_tl
        \tl_gclear:N \g__scnu_tutor_en_tl
        \tl_gclear:N \g__scnu_tutor_title_tl
      }
  }



\newcolumntype { s } [ 1 ]
  {
    > { \CJKfilltwosides {#1} }
    l
    < { \endCJKfilltwosides }
  }
\newcolumntype { C } [ 1 ]
  {
    p {#1}
    < { \centering }
  }

\group_tl_set:Nnn \l__scnu_cover_head_tl
  { \zihao { 4 } }
  {
    \tb_tabular_add_to_cr:n { \cline{2-2} \cline{5-5} }
    \begin { tabularx } { \linewidth }
      {
        s{ 4\ccwd } @{：}
        l
        X
        l @{：}
        l @{}
      }
    分类号 &
    \__scnu_cover_head_underline:N \g__scnu_category_tl &&
    密级 &
    \__scnu_cover_head_underline:N \g__scnu_secrets_tl \\
    学校代码 &
    \__scnu_cover_head_underline:N \g__scnu_udc_tl &&
    学号 &
    \__scnu_cover_head_underline:N \g__scnu_sno_tl \\
    \end { tabularx }
  }
\group_tl_set:Nnn \l__scnu_cover_school_name_tl
  { \zihao { 3 } \bfseries \itshape }
  { South ~ China ~ Normal ~ University }
\group_tl_set:Nnn \l__scnu_cover_degree_type_tl
  { \zihao{ 1 } \bfseries \ziju { .2 } }
  { \g__scnu_degree_tl 学位论文 }
\group_tl_set:Nnn \l__scnu_cover_master_type_tl
  { \zihao { -3 } }
  {
    \parbox [ c ] [ 2cm ] [ t ] { 5cm }
      {
        \centering
        \tl_if_eq:NnF \g__scnu_degree_tl { 博士 }
          { ( \g__scnu_type_tl 型学位 ) }
      }
  }
\group_tl_set:Nnn \l__scnu_cover_title_tl
  { \zihao { -2 } \bfseries }
  { \parbox { 9cm } { \centering \g__scnu_title_cn_tl } }
\group_tl_set:Nnn \l__scnu_cover_information_tl
  { \fangsong \zihao { 4 } }
  {
    \tb_tabular_add_to_cr:n
      {
        \cline{2-2}
        \__scnu_cover_noalign_skip:
      }
    \begin { tabular }
      {
        s{ 7\ccwd } @{：}
        c
      }
      学位申请人 &
      \__scnu_cover_mid_underline:V \g__scnu_name_cn_tl  \\
      专业学位名称 &
      \__scnu_cover_mid_underline:V \g__scnu_major_cn_tl \\
      专业学位领域 &
      \__scnu_cover_mid_underline:V \g__scnu_field_tl    \\
      所在院系 &
      \__scnu_cover_mid_underline:V \g__scnu_college_tl  \\
      导师姓名及职称 &
      \__scnu_cover_mid_underline:n
        { \g__scnu_tutor_cn_tl \c_space_tl \g__scnu_tutor_title_tl } \\
    \end { tabular }
  }
\group_tl_set:Nnn \l__scnu_cover_date_tl
  { \fangsong } { \g__scnu_date_tl }


\NewDocumentCommand \makecover { }
  {
    \pagestyle { empty }
    \begin { center }
      \l__scnu_cover_head_tl \\[15mm]
      \includegraphics [ width = 11cm ] { scnuname } \\
      \l__scnu_cover_school_name_tl \\[1mm]
      \l__scnu_cover_degree_type_tl \\[2mm]
      \l__scnu_cover_master_type_tl \\
      \l__scnu_cover_title_tl \\ \vfill
      \l__scnu_cover_information_tl \\[15mm]
      \l__scnu_cover_date_tl
    \end { center }
  }



\NewDocumentEnvironment { fpage } { }
  {
    \group_begin:
    \zihao { 3 }
    \setlength { \tabcolsep } { 1cm }
    \tb_tabularx_add_to_end:n { \\ \hline }

    \noindent
    \tabularx { \linewidth } { | X | }
    \hline
  }
  {
    % \\ \hline
    \endtabularx
    \group_end:
    \par
  }

\group_tl_set:Nn \l__scnu_passdefense_proof_tl
  {
    \__scnu_hspace_star:n { 2\ccwd }
    学位申请人
    \CJKunderline { \__scnu_content_min_wd:nV { 4em } \g__scnu_name_cn_tl }
    向本学位论文答辩委员会提交题为
    \CJKunderline { \__scnu_content_min_wd:nV { 15em } \g__scnu_title_cn_tl }
    的博士/硕士论文，经答辩委员会审议，本论文答辩合格，特此证明。
  }
\group_tl_set:Nn \l__scnu_passdefense_instructor_tl
  {
    \__scnu_hspace_star:n { 2\ccwd }
    论文指导老师：
    \CJKunderline { \__scnu_exp_content_wd:nn { 1cm } { \g__scnu_tutor_cn_tl } }
  }
\group_tl_set:Nn \l__scnu_passdefense_signature_tl
  {
    \hfill
    \c__scnu_name_tl
    \g__scnu_college_tl
    （公章）
  }
\group_tl_set:Nn \l__scnu_passdefense_date_tl
  {
    \hfill
    \g__scnu_date_tl
  }
\group_tl_set:Nnn \l__scnu_passdefense_endnote_text_tl
  { \zihao { 5 } }
  { （此页须放在提交版论文封面后第一页，纸质版装订，电子版放入彩色扫描件） }
\group_tl_set:Nn \l__scnu_passdefense_endnote_tl
  {
    \hfill
    \box_new:N \l__scnu_passdefense_endnote_box
    \hbox_set:Nn \l__scnu_passdefense_endnote_box
      { \l__scnu_passdefense_endnote_text_tl }
    \raisebox
      { - \box_ht_plus_dp:N \l__scnu_passdefense_endnote_box }
      {
        \box_set_ht:Nn \l__scnu_passdefense_endnote_box { 0pt }
        \box_set_dp:Nn \l__scnu_passdefense_endnote_box { 0pt }
        \box_use:N \l__scnu_passdefense_endnote_box
      }
  }
\group_cs_new:Npn \__scnu_passdefense_memberlist:n #1
  {
    \begin { center }
    \zihao { -4 }
    \setlength { \tabcolsep } { 16pt }
    \renewcommand \arraystretch { 1.5 }
    \tb_tabular_add_to_cr:n { \hline }
    \begin { tabular }
      {
        | C { 4em }
        | C { 4em }
        | C { 8em }
        | C { 4em } |
      }
    \hline
    #1
    \end { tabular }
    \end { center }
  }
\cs_new:Npn \__scnu_passdefense_text:n #1
  {
    \begin { fpage }
    \__scnu_statement_title:n { \c__scnu_name_tl 研究生学位论文答辩合格证明 }
    \l__scnu_passdefense_proof_tl \\
    \__scnu_statement_title:n { 博士 / 硕士学位论文答辩委员会成员名单 }
    \__scnu_passdefense_memberlist:n {#1} \\ \\
    \l__scnu_passdefense_instructor_tl \\ \\
    \l__scnu_passdefense_signature_tl \\
    \l__scnu_passdefense_date_tl \\
    \end { fpage }

    \l__scnu_passdefense_endnote_tl
  }


\NewDocumentEnvironment { memberlist } { b }
  {
    \cleardoublepage
    \file_if_exist:nTF { \l__scnu_passdefense_filename_tl }
      { \includepdf [ pages = -, landscape, fitpaper ] { \l__scnu_passdefense_filename_tl } }
      { \__scnu_passdefense_text:n {#1} }
  } { }


\NewDocumentCommand \electronicinput { m }
  {
    \__scnu_edition_if_electronic:T { \input {#1} }
  }

\NewDocumentCommand \unblindinput { m }
  {
    \__scnu_edition_if_blindreview:F { \input {#1} }
  }


\RenewDocumentCommand \frontmatter { }
  {
    \cleardoublepage
    \@mainmatterfalse
    \pagenumbering { Roman }
    \pagestyle { fancy }
  }

\appto \mainmatter
  {
    \hypersetup
      {
        pdftitle      = { \g__scnu_title_cn_tl },
        pdfauthor     = { \g__scnu_name_cn_tl },
        pdfkeywords   = { \seq_use:Nn \g__scnu_keywords_cn_seq { ;~ } },
        pdfsubject    = { \g__scnu_field_tl },
        pdflicenseurl = { https://github.com/zsben2/scnuthesis },
        pdfcreator    =
          {
            LaTeX~ with~ scnuthesis~
            \use:c { ver@scnuthesis.cls } ~
            and~ hyperref~
            \use:c { ver@hyperref.sty }
          },
        pdfinfo       = {
          分类号	      = { \g__scnu_category_tl },
          学校代码	    = { \g__scnu_udc_tl },
          密级	        = { \g__scnu_secrets_tl },
          学号	        = { \g__scnu_sno_tl },
          培养层次	    = { \g__scnu_degree_tl },
          题目	        = { \g__scnu_title_cn_tl },
          title       = { \g__scnu_title_en_tl },
          姓名	        = { \g__scnu_name_cn_tl },
          author      = { \g__scnu_name_en_tl },
          email       = { \g__scnu_email_tl },
          专业名称	    = { \g__scnu_major_cn_tl },
          major       = { \g__scnu_major_en_tl },
          研究方向	    = { \g__scnu_field_tl },
          学院	        = { \g__scnu_college_tl },
          学校	        = { \c__scnu_name_tl },
          导师	        = { \g__scnu_tutor_cn_tl },
          tutor       = { \g__scnu_tutor_en_tl },
          文章定版日期	= { \g__scnu_date_tl },
        }
      }
  }

\group_tl_set:Nnn \l__scnu_cnabstract_title_tl
  { \zihao { 3 } \heiti } { \g__scnu_title_cn_tl }
\group_tl_set:Nnn \l__scnu_cnabstract_information_tl
  { \songti }
  {
    \begin { tabular }
      {
        s{ 4\ccwd } @{：}
        l
      }
    专业名称 &
    \g__scnu_major_cn_tl \\
    申请者 &
    \g__scnu_name_cn_tl \\
    导师 &
    \g__scnu_tutor_cn_tl \\
    \end { tabular }
  }
\group_tl_set:Nnn \l__scnu_cnabstract_label_tl
  { \zihao { -3 } \heiti }
  {
    \noindent
    \__scnu_CJK_fill_twosides:nn { 3\ccwd } { 摘要 }
  }
\group_tl_set:Nnn \l__scnu_cnkeywords_label_tl
  { \zihao { 4 } \heiti }
  {
    \noindent
    关键词：
  }

\NewDocumentEnvironment { cnabstract } { }
  {
    \cleardoublepage
    \phantomsection
    \addcontentsline { toc } { chapter } { 摘要 }
    \__scnu_vspace_star:n { 2.4ex }
    \begin { center }
      \l__scnu_cnabstract_title_tl
      \__scnu_skip_one_line:
      \l__scnu_cnabstract_information_tl
    \end { center }
    \skip_vertical:N 3\baselineskip

    \l__scnu_cnabstract_label_tl
    \__scnu_skip_one_line: %\par
  }
  { \__scnu_skip_one_line: }


\seq_new:N \g__scnu_keywords_cn_seq
\NewDocumentCommand \cnkeywords { O{；} m }
  {
    \seq_gset_from_clist:Nn \g__scnu_keywords_cn_seq {#2}
    \l__scnu_cnkeywords_label_tl
    \seq_use:Nn \g__scnu_keywords_cn_seq {#1}
  }


\group_tl_set:Nnn \l__scnu_enabstract_title_tl
  { \zihao { -3 } \sffamily }
  {
    \skip_set:Nn \tabcolsep { 0pt }
    \begin { tabularx } { \linewidth } { p{2.5em} X p{2.5em} }
    & \centering \text_uppercase:n { \g__scnu_title_en_tl } &
    \end { tabularx }
  }
\group_tl_set:Nn \l__scnu_enabstract_information_tl
  {
    \skip_set:Nn \tabcolsep { 6pt }
    \begin { tabular } { l l }
    Major: &
    \g__scnu_major_en_tl \\
    Name: &
    \g__scnu_name_en_tl \\
    Supervisor: &
    \g__scnu_tutor_en_tl \\
    \end { tabular }
  }
\group_tl_set:Nnn \l__scnu_enabstract_label_tl
  { \zihao { 4 } \sffamily }
  { \noindent ABSTRACT }
\group_tl_set:Nnn \l__scnu_enkeywords_label_tl
  { \sffamily }
  { \noindent KEY ~ WORDS: ~ }

\NewDocumentEnvironment { enabstract } { }
  {
    \cleardoublepage
    \phantomsection
    \addcontentsline { toc } { chapter } { ABSTRACT }
    \__scnu_vspace_star:n { 2.4ex }
    \begin { center }
      \l__scnu_enabstract_title_tl
      \__scnu_skip_one_line:
      \l__scnu_enabstract_information_tl
    \end { center }
    \skip_vertical:N 3\baselineskip

    \l__scnu_enabstract_label_tl
    \__scnu_skip_one_line: %\par
  }
  { \skip_vertical:N 2\baselineskip }

\NewDocumentCommand \enkeywords { m }
  {
    \l__scnu_enkeywords_label_tl
    #1
  }



\tl_set:Nn \l__scnu_statement_text_tl
  {
    \__scnu_statement_title:n { \c__scnu_name_tl 学位论文原创性声明 }
    本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究工作所取得的成果。除文中己经注明引用的内容外，本论文不含任何其他个人或集体己经发表或撰写过的作品成果。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。
    \par
    本人完全意识到本声明的法律结果由本人承担。
    \__scnu_skip_one_line:
    \__scnu_statement_signature:
    \__scnu_skip_one_line:

    \__scnu_statement_title:n { \c__scnu_name_tl 学位论文使用授权声明 }
    本人完全了解 \c__scnu_name_tl 有关保留、使用学位论文的规定，学校有权保留学位论文并向国家主管部门或其指定机构送交论文的电子版和纸质版。有权将学位论文用于非贏利目的的少量复制并允许论文进入学校图书馆被查阅。有权将学位论文的内容编入有关数据库进行检索。有权将学位论文的标题和摘要汇编出版。保密的学位论文在解密后适用本规定。
    \__scnu_skip_one_line:
    \__scnu_statement_signature:
  }

\NewDocumentCommand \statement { s }
  {
    \cleardoublepage
    \phantomsection
    \addcontentsline { toc } { chapter }
      { 学位论文原创性声明、学位论文使用授权声明 }
    \l__scnu_statement_tl
  }

\NewDocumentCommand \publication { }
  {
    \cleardoublepage
    \__scnu_statement_title:n { 《学位论文出版授权书》 }
    本人完全同意《中国优秀博硕士学位论文全文数据库出版章程》（以下简称“章程”），愿意将本人的学位论文提交“中国学术期刊（光盘版）电子杂志社”在《中国博士学位论文全文数据库》、《中国优秀硕士学位论文全文数据库》中全文发表。《中国博士学位论文全文数据库》、《中国优秀硕士学位论文全文数据库》可以以电子、网络及其他数字媒体形式公开出版，并同意编入《中国知识资源总库》，在《中国博硕士学位论文评价数据库》 中使用和在互联网上传播，同意按“章程”规定享受相关权益。
    \__scnu_skip_one_line:

    \hfill 作者签名：
    \CJKunderline
      {
        \__scnu_edition_if_in:nT { print, blindreview } { \hphantom } % 幻影
        { \__scnu_expwd_one_em:N \g__scnu_signature_tl }
      }
    \par
    \hfill
    \g__scnu_date_tl
    \__scnu_skip_one_line:

    \tb_tabular_add_to_cr:n { \hline }

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
    论文题目 & \multicolumn { 5 } { c| } { \g__scnu_title_cn_tl } \\
    研究生学号 & \g__scnu_sno_tl &
    所在院系 & \g__scnu_college_tl &
    学位年度 & \int_use:N \c_sys_year_int \\
    论文级别 & \multicolumn { 5 } { @{} l @{} | }
      {
        \tb_tabular_add_to_cr:n { }
        \begin { tabularx }
          { \dim_eval:n { \linewidth - 2\tabcolsep - 3\arrayrulewidth - 6\ccwd } }
          { X X r }
        \__scnu_degree_type_checkbox:nn { 硕士 } { 学术 } 硕士 &
        \__scnu_degree_type_checkbox:nn { 硕士 } { 专业 } 专业学位硕士 \\
        \__scnu_degree_type_checkbox:nn { 博士 } { 直博 } 直博(含提前攻博) &
        \__scnu_degree_type_checkbox:nn { 博士 } { 普通 } 普博(含论文博士) \\
        & & (请在方框上画勾)
        \end { tabularx }
      } \\
    作者电话 & \g__scnu_phone_tl &
    作者 Email & \multicolumn { 3 } { c| } { \g__scnu_email_tl } \\
    第一导师姓名 & \g__scnu_tutor_cn_tl &
    导师电话 & \multicolumn { 3 } { c| } { } \\
    第二导师姓名 & &
    导师电话 & \multicolumn { 3 } { c| } { } \\
    \end { tabularx }
  }

% #1: degree, #2: type, #3: text
\cs_new:Npn \__scnu_degree_type_checkbox:nn #1#2
  {
    \tl_set:Nn \l__scnu_degree_tl {#1}
    \tl_set:Nn \l__scnu_type_tl {#2}
    \bool_lazy_and:nnTF
      { \tl_if_eq_p:NN \g__scnu_degree_tl \l__scnu_degree_tl }
      { \tl_if_eq_p:NN \g__scnu_type_tl \l__scnu_type_tl }
      { \group_use:n { \large \CheckedBox } }
      { \Square }
  }



\NewDocumentCommand { \NewNoteCommand } { m m m }
  {
    \NewDocumentCommand {#1} {#2}
      { \__scnu_edition_if_debug:T {#3} }
  }

\NewDocumentCommand { \RenewNoteCommand } { m m m }
  {
    \str_set:Nn \l__scnu_old_command_name_str {#1}
    \tl_set:Nn \l__scnu_old_command_name_remove_backslash_tl
      { \str_range_ignore_spaces:Vnn \l__scnu_old_command_name_str {2} {-1} }
    \cs_set_eq:cN { __scnu_old_ \l__scnu_old_command_name_remove_backslash_tl :w } #1
    \cs_set_eq:cN { old \l__scnu_old_command_name_remove_backslash_tl } #1

    \__scnu_edition_if_debug:T
      { \RenewDocumentCommand {#1} {#2} {#3} }
  }

\endinput
%%
%% End of file `scnuthesis.cls'.
