u1 = User.create(:name => "Mia Wallace", :password => "tarball", :password_confirmation => "tarball", :email => "mia@pulpfiction.com")
u2 = User.create(:name => "Vincent Vega", :password => "tarball", :password_confirmation => "tarball", :email => "vincent@pulpfiction.com")
u3 = User.create(:name => "Winston Wolfe", :password => "tarball", :password_confirmation => "tarball", :email => "wolfe@pulpfiction.com")
u4 = User.create(:name => "Butch Coolidge", :password => "tarball", :password_confirmation => "tarball", :email => "butch@pulpfiction.com")
u5 = User.create(:name => "Marcellus Wallace", :password => "tarball", :password_confirmation => "tarball", :email => "marcellus@pulpfiction.com")
u6 = User.create(:name => "Jules Winnfield", :password => "tarball", :password_confirmation => "tarball", :email => "jules@pulpfiction.com")
u7 = User.create(:name => "Jackie Brown", :password => "tarball", :password_confirmation => "tarball", :email => "jackie@panam.com")
u8 = User.create(:name => "Mr White", :password => "tarball", :password_confirmation => "tarball", :email => "white@reservoirdogs.com")
u9 = User.create(:name => "The Bride", :password => "tarball", :password_confirmation => "tarball", :email => "bride@killbill.com")
u10 = User.create(:name => "The Gimp", :password => "tarball", :password_confirmation => "tarball", :email => "gimp@pulpfiction.com")

g1 = Game.create(:total_score => 200, :filled => true)
g2 = Game.create(:total_score => 180, :filled => true)
g3 = Game.create(:total_score => 160, :filled => true)
g4 = Game.create(:total_score => 140, :filled => true)
g5 = Game.create(:total_score => 120, :filled => true)
g6 = Game.create(:total_score => 100, :filled => true)
g7 = Game.create(:total_score => 80, :filled => true)
g8 = Game.create(:total_score => 60, :filled => true)
g9 = Game.create(:total_score => 40, :filled => true)
g10 = Game.create(:total_score => 20, :filled => true)

u1.games << g1
u2.games << g2
u3.games << g3
u4.games << g4
u5.games << g5
u6.games << g6
u7.games << g7
u8.games << g8
u9.games << g9
u10.games << g10
