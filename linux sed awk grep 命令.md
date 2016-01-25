#grep,sed,awk 命令介绍

这3个命令都是针对文本进行处理的，都支持正则表达式，但是侧重点有所不同。

##grep 主要用来进行字符串在文件中的搜索

###简介

grep (global search regular expression(RE) and print out the line,全面搜索正则表达式并把行打印出来)是一种强大的文本搜索工具，它能使用正则表达式搜索文本，并把匹配的行打印出来。

Unix的grep家族包括grep、egrep和fgrep。egrep和fgrep的命令只跟grep有很小不同。egrep是grep的扩展，支持更多的RE元字符， fgrep就是fixed grep或fast grep，它们把所有的字母都看作单词，也就是说，正则表达式中的元字符表示回其自身的字面意义，不再特殊。linux使用GNU版本的grep。它功能更强，可以通过-G、-E、-F命令行选项来使用egrep和fgrep的功能。

正则表达式：又称正规表示法、常规表示法（英语：Regular Expression，在代码中常简写为regex、regexp或RE）正则表达式使用单个字符串来描述、匹配一系列符合某个句法规则的字符串。在很多文本编辑器里，正则表达式通常被用来检索、替换那些符合某个模式的文本。

###grep 用法

#### grep 常用选项
参数|说明
---|---
-v|显示不包含匹配文本的所有行。
-o|仅显示匹配的字串，而非字串所在的行/不常用
-i|忽略字符大小写
-n|输出匹配行的行号
-q|安静模式，不打印任何标准输出/不常用
-E|扩展正则表达式，相当于egrep,egrep 扩展正则表达式
-F|固定字符串列表，相当于fgrep，fgrep 不支持正则表达式
-A|显示被模式匹配到的行及后n行
-B|显示被模式匹配到的行及前n行
-C|显示被模式匹配到的行及其前后各n行
`–color=auto` |可以将找到的关键词部分加上颜色的显示

####正则表达式

#####字符匹配
参数|说明
---|---
`.` | 匹配任意单个字符，相当于通配符?
`[]` |匹配指定范围内的任意单个字符
`[^]` | 匹配指定范围外的任意单个字符

#####常用特殊字符匹配
参数|说明
---|---
`[0-9] = [[:digit:]]` |匹配数字
`[a-z] = [[:lower:]]`  |匹配小写字母
`[0-9a-zA-Z] = [[:alnum:]]`| 匹配大小写字母或数字
`[a-zA-Z] = [[:alpha:]]` | 匹配字母，大小写字母
`[[:space:]] = \s` | 匹配空白字符
`[A-Z] = [[:upper:]]`  |  代表大小字写母

#####次数匹配
参数|说明
---|---
`*`|匹配*前面的单个字符任意次，可以为0次；
`.*`|匹配任意长度的任意字符；
`\?`|匹配?前面的字符0或者1次；如果是使用egrep 直接？
`\+`|匹配+前面的字符至少1次；如果是使用egrep 直接+
`\{m,n\}`|匹配其左侧的字符至少m次，至多n次；如果是使用egrep 直接{m,n}
`\{m,\}`|匹配其左侧的字符至少m次 如果是使用egrep 直接{m,}
`\{0,n\}`|匹配其左侧的字符至多n次   如果是使用egrep 直接{0,n}
`\{m\}`|精确匹配其左侧的字符m次 如果是使用egrep 直接{m}

#####位置锚定

|参数|说明|
|---|---|
|`^` |锚定行首|
|`$` | 锚定行尾|
|`^$` |匹配空白行,`^[[:space:]]$` 一样的效果|

#####单词锚定
|参数|说明|
|---|---|
|`\<` |锚定词首|
|`\>`|锚定词尾|
|`\<PATTERN\>`|匹配PATTERN能匹配到的整个单词|
|`\b`|匹配一个字边界，即字与空格间的位置|
|`\|` | 或的意思 `a\|b` 就是匹配a或者是b|
|`f` | 分组及引用：|
|`\(\) `|将`()`中字符集合到一起作为一个字符引用，如果是使用egrep 直接`()`|
|`\#` | 引用，模式中自左而右,而非模式本身|

#####正则表达式的贪婪与非贪婪模式

>贪婪匹配:正则表达式一般趋向于最大长度匹配，也就是所谓的贪婪匹配。

>非贪婪匹配：就是匹配到结果就好，就少的匹配字符。

>默认是贪婪模式；在量词后面直接加上一个问号？就是非贪婪模式，表示匹配0次或者1次

###例子

- 将/etc/passwd，有出现 root 的行取出来,同时显示这些行在/etc/passwd的行号

	`grep -n root /etc/passwd`

- 用 dmesg 列出核心信息，再以 grep 找出内含 eth 那行,要将捉到的关键字显色，且加上行号来表示：

	`dmesg | grep -n eth`

- 将/etc/passwd，将没有出现 root 的行取出来

	`grep -v root /etc/passwd`

- 用 dmesg 列出核心信息，再以 grep 找出内含 eth0 那行,在关键字所在行的前两行与后三行也一起捉出来显示

	`dmesg | grep -n -A3 -B2 'ethic'`

- 搜索cc.txt下aa 关键字忽略字母大小写，命令如下：

	`grep -i 'aa' cc.txt`

- 在/etc/passwd 查找以root开头的行

	`grep "^root" /etc/passwd`

- 在/etc/passwd  查找以nologin结尾的行

	`grep "nologin$" /etc/passwd`

- 在文件中匹配以the作为单词首部的行

	`grep "\<the" siaz.txt`

- 在siaz.txt 文件中匹配以the作为单词词尾的行

	`grep "the\>" siaz.txt`

- 在siaz.txt 文件中匹配包含单词`"the"`的行

	`grep "\bthe\b" siaz.txt`

- 在/etc/passwd中 匹配单个字符`r..t`

	`grep "r..t" /etc/passwd`

- 在/etc/passwd中匹配0个或多个位于星号前的字符

	`grep 'ro*t' /etc/passwd`

- 在/etc/passwd中匹配一组字符中的任意一个

	`grep "[tb]est" /etc/passwd`

- 匹配/etc/passwd中不包含root的行

	`grep "^[^root]" /etc/passwd` 
>  `[^root]` 取非root字符，`^` 开头非root的行

- 匹配/etc/passwd中字母o连续出现2次的行

	`grep "o\{2\}"  /etc/passwd`
	 
	`grep -E "o{2}"  /etc/passwd`

- 匹配文件中 最少出现m次，最多出现n次

	`grep "ro\{2,4\}"  bb.txt `

	`grep -E "ro{2,4}"  bb.txt `

- 匹配文件中以2016开头且以2016结尾的行，`\1` 代表要匹配的子串在

	`grep "^\(2016\).*\1$" cc.txt`

	`grep -E "^(2016).*\1$" cc.txt`

- 在文件中分组引用w(es)t 中的es

	`grep "w\(es\)t.*\1" cc.txt`

	`grep -E "w(es)t.*\1" cc.txt`

- 匹配cc.txt文件中的数字与大小写字母

	`grep "[[:alnum:]]" cc.txt`

	`grep "[0-9a-Z]" cc.txt `

- 匹配cc.txt文件的空白键

	`grep "[[:space:]]" cc.txt `

- 从/etc/passwd中匹配包含ro字符串，且字母至少出现一次以上的行

	`grep -E "ro+" /etc/passwd`

- 在bb.txt 文件中，匹配其roo前导字符0次或1次

	`grep -E "roo?" bb.txt `

- 从/etc/passwd中匹配test1或best1

	`grep "[t|b]est1" /etc/passwd`

- 在/etc/passwd上查找用户id和组id在500到1099之间的行

	`grep "\<1\?[05][0-9][0-9]\>" /etc/passwd`

	`grep -E "\<1?[05][0-9][0-9]\>" /etc/passwd`

-  找出ifconfig命令结果中的1-255之间的数字

	`ifconfig | grep -o -E "\<([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\>"`

- 显示/etc/passwd文件中其默认shell为/bin/bash的用户

	`grep "/bin/bash$" /etc/passwd | sort -t: -k3 -n | tail -1 | cut -d: -f1`
> `sort -t: -k3 -n` 表示按`:` 分割字符串后，按第三位数字类型字符串排序
> `cut -d: -f1` 表示按 `:` 分割字符串后，取第一位字符串

##sed ： 主要用来对文件中的字符串修改，比如替换字符串

sed (stream editor) 是一种流编辑器，它是文本处理中非常有用的工具，能够完美的配合正则表达式使用。处理时，把当前处理的行存储在临时缓冲区中，称为『模式空间』（pattern space），接着用sed命令处理缓冲区中的内容，处理完成后，把缓冲区的内容送往屏幕。接着处理下一行，这样不断重复，直到文件末尾。文件内容并没有改变，除非你使用重定向存储输出。sed主要用来自动编辑一个或多个文件，简化对文件的反复操作，编写转换程序等。

>示例：在整行范围内把字符 22 替换为 kokotest，如果没有g标记，则只有每行
            第一个匹配的 22 被替换成 kokotest，-i选项指定对输入文件处理。
            `sed -i 's/22/kokotest/g' /root/soft/iptables`

###命令格式

`sed [options] 'command' file(s)`
`sed [options] -f scriptfile file(s)`

###选项

选项|完整选项|说明
---|---|---|--
-e|script|--expression=script|以选项中的指定的script来处理输入的文本文件
-f|script|--files=script|以选项中的指定的script文件来处理输入的文本文件
-h|--help|显示帮助
-n|--quiet|--silent|仅显示script处理后的结果
-i|--in-place|就地替换，加这个选项前注意备份文件
-V|--version|显示版本信息

####命令
命令|说明
---|---
d|从模板块（Pattern space）位置删除行
s|替换指定字符
h|拷贝模板块的内容到内存中的缓冲区
H|追加模板块的内容到内存中的缓冲区
g|获得内存缓冲区的内容，并替代当前模板块中文本
G|获得内存缓冲区的内容，并追加到当前模板块文本的后面
l|列表不能打印字符的清单
n|读取下一个输入行，用下一个命令处理新的行而不是第一个命令
N|追加下一个输入行到模板块后面并在二者间嵌入一个新行，改变当前行号码
p|打印模板块的行(和 `-n` 选项一起使用)
q|退出sed
b label|分支到脚本中带有标记的地方，如果分支不存在则分支到脚本的末尾
r file|从file中读行
t label|if分支，从最后一行开始，条件一旦满足或者T，t命令，将导致分支到带有标号的命令处，或者到脚本的末尾
T label|错误分支，从最后一行开始，一旦发生错误或者T，t命令，将导致分支到带有标号的命令处，或者到脚本的末尾
w file|写并追加模板块到file末尾
W file|写并追加模板块的第一行到file末尾
!|表示后面的命令对所有没有被选定的行发生作用
=|打印当前行号
`#`|把注释扩展到第一个换行符以前

####sed替换标记
命令|说明
---|---
g|表示行内全面替换
p|表示打印行
w|表示把行写入一个文件
x|表示互换模板块中的文本和缓冲区中的文本
y|表示把一个字符翻译为另外的字符（但是不用于正则表达式）
`\1`|子串匹配标记
`&`|已匹配字符串标记

####sed元字符集
命令|说明
---|---
`^`|匹配行开始，如：/^sed/匹配所有以sed开头的行。
`$`|匹配行结束，如：/sed$/匹配所有以sed结尾的行。
`.`|匹配一个非换行符的任意字符，如：/s.d/匹配s后接一个任意字符，最后是d。
`*`|匹配0个或多个字符，如：/*sed/匹配所有模板是一个或多个空格后紧跟sed的行。
`[]`|匹配一个指定范围内的字符，如/[sS]ed/匹配sed和Sed。
`[^]`|匹配一个不在指定范围内的字符，如：/[^A-RT-Z]ed/匹配不包含A-R和T-Z的一个字母开头，紧跟ed的行。
 `\(..\)`|匹配子串，保存匹配的字符，如s/\(love\)able/\1rs，loveable被替换成lovers。
 `&`|保存搜索字符用来替换其他字符，如s/love/&/，love这成love。 
 `\<`|匹配单词的开始，如:/\<love/匹配包含以love开头的单词的行。
 `\>`|匹配单词的结束，如/love>/匹配包含以love结尾的单词的行。
 `x{m}`|重复字符x，m次，如：/0{5}/匹配包含5个0的行。
 `x{m,}`|重复字符x，至少m次，如：/0{5,}/匹配至少有5个0的行。 
 `x{m,n}`|重复字符x，至少m次，不多于n次，如：/0{5,10}/匹配5~10个0的行。
 
####sed用法实例

我们先准备一个测试文件

```
MacBook-Pro:tmp maxincai$ cat test.txt
my cat's name is betty
This is your dog
my dog's name is frank
This is your fish
my fish's name is george
This is your goat
my goat's name is adam
```

####替换操作：`s`命令

替换文本中的字符串：
```
MacBook-Pro:tmp maxincai$ sed 's/This/aaa/' test.txt
my cat's name is betty
aaa is your dog
my dog's name is frank
aaa is your fish
my fish's name is george
aaa is your goat
my goat's name is adam
```

####`-n`选项和`p`命令一起使用表示只打印那些发生替换的行：

`MacBook-Pro:tmp maxincai$ sed -n 's/This/aaa/p' test.txt
aaa is your dog
aaa is your fish
aaa is your goat`

直接编辑文件选项`-i`(inplace)，会将test.txt文件中每一行的第一个This替换为this:
`[root@vagrant-centos65 workspace]# sed -i 's/This/this/' test.txt
[root@vagrant-centos65 workspace]# cat test.txt
my cat's name is betty
this is your dog
my dog's name is frank
this is your fish
my fish's name is george
this is your goat
my goat's name is adam`

####全面替换标记g

使用后缀/g标记会替换每一行中的所有匹配：
`[root@vagrant-centos65 workspace]# sed 's/this/This/g' test.txt
my cat's name is betty
This is your This dog
my dog's name is This frank
This is your fish
my fish's name is This george
This is your goat
my goat's name is This adam`

当需要从第N处匹配开始替换时，可以使用/Ng:
`[root@vagrant-centos65 workspace]# echo sksksksksksk | sed 's/sk/SK/2g'
skSKSKSKSKSK
[root@vagrant-centos65 workspace]# echo sksksksksksk | sed 's/sk/SK/3g'
skskSKSKSKSK
[root@vagrant-centos65 workspace]# echo sksksksksksk | sed 's/sk/SK/4g'
skskskSKSKSK`

####定界符

以上命令中字符` / `在sed中作为定界符使用，也可以使用任意的定界符`:` 或者`|`
`[root@vagrant-centos65 workspace]# echo sksksksksksk | sed 's:sk:SK:4g'
skskskSKSKSK
[root@vagrant-centos65 workspace]# echo sksksksksksk | sed 's|sk|SK|4g'
skskskSKSKSK`

定界符出现在样式内部时，需要进行转义：
`[root@vagrant-centos65 workspace]# echo '/usr/local/bin' | sed 's/\/usr\/local\/bin/\/USR\/LOCAL\/BIN/g'
/USR/LOCAL/BIN`

####删除操作：`d`命令

删除空白行:
`[root@vagrant-centos65 workspace]# cat test.txt
my cat's name is betty`

`this is your this dog`

`my dog's name is this frank`

`this is your fish`
`my fish's name is this george`
`this is your goat`
`my goat's name is this adam`

`[root@vagrant-centos65 workspace]# sed '/^$/d' test.txt
my cat's name is betty
this is your this dog
my dog's name is this frank
this is your fish
my fish's name is this george
this is your goat
my goat's name is this adam`

删除文件的第2行：
`[root@vagrant-centos65 workspace]# sed '2d' test.txt
my cat's name is betty
my dog's name is this frank
this is your fish
my fish's name is this george
this is your goat
my goat's name is this adam`

删除文件的第2行到末尾所有行：
`[root@vagrant-centos65 workspace]# sed '2,$d' test.txt
my cat's name is betty`

删除文件最后一行：
`[root@vagrant-centos65 workspace]# sed '$d' test.txt
my cat's name is betty
this is your this dog
my dog's name is this frank
this is your fish
my fish's name is this george
this is your goat`

删除文件中所有以my开头的行：
`[root@vagrant-centos65 workspace]# `sed '/^my/'d test.txt`
this is your this dog
this is your fish
this is your goat`

####已匹配字符串标记&

正则表达式`\w\+`匹配每一个单词，使用`[&]`替换它，`&`对应之前所匹配到的单词：
`[root@vagrant-centos65 workspace]# echo this is a test line | sed 's/\w\+/[&]/g'
[this] [is] [a] [test] [line]`

####子串匹配标记`\1`

匹配给定样式的其中一部份：
`[root@vagrant-centos65 workspace]# echo this is digit 7 in a number | sed 's/digit \([0-9]\)/\1/'
this is 7 in a number`

命令中digit 7，被替换成7.样式匹配到的子串是7，\(..\)用于匹配子串，对于匹配到的第一个子串标记为\1，依此类推匹配到的第二个结果就是\2,例如：
`[root@vagrant-centos65 workspace]# echo aaa BBB | sed 's/\([a-z]\+\) \([A-Z]\+\)/\2 \1/'
BBB aaa`

####组合多个表达式

`sed '表达式' | sed '表达式'`

等价于

`sed '表达式; 表达式'`

####引用

sed表达式可以使用单引号来引用，但是如果表达式内部包含变量字符串，就需要使用双引号。
`[root@vagrant-centos65 workspace]# test=hello
[root@vagrant-centos65 workspace]# echo hello WORLD | sed "s/$test/HELLO/"
HELLO WORLD`

####选定行的范围`,`(逗号)

打印从第5行开始到第一个包含以this开始的行之间的所有行：
`[root@vagrant-centos65 workspace]# sed -n '5,/^this/p' test.txt
my fish's name is this george
this is your goat`

####多点编辑`e`命令

`-e`选项允许在同一行里执行多条命令
`[root@vagrant-centos65 workspace]# sed -e '1,5d' -e 's/my/MY/' test.txt
this is your goat
MY goat's name is this adam`

>上面sed表达式的第一条命令删除1至5行，第二条命令用check替换test。命令的执行顺序对结果有影响。如果两个命令都是替换命令，那么第一个命令将影响第二个命令的结果。

####和 -e 等价的命令是 --expression

####从文件读入`r`命令

>file里的内容被读进来，显示在与test匹配的行后面，如果匹配多行，则file的内容将显示在所有匹配行的下面：

`[root@vagrant-centos65 workspace]# cat test1.txt
aaaaaaaa
[root@vagrant-centos65 workspace]# sed '/my/r test1.txt' test.txt
my cat's name is betty
aaaaaaaa
this is your this dog
my dog's name is this frank
aaaaaaaa
this is your fish
my fish's name is this george
aaaaaaaa
this is your goat
my goat's name is this adam
aaaaaaaa`

####写入文件`w`命令

>在test.txt中所有包含my的行都被写入test2.txt里：
[root@vagrant-centos65 workspace]# `sed -n '/my/w test2.txt' test.txt`
[root@vagrant-centos65 workspace]# cat test2.txt
my cat's name is betty
my dog's name is this frank
my fish's name is this george
my goat's name is this adam

####追加（行下）`a\`命令

>将this is a test line 追加到以my开头的行后面：
[root@vagrant-centos65 workspace]# `sed '/^my/a\this is a test line' test.txt`
my cat's name is betty
this is a test line
this is your this dog
my dog's name is this frank
this is a test line
this is your fish
my fish's name is this george
this is a test line
this is your goat
my goat's name is this adam
this is a test line

>在text.txt文件第2行之后插入this is a test line:
[root@vagrant-centos65 workspace]# `sed '2a\this is a test line' test.txt`
my cat's name is betty
this is your this dog
this is a test line
my dog's name is this frank
this is your fish
my fish's name is this george
this is your goat
my goat's name is this adam

####插入（行上）`i\`命令

>将this is a test line 插入到以my开头的行前面：
[root@vagrant-centos65 workspace]# `sed '/^my/i\this is a test line' test.txt`
this is a test line
my cat's name is betty
this is your this dog
this is a test line
my dog's name is this frank
this is your fish
this is a test line
my fish's name is this george
this is your goat
this is a test line
my goat's name is this adam

####下一个`n`命令
>如果my被匹配，则移动到匹配行的下一行，替换这一行的this为This,并打印该行：
[root@vagrant-centos65 workspace]# `sed '/my/{n; s/this/This/; }' test.txt`
my cat's name is betty
This is your this dog
my dog's name is this frank
This is your fish
my fish's name is this george
This is your goat
my goat's name is this adam

####变形`y`命令

>把1-10行内所有的abcde转变为大写，注意，正则表达式元字符不能使用这个命令：
[root@vagrant-centos65 workspace]#`sed '1,10y/abcde/ABCDE/' test.txt`
my CAt's nAmE is BEtty
this is your this Dog
my Dog's nAmE is this frAnk
this is your fish
my fish's nAmE is this gEorgE
this is your goAt
my goAt's nAmE is this ADAm

####退出`q`命令

>打印完第3行，退出sed
[root@vagrant-centos65 workspace]# `sed '3q' test.txt`
my cat's name is betty
this is your this dog
my dog's name is this frank

####打印奇数行或偶数行

方法1：

>奇数行
[root@vagrant-centos65 workspace]# `sed -n 'p;n' test.txt`
my cat's name is betty
my dog's name is this frank
my fish's name is this george
my goat's name is this adam

>偶数行
[root@vagrant-centos65 workspace]# `sed -n 'n;p' test.txt`
this is your this dog
this is your fish
this is your goat

方法2：

`sed -n '1~2p' test.txt`
`sed -n '2~2p' test.txt`

更多的需要在以后的工作中慢慢摸索，这里只是一个简单的记录，以后如果有更多经验了再完善一篇sed实战吧。


##awk ： 主要用来进行格式化的文件中的域分割及处理。

简介

awk是一个强大的文本分析工具，相对于grep的查找，sed的编辑，awk在其对数据分析并生成报告时，显得尤为强大。简单来说awk就是把文件逐行的读入，以空格为默认分隔符将每行切片，切开的部分再进行各种分析处理。

awk有3个不同版本: awk、nawk和gawk，未作特别说明，一般指gawk，gawk 是 AWK 的 GNU 版本。

awk其名称得自于它的创始人 Alfred Aho 、Peter Weinberger 和 Brian Kernighan 姓氏的首个字母。实际上 AWK 的确拥有自己的语言： AWK 程序设计语言 ， 三位创建者已将它正式定义为“样式扫描和处理语言”。它允许您创建简短的程序，这些程序读取输入文件、为数据排序、处理数据、对输入执行计算以及生成报表，还有无数其他的功能。

使用方法

`awk '{pattern + action}' {filenames}`

尽管操作可能会很复杂，但语法总是这样，其中 pattern 表示 AWK 在数据中查找的内容，而 action 是在找到匹配内容时所执行的一系列命令。花括号（{}）不需要在程序中始终出现，但它们用于根据特定的模式对一系列指令进行分组。 pattern就是要表示的正则表达式，用斜杠括起来。

awk语言的最基本功能是在文件或者字符串中基于指定规则浏览和抽取信息，awk抽取信息后，才能进行其他文本操作。完整的awk脚本通常用来格式化文本文件中的信息。

通常，awk是以文件的一行为处理单位的。awk每接收文件的一行，然后执行相应的命令，来处理文本。

调用awk

有三种方式调用awk

1.命令行方式awk [-F field-separator] 'commands' input-file(s)其中，commands 是真正awk命令，[-F域分隔符]是可选的。 input-file(s) 是待处理的文件。在awk中，文件的每一行中，由域分隔符分开的每一项称为一个域。通常，在不指名-F域分隔符的情况下，默认的域分隔符是空格。2.shell脚本方式将所有的awk命令插入一个文件，并使awk程序可执行，然后awk命令解释器作为脚本的首行，一遍通过键入脚本名称来调用。相当于shell脚本首行的：#!/bin/sh可以换成：#!/bin/awk3.将所有的awk命令插入一个单独文件，然后调用：awk -f awk-script-file input-file(s)其中，-f选项加载awk-script-file中的awk脚本，input-file(s)跟上面的是一样的。

本章重点介绍命令行方式。

入门实例

假设last -n 5的输出如下

`[root@www ~]# last -n 5 <==仅取出前五行root pts/1 192.168.1.100 Tue Feb 10 11:21 still logged inroot pts/1 192.168.1.100 Tue Feb 10 00:46 - 02:28 (01:41)root pts/1 192.168.1.100 Mon Feb 9 11:41 - 18:30 (06:48)dmtsai pts/1 192.168.1.100 Mon Feb 9 11:41 - 11:41 (00:00)root tty1 Fri Sep 5 14:09 - 14:10 (00:01)`

如果只是显示最近登录的5个帐号

`last -n 5 | awk '{print $1}'`

root

root

root

dmtsai

root

awk工作流程是这样的：读入有`'\n'`换行符分割的一条记录，然后将记录按指定的域分隔符划分域，填充域，`$0`则表示所有域,`$1`表示第一个域,`$n`表示第n个域。默认域分隔符是`"空白键" `或` "[tab]键",`所以`$1`表示登录用户，`$3`表示登录用户ip,以此类推。

如果只是显示/etc/passwd的账户

`cat /etc/passwd | awk -F ':' '{print $1}' rootdaemonbinsys`

这种是awk+action的示例，每行都会执行action{print $1}。

-F指定域分隔符为':'。

如果只是显示/etc/passwd的账户和账户对应的shell,而账户与shell之间以tab键分割

`cat /etc/passwd |awk -F ':' '{print $1"\t"$7}'root /bin/bashdaemon /bin/shbin /bin/shsys /bin/sh`

如果只是显示/etc/passwd的账户和账户对应的shell,而账户与shell之间以逗号分割,而且在所有行添加列名name,shell,在最后一行添加"blue,/bin/nosh"。

`cat /etc/passwd |awk -F ':' 'BEGIN {print "name,shell"} {print $1","$7} END {print "blue,/bin/nosh"}'name,shellroot,/bin/bashdaemon,/bin/shbin,/bin/shsys,/bin/sh....blue,/bin/nosh`

awk工作流程是这样的：先执行BEGING，然后读取文件，读入有/n换行符分割的一条记录，然后将记录按指定的域分隔符划分域，填充域，`$0`则表示所有域,`$1`表示第一个域,`$n`表示第n个域,随后开始执行模式所对应的动作action。接着开始读入第二条记录······直到所有的记录都读完，最后执行END操作。

搜索/etc/passwd有root关键字的所有行

`awk -F: '/root/' /etc/passwd`
root:x:0:0:root:/root:/bin/bash

这种是pattern的使用示例，匹配了pattern(这里是root)的行才会执行action(没有指定action，默认输出每行的内容)。

搜索支持正则，例如找root开头的: awk -F: '/^root/' /etc/passwd

搜索/etc/passwd有root关键字的所有行，并显示对应的shell

` awk -F: '/root/{print $7}' /etc/passwd /bin/bash`

这里指定了action{print $7}

awk内置变量

awk有许多内置变量用来设置环境信息，这些变量可以被改变，下面给出了最常用的一些变量。

ARGC 命令行参数个数ARGV 命令行参数排列ENVIRON 支持队列中系统环境变量的使用FILENAME awk浏览的文件名FNR 浏览文件的记录数（已读当前文件的记录数）FS 设置输入域分隔符，等价于命令行 -F选项NF 浏览记录的域的个数NR 已读的总记录数OFS 输出域分隔符ORS 输出记录分隔符RS 控制记录分隔符

此外,`$0`变量是指整条记录。`$1`表示当前行的第一个域,`$2`表示当前行的第二个域,......以此类推。

统计/etc/passwd:文件名，每行的行号，每行的列数，对应的完整行内容:

`awk -F ':' '{print "filename:" FILENAME ",linenumber:" NR ",columns:" NF ",linecontent:"$0}' /etc/passwdfilename:/etc/passwd,linenumber:1,columns:7,linecontent:root:x:0:0:root:/root:/bin/bashfilename:/etc/passwd,linenumber:2,columns:7,linecontent:daemon:x:1:1:daemon:/usr/sbin:/bin/shfilename:/etc/passwd,linenumber:3,columns:7,linecontent:bin:x:2:2:bin:/bin:/bin/shfilename:/etc/passwd,linenumber:4,columns:7,linecontent:sys:x:3:3:sys:/dev:/bin/sh`

使用printf替代print,可以让代码更加简洁，易读

`awk -F ':' '{printf("filename:%10s,linenumber:%s,columns:%s,linecontent:%s\n",FILENAME,NR,NF,$0)}' /etc/passwd`

print和printf

awk中同时提供了print和printf两种打印输出的函数。

其中print函数的参数可以是变量、数值或者字符串。字符串必须用双引号引用，参数用逗号分隔。如果没有逗号，参数就串联在一起而无法区分。这里，逗号的作用与输出文件的分隔符的作用是一样的，只是后者是空格而已。

printf函数，其用法和c语言中printf基本相似,可以格式化字符串,输出复杂时，printf更加好用，代码更易懂。

awk编程

变量和赋值

除了awk的内置变量，awk还可以自定义变量。

下面统计/etc/passwd的账户人数

`awk '{count++;print $0;} END{print "user count is ", count}' `
`/etc/passwdroot:x:0:0:root:/root:/bin/bash......user count is  40`

count是自定义变量。之前的action{}里都是只有一个print,其实print只是一个语句，而action{}可以有多个语句，以;号隔开。

这里没有初始化count，虽然默认是0，但是妥当的做法还是初始化为0:

`awk 'BEGIN {count=0;print "[start]user count is ", count} {count=count+1;print $0;} END{print "[end]user count is ", count}' /etc/passwd[start]user count is 0root:x:0:0:root:/root:/bin/bash...[end]user count is 40`

统计某个文件夹下的文件占用的字节数

`ls -l |awk 'BEGIN {size=0;} {size=size+$5;} END{print "[end]size is ", size}'[end]size is  8657198`

如果以M为单位显示:

`ls -l |awk 'BEGIN {size=0;} {size=size+$5;} END{print "[end]size is ", size/1024/1024,"M"}'[end]size is  8.25889 M`

注意，统计不包括文件夹的子目录。

条件语句

awk中的条件语句是从C语言中借鉴来的，见如下声明方式：

`if (expression) {

statement; statement; ... ...}if (expression) { statement;} else { statement2;}if (expression) { statement1;} else if (expression1) { statement2;} else { statement3;}`

统计某个文件夹下的文件占用的字节数,过滤4096大小的文件(一般都是文件夹):

`ls -l |awk 'BEGIN {size=0;print "[start]size is ", size} {if($5!=4096){size=size+$5;}} END{print "[end]size is ", size/1024/1024,"M"}'[end]size is  8.22339 M`

循环语句

awk中的循环语句同样借鉴于C语言，支持while、do/while、for、break、continue，这些关键字的语义和C语言中的语义完全相同。

数组

因为awk中数组的下标可以是数字和字母，数组的下标通常被称为关键字(key)。值和关键字都存储在内部的一张针对key/value应用hash的表格里。由于hash不是顺序存储，因此在显示数组内容时会发现，它们并不是按照你预料的顺序显示出来的。数组和变量一样，都是在使用时自动创建的，awk也同样会自动判断其存储的是数字还是字符串。一般而言，awk中的数组用来从记录中收集信息，可以用于计算总和、统计单词以及跟踪模板被匹配的次数等等。

显示/etc/passwd的账户

`awk -F ':' 'BEGIN {count=0;} {name[count] = $1;count++;}; END{for (i = 0; i < NR; i++) print i, name[i]}' /etc/passwd0 root1 daemon2 bin3 sys4 sync5 games......`

这里使用for循环遍历数组

awk转义序列与算术操作符 http://www.linuxidc.com/Linux/2015-06/118886.htm

AWK简介及使用实例 http://www.linuxidc.com/Linux/2013-12/93519.htm

AWK 简介和例子 http://www.linuxidc.com/Linux/2012-12/75441.htm

Shell脚本之AWK文本编辑器语法 http://www.linuxidc.com/Linux/2013-11/92787.htm

正则表达式中AWK的学习和使用 http://www.linuxidc.com/Linux/2013-10/91892.htm

文本数据处理之AWK 图解 http://www.linuxidc.com/Linux/2013-09/89589.htm

如何在Linux中使用awk命令 http://www.linuxidc.com/Linux/2014-10/107542.htm

文本分析工具-awk http://www.linuxidc.com/Linux/2014-12/110939.htm 
       示例：`awk -F : ' { print $1,$6} ' /etc/passwd`