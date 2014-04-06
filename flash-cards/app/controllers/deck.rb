get '/deck' do
  if logged_in?
    @deck = Deck.all
    user_id = session[:user_id]
    Round.create(user_id: user_id)
    PlayingCard.destroy_all
    erb :'deck/index'
  else
    redirect '/'
  end
end

get '/decks/new' do
  erb :"/deck/new"
end

post '/decks/new/new_deck' do
  @deck = Deck.new(name: params[:deck_name], user_id: session[:user_id])
  if @deck.save
    session[:new_deck_id] = @deck.id
    redirect "/cards/new"
  else
    redirect '/decks/new'
  end
end

get '/deck/:deck_name' do
  if logged_in?
    @deck_name = params[:deck_name]
    user_id = session[:user_id]

    Round.round_setup(user_id, @deck_name)

    current_deck = Deck.where(name: @deck_name).first
    current_round = Round.last
    @possible_answers = [Round.card_in_play.term]


    until @possible_answers.count == 4
      @possible_answers << current_deck.cards.sample.term
      @possible_answers.uniq!
    end
    puts "=================================="
    puts "Card count: #{current_deck.cards.count}"
    puts "Guess count: #{current_round.guesses.count}"
    puts "=================================="
    if current_deck.cards.count == current_round.guesses.count
      erb :'deck/round_stats'
    else
      erb :'deck/play'
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
