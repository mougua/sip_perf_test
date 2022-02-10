# sip_perf_test

简单的呼叫中心测试脚本，利用 [sipp](https://github.com/SIPp/sipp) 作为测试的工具。


## 文件说明

- a_user.csv

  呼叫方注册的用户密码

- b_user.csv

  被叫注册的用户密码

- b_reg.xml

  被叫注册的流程

- uac.xml

  加了验证的呼叫流程

- uas.xml

  被叫监听呼叫的流程

- run_uac.sh

  呼叫的shell脚本

- run_uas.sh

  被叫监听的shell脚本


## 使用说明

脚本模拟了这么一个场景：几个座席注册并监听呼叫，另外几个用户并发呼叫这些座席，各个呼叫通话5秒后挂机。

使用时，先自行修改各个文件的配置和参数（流程上没播放语音等媒体，可以考虑自行加上）；然后在其中一个终端执行 `run_uas.sh` 开始监听；另外一个终端执行 `run_uac.sh` 即可模拟呼叫。

脚本在 FreeSWITCH version: 1.10.3 下测试通过。


## 踩过的坑

- 注册超时

  问题：freeswitch 不知道为啥不认 REGISTER 送过去的 Expires 参数，注册后在 freeswitch 上看，用户的Expires 时间都是在 6 分钟左右。导致压测一段时间后， uas 端不接收呼叫了，此时执行 fs_cli 的 sofia status profile internal reg 命令发现用户都掉了。

  解决：修改用户注册文件（conf/directory/default/xxx.xml）：参数列表里面添加一项 `<variable name="sip-force-expires" value="3600"/>`

- 替代方案

  [sipcmd2](https://github.com/guisousanunes/sipcmd2) 也是个不错的测试工具，优点是会模拟一个真的软电话，定时自动注册，不用担心注册超时问题。缺点是一个进程只能模拟一个软电话，压力测试的话要开多个终端。

  模拟接收呼叫的命令类似如下：
  ```bash
  ./sipcmd2 -P sip -u 1015 -c 1234 -w 172.16.23.243 -l 172.16.23.243 -p 9898 -x "lstart;a;lwai;w1000;j10lwai;d5;lafterwai;w1000;j10lafterwai;h;j0lstart"
  ```
  具体参数的意思参考官方github的README。