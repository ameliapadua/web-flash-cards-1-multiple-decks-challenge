get '/deck' do
  if logged_in?
    @deck = Deck.all
    PlayingCard.destroy_all
    erb :'deck/index'
  else
    redirect '/'
  end
end


get '/deck/:deck_name' do
  if logged_in?
    @deck_name = params[:deck_name]
    user_id = session[:user_id]
    Round.round_setup(user_id, @deck_name)

    @possible_answers = [Round.card_in_play.term]

    until @possible_answers.count == 4
      @possible_answers << Deck.where(name: @deck_name).first.cards.sample.term
      @possible_answers.uniq!
    end

    if Round.cards_left_to_play.count > 0
      erb :'deck/play'
    else
      PlayingCard.destroy_all
      erb :'deck/round_stats'
    end
  else
    redirect '/deck'
  end
end

post '/deck/result' do
  if logged_in?
    user_guess = params[:option]
    @real_answer = params[:real_answer]
    @result = Round.check_guess(user_guess, @real_answer)
    deck_id = Round.last.deck_id
    @deck_name = Deck.find(deck_id).name

    erb :'deck/results'
  else
    redirect '/'
  end
end

get '/deck/card/play' do
  if logged_in?
    erb :'deck/play'
  else
    redirect '/'
  end
end

post '/deck/:deck_name' do
  @deck_name = params[:deck_name]

  redirect "/deck/#{@deck_name}"
end
