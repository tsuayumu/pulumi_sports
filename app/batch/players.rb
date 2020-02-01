require 'nokogiri'
require 'open-uri'

TEAM = [
	{ name_en: "giants", key: "g" },
	{ name_en: "tigers", key: "t" },
	{ name_en: "swallows", key: "s" },
	{ name_en: "carp", key: "c" },
	{ name_en: "baystars", key: "yb" },
	{ name_en: "dragons", key: "d" },
	{ name_en: "hawks", key: "h" },
	{ name_en: "fighters", key: "f" },
	{ name_en: "buffaloes", key: "bs" },
	{ name_en: "marines", key: "m" },
	{ name_en: "eagles", key: "e" },
	{ name_en: "lions", key: "l" }
]

YEARS = {
	'2020' => '',
	'2019' => '18',
	'2018' => '17'
}

def create_player(team, year, y_string)
	url = "https://baseball-data.com/#{y_string}/player/#{team[:key]}/"

	charset = nil

	html = open(url) do |f|
		charset = f.charset
		f.read
	end

	doc = Nokogiri::HTML.parse(html, nil, charset)

	doc.xpath('//tr').each do |node|
		player = Player.new
		player.year = year.to_i
		player.name = node.search("td:nth-child(2)").text
		player.team_id = Team.team_id("#{team[:name_en]}")
		player.save!
		p player.name
	end
end

def create_player_record_fielder(team, year, y_string)
	url = "https://baseball-data.com/#{y_string}/stats/hitter-#{team[:key]}/"

	charset = nil

	html = open(url) do |f|
		charset = f.charset
		f.read
	end

	doc = Nokogiri::HTML.parse(html, nil, charset)

	doc.xpath('//tr').each do |node|
		player = Player.where(year: year).find_by(name: node.search("td:nth-child(2)").text)
		if player.present? && !player.id.nil? && !(player.name == "")
			record = PlayerRecord.find_by(player_id: player.id)
			if record.nil?
				record = PlayerRecord.new
			end
			p player.name
			p node.search("td:nth-child(3)").text.to_f
			p node.search("td:nth-child(9)").text.to_i
			p node.search("td:nth-child(8)").text.to_i
			record.player_id = player.id
			record.average = node.search("td:nth-child(3)").text.to_f
			record.rbi = node.search("td:nth-child(9)").text.to_i
			record.homerun = node.search("td:nth-child(8)").text.to_i
			record.save!
		end
	end
end

def create_player_record_pitcher(team, year, y_string)
	url = "https://baseball-data.com/#{y_string}/stats/pitcher-#{team[:key]}/"

	charset = nil

	html = open(url) do |f|
	    charset = f.charset
	    f.read
	end

	doc = Nokogiri::HTML.parse(html, nil, charset)

	doc.xpath('//tr').each do |node|
		player = Player.where(year: year).find_by(name: node.search("td:nth-child(2)").text)
		if player.present? && !player.id.nil? && !(player.name == "")
			record = PlayerRecord.find_by(player_id: player.id)
			if record.nil?
				record = PlayerRecord.new
			end
			p player.name
			p node.search("td:nth-child(3)").text.to_f
			p node.search("td:nth-child(4)").text.to_i
			p node.search("td:nth-child(5)").text.to_i
			p node.search("td:nth-child(6)").text.to_f
			p node.search("td:nth-child(7)").text.to_i
			p node.search("td:nth-child(8)").text.to_i
			record.player_id = player.id
			record.era = node.search("td:nth-child(3)").text.to_f
			record.match = node.search("td:nth-child(4)").text.to_i
			record.win = node.search("td:nth-child(5)").text.to_i
			record.defeat = node.search("td:nth-child(6)").text.to_i
			record.hold = node.search("td:nth-child(8)").text.to_i
			record.save_point = node.search("td:nth-child(7)").text.to_i
			record.save!
		end
	end
end

YEARS.each do |year, y_string|
	next if Player.exists?(year: year.to_i)
	TEAM.each do |team|
		create_player(team, year, y_string)
		create_player_record_fielder(team, year, y_string)
		create_player_record_pitcher(team, year, y_string)
	end
end
