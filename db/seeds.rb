# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user  = User.create({first_name:'John', last_name:'Doe', username:'Johny', password:'12345678', email:'john@mail.ru', birthday:'12.12.1900', user_id:'1'})
user1 = User.create({first_name:'Jane', last_name:'Doe', username:'Janeny', password:'12345678', email:'jane@mail.ru', birthday:'13.12.1970', user_id:'2'})
user2 = User.create({first_name:'Don', last_name:'Doe', username:'Donny', password:'12345678', email:'ben@mail.ru', birthday:'14.12.1999', user_id:'3'})
user3 = User.create({first_name:'Ben', last_name:'Doe', username:'Benny', password:'12345678', email:'john@mail.ru', birthday:'15.12.2900', user_id:'4'})
user4 = User.create({first_name:'Shon', last_name:'Doe', username:'Shonny', password:'12345678', email:'shon@mail.ru', birthday:'16.12.1990', user_id:'5'})
user5 = User.create({first_name:'Kim', last_name:'Doe', username:'Kimny', password:'12345678', email:'kim@mail.ru', birthday:'17.12.1980', user_id:'6'})
user6 = User.create({first_name:'Moe', last_name:'Doe', username:'Moeny', password:'12345678', email:'moe@mail.ru', birthday:'18.12.1970', user_id:'7'})

