module UsersHelper
  private def redis
    @redis ||= ::Redis.new
  end

  def get_user_status(user)
    redis.get("user_status_#{user.id}") || "FAIL"
  end

end
