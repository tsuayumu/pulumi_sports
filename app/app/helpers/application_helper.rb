module ApplicationHelper

	# view用のメソッド　header footer
	def central_teams_for_views
		League.central_teams
	end

	def pacific_teams_for_views
		League.pacific_teams
	end

	# view用のメソッド　opening_starting_lineup
	def opening_starting_lineup_comments(opening_starting_lineup_id)
		OpeningStartingLineupComment.comments(opening_starting_lineup_id)
	end

	def select_homerun
		homerun = []
		1..12.times do |num|
			homerun << [5 * num, 5 * num]
		end
		homerun
	end

	def select_average
		average = []
		1..10.times do |num|
			average << [50 * num, 50 * num]
		end
		average
	end

	def select_rbi
		rbi = []
		1..16.times do |num|
			rbi << [10 * num, 10 * num]
		end
		rbi
	end

	def select_steal
		steal = []
		1..11.times do |num|
			steal << [5 * num, 5 * num]
		end
		steal
	end
end
