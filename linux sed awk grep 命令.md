###本文主要讲述正则表达式，grep,awk,sed命令。
>3个命令都是针对行进行处理的。

>grep： 主要用来进行字符串在文件中的搜索。
       示例： `grep -l "hello"  test_file`

>awk ： 主要用来进行格式化的文件中的域分割及处理。
       示例：`awk -F : ' { print $1,$6} ' /etc/passwd`

>sed ： 主要用来对文件中的字符串修改，比如替换字符串。
       示例：在整行范围内把字符 22 替换为 kokotest，如果没有g标记，则只有每行
            第一个匹配的 22 被替换成 kokotest，-i选项指定对输入文件处理。
            `sed -i 's/22/kokotest/g' /root/soft/iptables`