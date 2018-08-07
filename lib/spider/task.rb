# User Story
# This class has the ablility to extend fetcher behaviors & json & html & diffrent queue and so on

module Spider
  class Task

    attr_accessor :type, :queue_name, :url

    def initialize(type = 'json', queue_name = 'default', url)
      @type, @queue_name, @url = type, queue_name, url
    end

    def call
      Fetcher.new(@url).call
    end

  end
end
