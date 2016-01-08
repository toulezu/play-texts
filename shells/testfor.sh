#!/bin/sh
title=for循环学习
echo $title

### 使用unset 取消定义变量
unset title
echo $title

## 变量的等号附近不能有空格，使用 $ 引用变量
nums="23 34 567 88"
for n in $nums;do
  echo $n
done
echo ---------------------------------------

##  直接把变量放在循环中，使用 ${} 引用变量
for str in in in i am new person
do
  echo "the word is ${str} \n"
done

echo ---------------------------------------

## 循环读取文件内容, 用于查找某些文件中是否包含指定的内容
while read line;do
  echo "every file content line is ${line} \n"
done < testfilecontent.txt

echo --------------------------------------

## 使用 select case 进行选择处理，类似菜单的功能
select ch in  "1" "2" "3" "4"
do
case $ch in
  "1")
  echo "the choose is 1"
  ;;
  "2")
  echo "the choose is 2"
  ;;
  "3")
  echo "the choose is 3"
  ;;
  "4")
  echo "exit"
  break;
  ;;
  *)
   echo "ignorant"
  ;;
esac ## esac 
done
