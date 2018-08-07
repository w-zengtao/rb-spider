Dir[File.dirname(__FILE__) + "/spider/*.rb"].map { |file| require file }

module Spider
  # url = %w(
  #   https://dataservice-sec.vpgame.com/dota2/pro/webservice/schedule/list/all?lang=cn&interval=7&game_type=lol&status=wait
  # )
  # Scheduler.add(url)

  # def run
  #
  # end
end
