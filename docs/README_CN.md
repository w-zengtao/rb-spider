#### 设计思路

爬虫(典型的生产者 - 消费者模型)在我的理念里由以下几部分组成:

* Fetcher 抓取器:
  * Fetcher 这里的实现是对 HttpClient 的封装
  * Fetcher 拿到 Response 之后会判定是否需要写入队列 - 然后被消费者消费
* Scheduler 调度器:
* Middleware 中间键:

衍生开来:

* 多线程抓取器 - Fetcher 跑在线程里面
* 分析器 - 解析抓取的内容

---
#### 怎样安装

```bash
gem install spider -s https://github.com/w-zengtao/rb-spider
```

---
#### 依赖于

```bash
Redis
RabbitMQ
```

---
#### 配置文件

```bash
config.yml
```

默认配置如下

```yaml
redis:
  url: 127.0.0.1
  port: 6379
  db: 0
rabbitmq:
  vhost: "/"
  username: guest
  password: guest
  host: 127.0.0.1
```

---
#### 如何使用

如我们在设计思路里面所讲，我们的程序的入口应该在 `Scheduler` 模块

---
#### 源码里面的一些技巧

1. Ruby的 [单例模式](https://github.com/w-zengtao/rb-spider/blob/master/lib/spider/config.rb)
2. Ruby的 [线程池 - 也就是CPU资源池](https://github.com/w-zengtao/rb-spider/blob/master/lib/spider/work_pool.rb)
