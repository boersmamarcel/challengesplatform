module MessageCenter
  
  @@markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
  
  def sendMessageToUser(to_user, from_user, subject, body, render_markdown = true)
    raise MessageException::ParameterShouldBeUser.new('To User should be of type User') unless to_user.is_a? User
    raise MessageException::ParameterShouldBeUser.new('From User should be of type User') unless from_user.is_a? User
    if render_markdown
      body = @@markdown.render(body)
    end
    @message = Message.create(:subject => subject, :body => body, :sender_id => from_user.id, :receiver_id => to_user.id, :is_read => 0)
    
    if to_user.notify_by_email && !Rails.env.test?
        UserMailer.personal_message(to_user.email, subject, body).deliver
    end
  end
  
  def sendMessageToGroup(group, from_user, subject, body, render_markdown = true)
    raise MessageException::ParameterShouldBeArray.new('Group should be an array') unless group.is_a? Array
    group.each do |user|
      sendMessageToUser(user, from_user, subject, body, render_markdown)
    end
  end
  
  def sendMessageTemplateToGroup(group, from_user, subject, template, values)
    body = render_to_string template, :layout => false, :locals => { :values => values }
    sendMessageToGroup(group, from_user, subject, body, false)
  end
  
  def sendMessageTemplateToUser(to_user, from_user, subject, template, values)
    sendMessageTemplateToGroup([to_user], from_user, subject, template, values)
  end
  
end