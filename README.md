# scnuthesis
华南师范大学研究生毕业论文 LaTeX3 模板

鉴于 [https://github.com/scnu/scnuthesis](https://github.com/scnu/scnuthesis) 中的模板需要使用 CTeX 套装编译，但 CTeX 套装过于老旧，已不再适应当今排版需求，且原作者已停止维护该模板。因此决定另辟蹊径，从 0 开始重新做一个新模板。本模板使用 LaTeX3 语法，基本根据 [华南师范大学研究生院官网](http://yjsy.scnu.edu.cn/a/20090422/394.html) 上的《[华南师范大学研究生学位论文的基本要求和书写格式(修订）.doc](http://statics.scnu.edu.cn/pics/yjsy/2015/0829/1440826499788342.doc)》文件要求编写，无给出明确要求的格式以我个人审美编写。

另外文献管理也由传统的 BibTeX 改为 BibLaTeX 实现。

持续维护中，欢迎提交 issue

版本号：v0.1

推荐使用的 TeX 发行版：TeXLive 2020
编译命令：XeLaTeX -> biber -> XeLaTeX -> XeLaTeX
