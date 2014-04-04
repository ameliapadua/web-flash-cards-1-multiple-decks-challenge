get '/deck' do
  if logged_in?
    @deck = Deck.all
    erb :'deck/index'
  else
    redirect '/'
  end
end
