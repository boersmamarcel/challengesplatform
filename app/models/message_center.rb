module MessageCenter
  
  @@markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
  
  def sendMessageToUser(to_user, from_user, subject, body, render_markdown = true)
    raise MessageException::ParameterShouldBeUser.new('User should be of type User') unless to_user.is_a? User
    raise MessageException::ParameterShouldBeUser.new('User should be of type User') unless from_user.is_a? User
    if render_markdown
      body = @@markdown.render(body)
    end
    @message = Message.create(:subject => subject, :body => body, :sender_id => from_user.id, :receiver_id => to_user.id, :is_read => 0)
    
    if to_user.notify_by_email && !Rails.env.test?
      mail_footer = render_to_string "messages/mail_footer", :layout => false
      
      %x[sendmail #{to_user.email} << EOF
Subject: #{subject}
From: #{ENV['notification_email']}
To: #{to_user.email}
Content-type: text/html
MIME-Version: 1.0

#{body}

#{mail_footer}
EOF]
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