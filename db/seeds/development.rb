students = [{"firstname" => "Bram", "lastname" => "Leenders"}, 
  {"firstname" => "Marcel", "lastname" => "Boersma"}, 
  {"firstname" => "Bas", "lastname" => "Veeling"}, 
  {"firstname" => "Koen", "lastname" => "van Urk"}];
supervisors = [
  {"firstname" => "Djoerd", "lastname" => "Hiemstra"}, 
  {"firstname" => "Rom", "lastname" => "Langerak"}];

challenges = [
  { 'title' => 'Norvig big data award',
    'description' => '#Review process Submissions of results will be reviewed by our jury, and participants will be notified of the results before February 22, 2013. #Prizes The winner gets a tablet (type TBA), and 1500 Euro to spend on travel, accommodation, and conference registration for SIGIR 2013, for one person, to be held in Dublin, Ireland. The winner is also expected to give a lightning talk at Hadoop Summit Amsterdam, and gets a free access pass for the whole event. If applicants have entered as a group and the group produced the winning entry, the prize will be awarded to whomever the group decides, but each prize is awarded to a single person only. #Award Ceremony The award ceremony will be held on March 18 2013 at the University of Twente. #The name of the award The award is named after Peter Norvig, Googles director of research with a resume too impressive to summarize. Peter is on the advisory board of Common Crawl, and is part of the jury for this award.',
    'start_date' => Time.now + 3600*24*5,
    'end_date' => Time.now + 3600*24*30,
    'state' => 'draft',
    'count' => 0,
    'lead' => 'The Norvig Web Data Science Award is an award for students and researchers studying at or employed by a research institute or university in the Netherlands. It is a challenge in which participants show what they can do with the Common Crawl dataset - a snapshot of a large part of the web - using SURFsaras Hadoop service to provide big data compute power.', 
    'location' => 'Ravelijn 10', 
    'commitment' => 5,
    'supervisor' => supervisors[0],
    'participants' => []
  },
  { 'title' => 'Hackerrank',
    'description' => '1.1 Competitive Games Your Bot will play against a large sample of randomly chosen bots to see how it performs. It will play against many higher-ranked bots and some of the lower-ranked bots. The rating for each bot will then be calculated with a Bayesian Approximation formula, to reach a statistically accurate ranking. 1.1.1 Matchup Your bot is played against every bot ranked 1-10, and then against randomly chosen bots from the rest. It will play against 1 of 2 bots ranked 11-30, 1 of 4 bots ranked 31-70, 1 of 8 bots ranked 71-150, and so on. 1.1.2 Scoring Bot v/s Bot games are evaluated based on Bayesian Approximation. Each game has 3 possible outcomes - win, loss or a draw. A win will have 1 associated with it, 0.5 for a draw and 0 for a loss.',
    'start_date' => Time.now + 3600*24*15,
    'end_date' => Time.now + 3600*24*45,
    'state' => 'pending',
    'count' => 0,
    'lead' => 'An expanding set of challenges across multiple domains of Computer Science. Code in the browser in your chosen language, optimize your algorithm, and learn as you go.', 
    'location' => 'OH-123', 
    'commitment' => 10,
    'supervisor' => supervisors[0],
    'participants' => []
  },
  { 'title' => 'Kaggle machine learning',
    'description' => 'Getting Started Competition, with tutorials in Excel, Python and introduction to Random Forests.
The sinking of the RMS Titanic is one of the most infamous shipwrecks in history.  On April 15, 1912, during her maiden voyage, the Titanic sank after colliding with an iceberg, killing 1502 out of 2224 passengers and crew.  This sensational tragedy shocked the international community and led to better safety regulations for ships.
One of the reasons that the shipwreck led to such loss of life was that there were not enough lifeboats for the passengers and crew.  Although there was some element of luck involved in surviving the sinking, some groups of people were more likely to survive than others, such as women, children, and the upper-class.
In this contest, we ask you to complete the analysis of what sorts of people were likely to survive.  In particular, we ask you to apply the tools of machine learning to predict which passengers survived the tragedy.
This Kaggle Getting Started Competition provides an ideal starting place for people who may not have a lot of experience in data science and machine learning. The data is highly structured and we provide 3 tutorials of increasing complexity.  Please use the forums freely and as much as you like. There is no such thing as a stupid question; we guarantee someone else will be wondering the same thing!',
    'start_date' => Time.now + 3600*24*5,
    'end_date' => Time.now + 3600*24*30,
    'state' => 'approved',
    'count' => 0,
    'lead' => 'Predict if a titanic passenger survives the cruise', 
    'location' => 'Any place', 
    'commitment' => 2,
    'supervisor' => supervisors[1],
    'participants' => [students[0], students[1]]
  },
  { 'title' => 'Cleaning the windows',
    'description' => 'Learn how to clean windows real good. Ultra-clean windows are the max!',
    'start_date' => Time.now + 3600*24*5,
    'end_date' => Time.now + 3600*24*30,
    'state' => 'draft',
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
  
follows = [
  { 'user' => students[0], 'follows' => [students[1]] },
  { 'user' => students[1], 'follows' => [students[0], students[3], students[2]] },  
  { 'user' => students[2], 'follows' => [supervisors[0]] },
  { 'user' => students[3], 'follows' => [students[0], students[1]] },
  { 'user' => supervisors[0], 'follows' => [students[1], students[2]] },
  { 'user' => supervisors[1], 'follows' => [supervisors[0]] }
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

    challengerecord = Challenge.new(:title => challenge['title'], :description => challenge['description'], :start_date => challenge['start_date'], :end_date => challenge['end_date'], :lead => challenge['lead'], :location => challenge['location'], :commitment => challenge['commitment'])
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
