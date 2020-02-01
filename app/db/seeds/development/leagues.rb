name = %w{
  セントラルリーグ
  パシフィックリーグ
}

name_en = %w{
  central
  pacific
}

2.times do |n|
  League.create!(
    name: "#{name[n]}",
    name_en: "#{name_en[n]}",
    status: n+1
  )
end