get '/cards/new' do
  erb :"/cards/new"
end

post '/cards/new' do
  @card = Card.create(definition: params[:definition], term: params[:term], deck_id: session[:new_deck_id])
end

get '/cards/error' do
  erb :"/cards/error"
end
