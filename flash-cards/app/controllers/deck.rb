get '/deck' do
  @deck = Deck.all
  erb :'deck/index'
end

get '/deck/:deck_name' do
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
end

post '/deck/play' do

end

post '/deck/result' do

end
