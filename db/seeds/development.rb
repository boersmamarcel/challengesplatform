students = [{"firstname" => "Bram", "lastname" => "Leenders"}, 
  {"firstname" => "Marcel", "lastname" => "Boersma"}, 
  {"firstname" => "Bas", "lastname" => "Veeling"}, 
  {"firstname" => "Koen", "lastname" => "van Urk"}];
supervisors = [{"firstname" => "Djoerd", "lastname" => "Hiemstra"}, {"firstname" => "Rom", "lastname" => "Langerak"}];

challenges = [
  { 'title' => 'Norvig big data award',
    'description' => 'Show what you can do with 6 billion webpages. Blah, blah, blah, more description **whoa!**',
    'start_date' => Time.now + 3600*24*5,
    'end_date' => Time.now + 3600*24*30,
    'state' => 'proposal',
    'count' => 0,
    'lead' => '6 billion pages are awesome! I am the lead', 
    'location' => 'Ravelijn 10', 
    'commitment' => 5,
    'supervisor' => supervisors[0],
    'participants' => []
  },
  { 'title' => 'Hackerrank',
    'description' => 'Build your own fantastic AI bots. If you need more info, visit blah, blah, boempiedoem poe',
    'start_date' => Time.now + 3600*24*15,
    'end_date' => Time.now + 3600*24*45,
    'state' => 'pending',
    'count' => 0,
    'lead' => 'Create your own VIKI, and take over the world!', 
    'location' => 'OH-123', 
    'commitment' => 10,
    'supervisor' => supervisors[0],
    'participants' => []
  },
  { 'title' => 'Kaggle machine learning',
    'description' => 'Predict if you will surivive the titanic cruise... It\'s really difficult, but you\'re up for it, cause you rock!',
    'start_date' => Time.now + 3600*24*5,
    'end_date' => Time.now + 3600*24*30,
    'state' => 'approved',
    'count' => 0,
    'lead' => 'Machine learning ftw. Join now', 
    'location' => 'Any place', 
    'commitment' => 2,
    'supervisor' => supervisors[1],
    'participants' => [students[0], students[1]]
  },
  { 'title' => 'Cleaning the windows',
    'description' => 'Learn how to clean windows real good. Ultra-clean windows are the max!',
    'start_date' => Time.now + 3600*24*5,
    'end_date' => Time.now + 3600*24*30,
    'state' => 'proposal',
    'count' => 2,
    'lead' => 'Shine on, you crazy window', 
    'location' => 'ZI 1', 
    'commitment' => 5,
    'supervisor' => supervisors[1],
    'participants' => []
  },
  { 'title' => 'Graph search',
    'description' => 'Learn how to build the facebook graph search. Lorem ipsum ....',
    'start_date' => Time.now - 3600*24*5,
    'end_date' => Time.now + 3600*24*30,
    'state' => 'approved',
    'count' => 2,
    'lead' => 'Graphs are pretty, graphs are nice, I just really do like ice!', 
    'location' => 'RA 1234', 
    'commitment' => 5,
    'supervisor' => supervisors[1],
    'participants' => [students[2], students[3]]
  },
    { 'title' => 'Graph find',
    'description' => 'learn to find a graph or so',
    'start_date' => Time.now + 3600*24*5,
    'end_date' => Time.now + 3600*24*30,
    'state' => 'approved',
    'count' => 2,
    'lead' => 'Moar graphs', 
    'location' => 'ZI 1', 
    'commitment' => 5,
    'supervisor' => supervisors[0],
    'participants' => [students[2], students[3]]
  },
    { 'title' => 'Algorithm complexity',
    'description' => 'Optimize the world with this kind of stuff',
    'start_date' => Time.now + 3600*24*5,
    'end_date' => Time.now + 3600*24*30,
    'state' => 'approved',
    'count' => 2,
    'lead' => 'ax+by = 10?', 
    'location' => 'ZI 1', 
    'commitment' => 7,
    'supervisor' => supervisors[1],
    'participants' => [students[2], students[3]]
  }
];
  
follows = [{
  'user' => students[0],
  'follows' => [students[1]]
  },
  {
    'user' => students[1],
    'follows' => [students[0], students[3], students[2]]
  },  
  {
   'user' => students[2],
   'follows' => [supervisors[0]]
  },
  {
   'user' => students[3],
   'follows' => [students[0], students[1]]
  },
  {
   'user' => supervisors[0],
   'follows' => [students[1], students[2]]
  },
  {
   'user' => supervisors[1],
   'follows' => [supervisors[0]]
  }
  ];

students.each do |student|
  user = User.new(:firstname => student['firstname'], :lastname => student['lastname'], :email => "#{student['firstname']}@student.utwente.nl", :password => "studentpass", :password_confirmation => "studentpass")
  user.role = 0
  user.save
  Message.create!(:subject => "The first test message", :body => "And this is the body text of that message.", :sender_id => user.id, :receiver_id => user.id, :is_read => false)
  Message.create!(:subject => "A message with a very long title to see how that works, just for science", :body => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam tortor est, gravida at lacinia sit amet, fringilla in lacus. Fusce rhoncus, elit a malesuada pharetra, nulla leo mollis arcu, nec euismod quam tortor in augue. Mauris nisi velit, ultricies eget gravida eu, vehicula in massa. Phasellus vestibulum porttitor lacinia. Suspendisse potenti. Nam volutpat, eros eget faucibus sollicitudin, lacus augue venenatis arcu, vel scelerisque erat nulla ut metus. Mauris dictum eros ut nunc pretium ultrices. Proin lacinia, ligula quis tempus rhoncus, dolor odio aliquam nulla, eu tempor ligula odio vel ligula. Nam fringilla, risus id vulputate venenatis, nunc elit gravida quam, quis imperdiet tortor tortor vestibulum tellus.", :sender_id => user.id, :receiver_id => user.id, :is_read => false)
  
end

supervisors.each do |supervisor|
 user = User.new(:firstname => supervisor['firstname'], :lastname => supervisor['lastname'], :email => "#{supervisor['firstname']}@utwente.nl", :password => "supervisorpass", :password_confirmation => "supervisorpass")
 user.role = 1
 user.save
 Message.create!(:subject => "The first test message", :body => "And this is the body text of that message.", :sender_id => user.id, :receiver_id => user.id, :is_read => false)
 Message.create!(:subject => "A message with a very long title to see how that works, just for science", :body => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam tortor est, gravida at lacinia sit amet, fringilla in lacus. Fusce rhoncus, elit a malesuada pharetra, nulla leo mollis arcu, nec euismod quam tortor in augue. Mauris nisi velit, ultricies eget gravida eu, vehicula in massa. Phasellus vestibulum porttitor lacinia. Suspendisse potenti. Nam volutpat, eros eget faucibus sollicitudin, lacus augue venenatis arcu, vel scelerisque erat nulla ut metus. Mauris dictum eros ut nunc pretium ultrices. Proin lacinia, ligula quis tempus rhoncus, dolor odio aliquam nulla, eu tempor ligula odio vel ligula. Nam fringilla, risus id vulputate venenatis, nunc elit gravida quam, quis imperdiet tortor tortor vestibulum tellus.", :sender_id => user.id, :receiver_id => user.id, :is_read => false)

end

admin = User.new(:firstname => "Kevin", :lastname => "Flynn", :email => "admin@utwente.nl", :password => "adminpass", :password_confirmation => "adminpass")
admin.role = 2
admin.save

challenges.each do |challenge|
    supervisor = User.where(:firstname => challenge['supervisor']['firstname'], :lastname => challenge['supervisor']['lastname']).first;

    challengerecord = Challenge.new(:title => challenge['title'], :description => challenge['description'], :start_date => challenge['start_date'], :end_date => challenge['end_date'])
    challengerecord.supervisor = supervisor
    challengerecord.state = challenge['state']
    challengerecord.count = challenge['count']
    challengerecord.save
    
    challenge['participants'].each do |participant|
        enrollment = challengerecord.enrollments.build
        user = User.where(:firstname => participant['firstname'], :lastname => participant['lastname']).first
        enrollment.participant = user
        enrollment.save
    end
    
end

follows.each do |relation|
  user = User.where(:firstname => relation['user']['firstname'], :lastname => relation['user']['lastname']).first
  relation['follows'].each do |follow|
    if !follow.nil? && !user.nil?
      f = User.where(:firstname => follow['firstname'], :lastname => follow['lastname']).first
      Follow.create!(:user_id => user.id, :following_id => f.id) unless f.nil?
    end
  end
end




