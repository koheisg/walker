# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: 'kohei.sg@gmail.com',
             password: 'test1234',
             sign_in_count: 1,
             current_sign_in_at: Time.zone.parse('2021-05-16 14:38:53.63592'),
             last_sign_in_at: Time.zone.parse('2021-05-16 14:38:53.63592'),
             current_sign_in_ip: '::1',
             last_sign_in_ip: '::1',
             confirmation_token: 'FyDyHr3PK1LKNfNnSqAq',
             confirmed_at: Time.zone.parse('2021-05-16 14:38:43.222425'),
             confirmation_sent_at: Time.zone.parse('2021-05-16 14:38:43.222425'),
             failed_attempts: 0)
Feed.create!(name: 'はてぶ', url: 'https://b.hatena.ne.jp/koheisg/favorite.rss?key=a2d08e4280c6dc0b17d98321ae230de19d971a74')
