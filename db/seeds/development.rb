students = [{"firstname" => "Bram", "lastname" => "Leenders"}, 
  {"firstname" => "Marcel", "lastname" => "Boersma"}, 
  {"firstname" => "Bas", "lastname" => "Veeling"}, 
  {"firstname" => "Koen", "lastname" => "van Urk"}];
supervisors = [{"firstname" => "Djoerd", "lastname" => "Hiemstra"}, {"firstname" => "Rom", "lastname" => "Langerak"}];

challenges = [
  { 'title' => 'Norvig big data award',
    'description' => 'Show what you can do with 6 billion webpages',
    'start_date' => Time.now + 3600*24*5,
    'end_date' => Time.now + 3600*24*30,
    'state' => 'proposal',
    'count' => 0,
    'supervisor' => supervisors[0],
    'participants' => []
  },
  { 'title' => 'Hackerrank',
    'description' => 'Build your own fantastic AI bots',
    'start_date' => Time.now + 3600*24*15,
    'end_date' => Time.now + 3600*24*45,
    'state' => 'pending',
    'count' => 0,
    'supervisor' => supervisors[0],
    'participants' => []
  },
  { 'title' => 'Kaggle machine learning',
    'description' => 'Predict if you will surivive the titanic cruise...',
    'start_date' => Time.now + 3600*24*5,
    'end_date' => Time.now + 3600*24*30,
    'state' => 'approved',
    'count' => 0,
    'supervisor' => supervisors[1],
    'participants' => [students[0], students[1]]
  },
  { 'title' => 'Cleaning the windows',
    'description' => 'Learn how to clean windows',
    'start_date' => Time.now + 3600*24*5,
    'end_date' => Time.now + 3600*24*30,
    'state' => 'proposal',
    'count' => 2,
    'supervisor' => supervisors[1],
    'participants' => []
  },
  { 'title' => 'Graph search',
    'description' => 'learn how to build the facebook graph search',
    'start_date' => Time.now - 3600*24*5,
    'end_date' => Time.now + 3600*24*30,
    'state' => 'approved',
    'count' => 2,
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
  User.create!(:firstname => student['firstname'], :lastname => student['lastname'], :email => "#{student['firstname']}@student.utwente.nl", :password => "studentpass", :password_confirmation => "studentpass")
end

supervisors.each do |supervisor|
 User.create!(:firstname => supervisor['firstname'], :lastname => supervisor['lastname'], :email => "#{supervisor['firstname']}@utwente.nl", :password => "supervisorpass", :password_confirmation => "supervisorpass", :role => 1)
end
challenges.each do |challenge|
    supervisor = User.where(:firstname => challenge['supervisor']['firstname'], :lastname => challenge['supervisor']['lastname']).first;

    challengerecord = Challenge.new(:title => challenge['title'], :description => challenge['description'], :start_date => challenge['start_date'], :end_date => challenge['end_date'], :state => challenge['state'], :count => challenge['count'])
    challengerecord.supervisor = supervisor
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


