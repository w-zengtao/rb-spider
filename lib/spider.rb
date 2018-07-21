require "spider/config"
require "spider/version"
require "spider/fetcher"
require "spider/requester"
require "spider/scheduler"

module Spider
  url = %w(
    https://dataservice-sec.vpgame.com/dota2/pro/webservice/schedule/list/all?lang=cn&interval=7&game_type=lol&status=wait
  )
  Scheduler.add(url)
end
