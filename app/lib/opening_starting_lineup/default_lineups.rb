class OpeningStartingLineup::DefaultLineups

	LINEUPS_2018 = {
		giants: [
			"立岡",
			"吉川",
			"坂本　勇人",
			"ゲレーロ",
			"マギー",
			"岡本",
			"陽",
			"大城",
			"菅野"
		],
		tigers: [
			"西岡",
			"鳥谷",
			"糸井",
			"ロサリオ",
			"福留",
			"中谷",
			"髙山",
			"梅野",
			"藤浪"
		],
		swallows: [
			"青木",
			"川端",
			"山田",
			"バレンティン",
			"雄平",
			"畠山",
			"中村",
			"小川",
			"坂口"
		],
		carp: [
			"田中",
			"菊池",
			"丸",
			"鈴木",
			"松山",
			"安部",
			"西川",
			"會澤",
			"薮田"
		],
		baystars: [
			"桑原",
			"大和",
			"梶谷",
			"筒香",
			"ロペス",
			"宮﨑",
			"戸柱",
			"今永",
			"倉本"
		],
		dragons: [
			"京田",
			"大島",
			"ビシエド",
			"福田",
			"平田",
			"遠藤",
			"大野",
			"亀",
			"大野"
		],
		hawks: [
			"今宮",
			"本多",
			"柳田",
			"内川",
			"デスパイネ",
			"中村",
			"松田",
			"甲斐",
			"上林"
		],
		fighters: [
			"西川",
			"大田",
			"近藤",
			"中田",
			"アルシア",
			"レアード",
			"石井",
			"清水",
			"中島"
		],
		buffaloes: [
			"岡田",
			"安達",
			"吉田",
			"ロメロ",
			"小谷野",
			"マレーロ",
			"中島",
			"大城",
			"伊藤"
		],
		marines: [
			"加藤",
			"荻野",
			"角中",
			"安田",
			"鈴木",
			"中村",
			"井上",
			"田村",
			"平沢"
		],
		eagles: [
			"茂木",
			"藤田",
			"ペゲーロ",
			"ウィーラー",
			"銀次",
			"島内",
			"岡島",
			"オコエ",
			"嶋"
		],
		lions: [
			"金子",
			"源田",
			"秋山",
			"山川",
			"浅村",
			"森",
			"中村",
			"栗山",
			"外崎"
		]
	}

	private_constant :LINEUPS_2018

	def initialize(team_name, year)
		@team_name = team_name
		@year = year
	end

	def lineup
		lineup_to_id
	end

	def lineup_to_id
		team = LINEUPS_2018[@team_name.to_sym]
		team_id = {}
		team_id[:lineups] = {}
		9.times do |n|
			team_id[:lineups].store(n.to_s, { player_id: name_to_id(team, n) })
		end
		team_id
	end

	def name_to_id(team, order)
		player = Player.where(year: @year).where(team_id: Team.team_id(@team_name)).where("name like '%#{team[order]}%'").take
		return nil if player.nil?
		player.id
	end
end
