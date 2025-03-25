module UsersHelper
  private def redis
    @redis ||= ::Redis.new
  end

  def get_user_status(user)
    redis.get("user_status_#{user.id}") || "FAIL"
  end

  private def get_keyval(user)
    resp = client.post do |req|
      req.url "http://svcgo:8888/dat"
      req.headers["Content-Type"] = 'application/json'
      req.body = {
        id: 1,
        name: 'key',
        user: user.id
      }.to_json
    end
    JSON.parse(resp.body)['value'] || "FAIL"
  rescue
    "FAIL"
  end
end
