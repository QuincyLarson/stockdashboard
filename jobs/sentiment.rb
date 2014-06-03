SCHEDULER.every '30m', :first_in => 0 do |job|
  begin
    require 'cgi'
    sentiment = JSON.parse((URI.parse("http://ec2-54-83-155-47.compute-1.amazonaws.com:5000/api/v1/sentiment?symbol=twtr").read)).first[1]
    if sentiment
      sentiment = sentiment.map do |sentiment|
        if sentiment == "positive"
        if sentiment == "neutral"
        if sentiment == "negative"
      end
    end
    send_event('twitter_sentiment', comments: tweets)
  rescue
  end
end
