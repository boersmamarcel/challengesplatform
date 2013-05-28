module MessageCenter
  
  def sendMessageToUser(user, subject, body)
    raise MessageException::ParameterShouldBeUser.new('Group should be an array') unless user.is_a? User
    @message = Message.create(:subject => subject, :body => body, :sender_id => current_user.id, :receiver_id => user.id, :is_read => 0)
    
    
    
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    markdown_body = markdown.render(body)
    mail_footer = render_to_string "messages/mail_footer", :layout => false
    
    if user.notify_by_email && !Rails.env.test?
      %x[sendmail #{user.email} << EOF
Subject: #{subject}
From: #{ENV['notification_email']}
To: #{user.email}
Content-type: text/html
MIME-Version: 1.0

#{markdown_body}

#{mail_footer}
EOF]
    end
  end
  
  def sendMessageToGroup(group, subject, body)
    raise MessageException::ParameterShouldBeArray.new('Group should be an array') unless group.is_a? Array
    group.each do |user|
      sendMessageToUser(user, subject, body)
    end
  end
  
end