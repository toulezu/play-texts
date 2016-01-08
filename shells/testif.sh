#!/bin/sh
echo  文件测试

## 判断文件是否存在
if [ -f test1.txt ];then
  echo test1.txt 存在
  if [ ! -x test1.txt ];then
    chmod +x test1.txt
  fi
else
  echo 创建 test1.txt
  touch test1.txt
  echo 赋予 test1.test 可以写的权限
  chmod +w test1.txt
  echo helloi test >> test1.txt
  echo world sdfs nihao >> test1.txt
fi

#rm -rf test1.txt

## 查看 test1.txt 文件是否有指定的字符串
if [ ! -f test1.txt ];then
  echo test1.txt 不存在 
  exit 0
else
  grep world test1.txt > grep_result.log
fi
