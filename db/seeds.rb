# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


videos= Video.create([{title: 'Monk', description: 'Monk is a great show because the detective figures out the mystery.', filename: 'monk'},{title: 'Futurama', description: 'Futurama is a common comedy. Quite funny.',filename:'futurama'},{title: 'Family Guy', description: 'Family Guy is an American adult animated sitcom created by Seth MacFarlane for the Fox Broadcasting Company. The series centers on the Griffins, a dysfunctional family consisting of parents Peter and Lois; their children Meg, Chris, and Stewie; and their anthropomorphic pet dog Brian.',filename:'family_guy'},{title:'South Park',description:"South Park is an American adult animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences, the show has become famous for its crude language and dark, surreal humor that lampoons a wide range of topics.",filename:'south_park'},{title:'Vampire Diaries',description:'The Vampire Diaries is a supernatural drama television series developed by Kevin Williamson and Julie Plec, based on the book series of the same name written by L. J. Smith.',filename:'vampire_diaries'},{title:'Smallville', description:'Smallville is an American television series developed by writers/producers Alfred Gough and Miles Millar. It is based on the DC Comics character Superman, originally created by Jerry Siegel and Joe Shuster. ', filename: 'smallville'}])

categories= Category.create([{name: 'Comedy'},{name:'Action'},{name:'Drama'}])

monk=Video.find_by title:'Monk'
futurama=Video.find_by title:'Futurama'
family_guy=Video.find_by title:'Family Guy'
south_park=Video.find_by title:'South Park'
vampire_diaries=Video.find_by title:'Vampire Diaries'
smallville=Video.find_by title:'Smallville'

comedy=Category.find_by name:'Comedy'
action=Category.find_by name:'Action'
drama=Category.find_by name:'Drama'


monk.categories << comedy
futurama.categories << comedy
south_park.categories << comedy
family_guy.categories << comedy

smallville.categories << action
vampire_diaries.categories << action

vampire_diaries.categories << drama
monk.categories << drama
