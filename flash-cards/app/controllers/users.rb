post '/login' do
  if User.authenticate(params[:email], params[:password])
    session[:user_id] = User.where(password: params[:password]).first.id
    redirect '/deck'
  else
    erb :index
  end
end

get '/deck' do
  if logged_in?
    @deck = Deck.all
    erb :'deck/index'
  else
    redirect '/'
  end
end

get '/log_out' do
  session.clear
  redirect '/'
end
