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
      deck = Deck.find(round.deck_id)
      puts "------------------------------------"
      puts "Guesses: #{round.guesses.count}"
      puts "Deck: #{deck.cards.count}"
      puts "------------------------------------"
      round.guesses.count < deck.cards.count ? completeness = "Incomplete" : completeness = "Complete"
      stats_hash[round.id] = {
        deck: deck.name,
        correct: correct,
        incorrect: incorrect,
        total: round.guesses.count,
        completeness: completeness,
        percentage: (correct * 100)/(correct + incorrect)
      }
    end
  end

  def create_current_rounds_hash
    last_round = current_user.rounds.last

    # rounds.reverse.each_with_object({}) do |round, stats_hash|
      correct = 0
      incorrect = 0

      last_round.guesses.each do |guess|
        guess.correct ? correct += 1 : incorrect += 1
      end
      deck = Deck.find(last_round.deck_id)
      puts "------------------------------------"
      puts "Guesses: #{last_round.guesses.count}"
      puts "Deck: #{deck.cards.count}"
      puts "------------------------------------"
      last_round.guesses.count < deck.cards.count ? completeness = "Incomplete" : completeness = "Complete"
      {
        deck: deck.name,
        correct: correct,
        incorrect: incorrect,
        total: last_round.guesses.count,
        completeness: completeness,
        percentage: (correct * 100)/(correct + incorrect)
      }
    # end
  end
end
