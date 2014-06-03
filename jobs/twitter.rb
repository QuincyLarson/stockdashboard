#require 'twitter'
#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
#twitter = Twitter::REST::Client.new do |config|
#  config.consumer_key = ''
#  config.consumer_secret = 'YOUR_CONSUMER_SECRET'
#  config.oauth_token = 'YOUR_OAUTH_TOKEN'
#  config.oauth_token_secret = 'YOUR_OAUTH_SECRET'
#end
#
#search_term = URI::encode('#todayilearned')

SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
    require 'cgi'
    tweets = JSON.parse((URI.parse("http://ec2-54-83-155-47.compute-1.amazonaws.com:5000/api/v1/twitter?symbol=twtr").read)).first[1]
    if tweets
      tweets = tweets.map do |tweet|
        { name: tweet["username"], body: CGI.unescapeHTML(tweet["tweet"]) }
      end
    end
    send_event('twitter_mentions', comments: tweets)
  rescue
  end
end
