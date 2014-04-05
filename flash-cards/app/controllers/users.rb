post '/login' do
  if User.authenticate(params[:email], params[:password])
    session[:user_id] = User.where(email: params[:email]).first.id
    redirect '/deck'
  else
    erb :index
  end
end

get '/log_out' do
  session.clear
  redirect '/'
end

post '/create_user' do
  @user = User.new(name: params[:name], email: params[:email], password: params[:password])
  if @user.save
    session[:user_id] = User.where(password: params[:password]).first.id
    redirect '/deck'
  else
    erb :index
  end
end

