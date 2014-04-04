get '/deck' do
  if logged_in?
    @deck = Deck.all
    erb :'deck/index'
  else
    redirect '/'
  end
end

get '/deck/:deck_name' do
  if logged_in?
    @cards = Deck.where(name: params[:deck_name]).first.cards

    @cards_left_to_play = @cards.to_a
    @card_in_play = @cards.sample

    @cards_left_to_play - [@card_in_play] #figure out

    @possible_answers = [@card_in_play.term]

    until @possible_answers.count == 4
      @possible_answers << @cards.sample.term
      @possible_answers.uniq!
    end

    if @cards_left_to_play.length > 0
      erb :'deck/play'
    else
      erb :'deck/round_stats'
    end
  else
    redirect '/'
  end
end

post '/deck/play' do
  if logged_in?
    redirect '/'
  else
    redirect '/'
  end
end

post '/deck/result' do
  if logged_in?
    redirect '/'
  else
    redirect '/'
  end
end

