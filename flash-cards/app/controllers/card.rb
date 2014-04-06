get '/cards/new' do
  puts "In the /cards/new route. The session contains: #{session.inspect}"
  puts "The new deck id is #{session[:new_deck_id].inspect}"
  erb :"/cards/new"
end

post '/cards/new' do
  @card = Card.create(definition: params[:definition], term: params[:term], deck_id: session[:new_deck_id])
  # if @card.valid?
  #   session[:message] = 'card added!'
  # else
  #   session[:message] = 'you suck!'
  #   # erb :"/cards/new"
  #   #redirect '/cards/error'
  # end
  # erb :'/cards/new'
end

# get '/cards/error' do
#   erb :"/cards/error"
# end
