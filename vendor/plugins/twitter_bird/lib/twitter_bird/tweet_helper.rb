module TweetHelper
  def twitter_bird(num = 1, rotate = false)
    tweets = Tweet.find_and_store(num)
    if tweets.length > 0
<<EOF
    <div id="twitter_bird">
      <div id="tweet_top"></div>
      <div id="tweet"><div class="text">#{tweets[0].text}&nbsp;<img class="rquote" src="/images/twitter_bird/rquote.png">
      </div></div>
      <div id="tweet_bottom"></div>
      <div class="posted_at"><a href="http://twtter.com/bbwharris">Posted #{time_ago_in_words(tweets[0].twitter_update_time)} ago. <strong>Follow Me.</strong></a></div>
    </div>
EOF
    end
  end
end
