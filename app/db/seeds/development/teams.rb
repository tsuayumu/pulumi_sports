name = %w{
  読売ジャイアンツ
  阪神タイガーズ
  東京ヤクルトスワローズ
  広島東洋カープ
  横浜DeNAベイスターズ
  中日ドラゴンズ
  福岡ソフトバンクホークス
  北海道日本ハムファイターズ
  近鉄オリックスバッファローズ
  千葉ロッテマリーンズ
  東北楽天ゴールデンイーグルズ
  埼玉西武ライオンズ
}

name_en = %w{
  giants
  tigers
  swallows
  carp
  baystars
  dragons
  hawks
  fighters
  buffaloes
  marines
  eagles
  lions
}

12.times do |n|
  league = n < 6 ? 1 : 2
  Team.create!(
    name: "#{name[n]}",
    name_en: "#{name_en[n]}",
    league_id: league
  )
end