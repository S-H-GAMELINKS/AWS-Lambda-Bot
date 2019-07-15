load_paths = Dir["/vendor/bundle/ruby/2.5.0/gems/2.5.0/**/lib"]
$LOAD_PATH.unshift(*load_paths)

require "mastodon"

def lambda_handler(event:, context:)

  client = Mastodon::REST::Client.new(base_url: URL, bearer_token: ACCESS_TOKEN)

    client.hashtag_timeline(HASH_TAG).each do |toot|
        if !toot.reblogged? then
          response = client.reblog(toot.id)
          response = client.favourite(toot.id)
        end
    end
end