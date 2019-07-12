# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
fil = Filial.create(num:1, name: "Калачевский", code: "mfc111")
gku = Filial.create(num:4, name: "центральный", code: "mfc34")
lenin = Filial.create(num:2, name: "Ленинский", code: "mfc191")
fil2 = Filial.create(num:3, name: "Фроловский МФЦ", code: "mfc271")
gku.people.create FIO: "Кещян Арарат Фрадикович"
fil.people.create FIO: "Косенко Н.Г."
fil2.people.create FIO: "Чувашин Ю.В."
type1 = Type.create name: "МФУ", num: 1
type2 = Type.create name: "Сервера", num: 2
type3 = Type.create name: "Рабочие станции", num: 3

5.times do |n|
    fil.devices.create!(name: "MФУ № #{n+1}",
			    model: "Canon ir1133",
			    invnum: "00000#{n*2}",
			    serial: "AAAA#{n+1}",
			    place: "Окно #{n}",
			    dateprod: "2015-10-01 00:00:00",
			     mark: "примечания нет", 
			    iswork: true,
			    type_id: 1,
			    cancellation: false)
end

5.times do |n|
    lenin.devices.create!(name: "MФУ № #{n+1}",
			    model: "Rikoh SP111",
			    invnum: "00000#{n*2}",
			    serial: "BBS777#{n+1000}",
			    place: "Окно #{n}",
			    dateprod: "2015-10-01 00:00:00",
			     mark: "примечания нет", 
			    iswork: true,
			    type_id: 1,
			    cancellation: false)
end

10.times do |n|
    fil2.devices.create!(name: "рабочая станция № #{n+1}",
			    model: "Desten 821",
			    invnum: "0#{n*2}000#{n*2}",
			    serial: "AA#{n*3}AA#{n+1}",
			    place: "Окно #{n}",
			    dateprod: "2014-10-01 00:00:00",
			     mark: "примечания нет", 
			    iswork: true,
			    type_id: 3,
			    cancellation: false)
end



fil.users.create!(name:  "itgone",
             email: "itgoness@mail.ru",
             password:              "123456",
             password_confirmation: "123456",
	     admin: true,
	     right: 255)

gku.users.create!(name:  "vik",
             email: "vik@mail.ru",
             password:              "123456",
             password_confirmation: "123456",
	     admin: true,
	     right: 255)


10.times do |n|
  name  = Faker::Name.name
  email = "user-#{n+1}@mail.org"
  password = "password"
  fil2.users.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
