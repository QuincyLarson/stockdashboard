SCHEDULER.every '30m', :first_in => 0 do |job|
  begin
    require 'cgi'
    sentiment = JSON.parse((URI.parse("http://ec2-54-83-155-47.compute-1.amazonaws.com:5000/api/v1/sentiment?symbol=twtr").read)).first[1]
    color = "#C0C0C0"
    if sentiment
      sentiment = sentiment.map do |sentiment|
        if sentiment == "positive"
            color = "#00FF00"
        if sentiment == "negative"
            color = "#FF0000"
      end
    end
    send_event('twitter_sentiment', color: color)
  rescue
  end
end
