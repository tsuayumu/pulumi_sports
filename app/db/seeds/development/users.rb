User.create!(
  name: "tsuda",
  email: "t.ayu.1605@gmail.com",
  password: 'password',
  favorite_team_id: 1
)

family_names = %w{
  佐藤:サトウ:sato
  鈴木:スズキ:suzuki
  髙橋:タカハシ:takahashi
  田中:タナカ:tanaka
}

given_names = %w{
  二郎:ジロウ:jiro
  三郎:サブロウ:saburo
  松子:マツコ:matsuko
  竹子:タケコ:takeko
  梅子:ウメコ:umeko
}

12.times do |n|
  fn = family_names[n % 4].split(':')
  gn = given_names[n % 5].split(':')

  User.create!(
    name: "#{fn[2]}#{gn[2]}",
    email: "#{fn[2]}.#{gn[2]}@example.com",
    password: 'password',
    favorite_team_id: 1
  )
end