class OpeningStartingLineupCommentForm
	include ActiveModel::Model

	attr_accessor :user_id, :opening_starting_lineup_id, :comment

	def save
		opening_starting_lineup_comment = OpeningStartingLineupComment.new(user_id: user_id, opening_starting_lineup_id: opening_starting_lineup_id, comment: comment)
		opening_starting_lineup_comment.save!
	end
end
