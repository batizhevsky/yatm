module FayeHelper
  def send_msg_to(user_id, msg)
    return if user_id.nil?
    PrivatePub.publish_to "/messages/user-#{ user_id }", message: msg 
  end
end
