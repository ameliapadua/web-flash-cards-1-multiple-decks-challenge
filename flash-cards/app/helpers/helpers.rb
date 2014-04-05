helpers do
  # This will return the current user, if they exist
  # Replace with code that works with your application
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end

  # Returns true if current_user exists, false otherwise
  def logged_in?
    !current_user.nil?
  end

  def any_rounds?
    @current_user.rounds.first != nil
  end

  def create_rounds_hash
    @rounds = @current_user.rounds

    @rounds.reverse.each_with_object({}) do |round, stats_hash|
      correct = 0
      incorrect = 0

      round.guesses.each do |guess|
        guess.correct ? correct += 1 : incorrect += 1
      end

      stats_hash[round.id] = {
        deck: Deck.find(round.deck_id).name,
        correct: correct,
        incorrect: incorrect,
        total: correct + incorrect,
        percentage: (correct * 100)/(correct + incorrect)
      }
    end
  end
end
