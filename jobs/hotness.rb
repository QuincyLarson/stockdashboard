SCHEDULER.every '1m', :first_in => 0 do |job|
  begin
    require 'cgi'
    tweets = JSON.parse((URI.parse("http://ec2-54-83-155-47.compute-1.amazonaws.com:5000/api/v1/twitter?symbol=twtr").read)).first[1]
    if tweets
      tweets = tweets.map do |tweet|
        { name: tweet["username"], body: CGI.unescapeHTML(tweet["twit"]) }
      end
    end
    send_event('twitter_mentions', comments: tweets)
  rescue
  end
end