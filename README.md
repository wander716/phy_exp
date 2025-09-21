# 大物实验电子版

模板参考了cc98（【学习天地】大二物理实验报告LaTeX模版 <https://www.cc98.org/topic/6284556> 复制本链接到浏览器或者打开【CC98】微信小程序查看~）的模板，进行了一些修改和功能性宏包的添加

物理单位请使用siunit宏包，e.g.`$\si{\meter\per\second}`，`\si{\degreeCelsius}`，

三线表：
三线表使用方法

```tex
\begin{table}[H]
  \centering
  \caption{}
  \begin{tabular}{C{.3\textwidth}C{.3\textwidth}C{.3\textwidth}}
  \toprule
  读取值  & 测量值  & 计算误差 \\
  \midrule
  10000$\Omega$  & 10001$\Omega$  & 0.01\%  \\
  100$\Omega$    & 100.4$\Omega$  & 0.40\%  \\
  100k$\Omega$ & 100.25k$\Omega$ & 0.25\%  \\
  \bottomrule
  \end{tabular}
\end{table}
```
