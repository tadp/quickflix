# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


videos= Video.create([{title: 'Monk', description: 'Monk is a great show because the detective figures out the mystery.', filename: 'monk'},{title: 'Futurama', description: 'Futurama is a common comedy. Quite funny.',filename:'futurama'},{title: 'Family Guy', description: 'Family Guy is an American adult animated sitcom created by Seth MacFarlane for the Fox Broadcasting Company. The series centers on the Griffins, a dysfunctional family consisting of parents Peter and Lois; their children Meg, Chris, and Stewie; and their anthropomorphic pet dog Brian.',filename:'family_guy'},{title:'South Park',description:"South Park is an American adult animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences, the show has become famous for its crude language and dark, surreal humor that lampoons a wide range of topics.",filename:'south_park'},{title:'Vampire Diaries',description:'The Vampire Diaries is a supernatural drama television series developed by Kevin Williamson and Julie Plec, based on the book series of the same name written by L. J. Smith.',filename:'vampire_diaries'},{title:'Smallville', description:'Smallville is an American television series developed by writers/producers Alfred Gough and Miles Millar. It is based on the DC Comics character Superman, originally created by Jerry Siegel and Joe Shuster. ', filename: 'smallville'}])
Video.create([{title: 'How I Met Your Mother', description: "How I Met Your Mother is an American sitcom on CBS. The series follows the main character, Ted Mosby, and his group of friends in Manhattan. As a framing device, Ted, in the year 2030, recounts to his son and daughter the events that led to his meeting their mother.", filename: 'how_i_met_your_mother'}])
Video.create([{title: 'Friends', description: "Friends is an American sitcom created by David Crane and Marta Kauffman, which aired on NBC from September 22, 1994 to May 6, 2004. The series revolves around a group of friends in the New York City borough of Manhattan. The series was produced by Bright/Kauffman/Crane Productions, in association with Warner Bros. Television. The original executive producers were Crane, Kauffman, and Kevin S. Bright, with numerous others being promoted in later seasons.", filename: 'friends'}])
Video.create([{title: 'Simpsons', description: "The Simpsons is an American animated sitcom created by Matt Groening for the Fox Broadcasting Company. The series is a satirical parody of a middle class American lifestyle epitomized by its family of the same name, which consists of Homer, Marge, Bart, Lisa, and Maggie. The show is set in the fictional town of Springfield and parodies American culture, society, television, and many aspects of the human condition.", filename: 'simpsons'}])

categories= Category.create([{name: 'Comedy'},{name:'Action'},{name:'Drama'}])

monk=Video.find_by title:'Monk'
futurama=Video.find_by title:'Futurama'
family_guy=Video.find_by title:'Family Guy'
south_park=Video.find_by title:'South Park'
vampire_diaries=Video.find_by title:'Vampire Diaries'
smallville=Video.find_by title:'Smallville'
how_i_met_your_mother=Video.find_by title: 'How I Met Your Mother'
friends=Video.find_by title: 'Friends'
simpsons=Video.find_by title: 'Simpsons'

comedy=Category.find_by name:'Comedy'
action=Category.find_by name:'Action'
drama=Category.find_by name:'Drama'


monk.categories << comedy
futurama.categories << comedy
south_park.categories << comedy
family_guy.categories << comedy
how_i_met_your_mother.categories << comedy
friends.categories << comedy
simpsons.categories << comedy

smallville.categories << action
vampire_diaries.categories << action

vampire_diaries.categories << drama
monk.categories << drama
