require 'rss/2.0'
require 'timeout'
class Tweet < ActiveRecord::Base
  cattr_accessor :cache_expire

  def self.find_and_store(num)
    if self.cache_expire.nil? or self.cache_expire < (Time.now - (60 * TWITTER_CONFIG[:expire]))
      repopulate
      self.cache_expire = Time.now
    end
    # else

    tweets = find(:all, :order => "twitter_update_time DESC", :limit => num)
    # end
  end

  def self.pull_feed(userid)
    @feed = RSS::Rss.new("2.0")
    begin
      timeout(TWITTER_CONFIG[:timeout]) do
        open("http://#{TWITTER_CONFIG[:domain]}/#{TWITTER_CONFIG[:path]}/#{TWITTER_CONFIG[:user_id]}.rss") do |http|
          @feed = RSS::Parser.parse(http.read,false)
        end
      end
      if not @feed.items.empty?
        @username = @feed.channel.title.split(" / ")[1]
        return true
      else
        return false
      end
    rescue TimeoutError
      #couldn't contact twitter, which happens a lot
      return false
    end
  end

  def self.repopulate
    #only repopulate if twitter isn't experiencing problems
    if Tweet.pull_feed(TWITTER_CONFIG[:user_id])
      Tweet.delete_all
      @feed.items.each do |i|
        text = i.title.split(@username + ": ")[1].gsub(/https?:\/\/[^\s]*/){|s| "<a href=\"#{s}\">#{s}</a>"}
        t = Tweet.create({:text => text, :twitter_username => @username, :twitter_update_time => i.pubDate.to_s})
      end
    end
  end

  def self.latest_update
    @tweets = Tweet.find(:all, :order => 'twitter_update_time DESC')
    @tweets.each do |t|
      unless t.text =~ /^@/
        return t
      end
    end
  end

end
