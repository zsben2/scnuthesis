
# 华南师范大学研究生毕业论文 LaTeX3 模板 (v1.1)

鉴于 [https://github.com/scnu/scnuthesis](https://github.com/scnu/scnuthesis) 中的模板需要使用 CTeX 套装编译，但 CTeX 套装过于老旧，已不再适应当今排版需求，且原作者已停止维护该模板。因此决定另辟蹊径，从 0 开始重新做一个新模板。本模板使用 LaTeX3 语法，基本根据 [华南师范大学研究生院官网](http://yjsy.scnu.edu.cn/a/20090422/394.html) 上的《[华南师范大学研究生学位论文的基本要求和书写格式(修订）.doc](http://statics.scnu.edu.cn/pics/yjsy/2015/0829/1440826499788342.doc)》文件要求、学院钟老师开发的模板中的附件《[数学科学学院研究生学位论文指导手册(20200323).pdf](https://github.com/zsben2/scnu_graduate_files/files/11153859/20200323.pdf)》及本人毕业时学院联络人口头下达的要求编写（原始链接见[链接1](https://kdocs.cn/l/com24UNXUG1O)；若失效，[链接2](https://docs.qq.com/doc/DQUFLdUJ4eld3WXZn)是一份软拷贝，[链接3](https://github.com/zsben2/scnu_graduate_files/files/11153927/default.pdf)是一份硬拷贝），无给出明确要求的格式将仿照 [https://github.com/scnu/scnuthesis](https://github.com/scnu/scnuthesis) 中的设置及依据我个人审美编写。

另外文献管理也由传统的 BibTeX 改为 BibLaTeX 实现。

不定时维护中，欢迎提交 issue 提问。

考虑到《[华南师范大学研究生学位论文的基本要求和书写格式(修订）.doc](http://statics.scnu.edu.cn/pics/yjsy/2015/0829/1440826499788342.doc)》是 2009 年发布的通知，如果现在学校的格式要求已更新的话，请将最新的格式要求文件也提交至 issue，这样我可以进行修正。（2023 年毕业后将不再更新）

2023 年 5 月已结合外审意见修改模板。

**本模板仅支持单导师。** 双导师甚至多导师的同学需要自己改 cls 文件里的代码。

如果想预览编译后的 PDF， 可以从右侧的 Releases 里下载。

版本号：v1.1

推荐使用的 TeX 发行版：TeXLive 2021 或以上

编译命令：XeLaTeX -> biber -> XeLaTeX -> XeLaTeX