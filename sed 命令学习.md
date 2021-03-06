#sed 命令

>sed是一种流编辑器，它是文本处理中非常中的工具，能够完美的配合正则表达式使用，功能不同凡响。处理时，把当前处理的行存储在临时缓冲区中，称为“模式空间”（pattern space），接着用sed命令处理缓冲区中的内容，处理完成后，把缓冲区的内容送往屏幕。接着处理下一行，这样不断重复，直到文件末尾。文件内容并没有 改变，除非你使用重定向存储输出。Sed主要用来自动编辑一个或多个文件；简化对文件的反复操作；编写转换程序等。

##命令格式
`sed [options] 'script' file(s)`
`sed [options] -f scriptfile file(s)`

>`-f` 表示写在其他文件中的模式表达式，`-e` 表示写在行内的模式表达式，可以不带这个参数

>行内模式表达式必须要带上 `'` 单引号或者 `"` 双引号，行内模式表达式中的字符串用`/` 包围起来

>下面这个语句将file1中所有的ck变成CK
`sed "s/ck/CK/g" file1` 
>*如果没有带上 `-i` （inplace）参数不会替换文件内容*

###批量替换字符串

`sed -i "s/zhangsan/lisi/g"` ```grep zhangsan -rl /modules```

解释一下：
>-i 表示inplace edit，就地修改文件
-r 表示搜索子目录
-l 表示输出匹配的文件名

```grep zhangsan -rl /modules``` 这个命令会列出 modules 目录及其子目录下含有**zhangsan**字符串的所有文件，`sed -i "s/zhangsan/lisi/g"` 会将所有文件中的**zhangsan**字符串替换为**lisi**字符串，**使用这个命令前注意要备份文件，先不要加`-i`选项，确认没有问题后再加上**

###在文件中查找要匹配的记录

