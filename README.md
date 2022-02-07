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