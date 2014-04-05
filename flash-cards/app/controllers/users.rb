post '/login' do
  if User.authenticate(params[:email], params[:password])
    session[:user_id] = User.where(password: params[:password]).first.id
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

get '/users/:id/stats' do
  if logged_in? && any_rounds?
    @round_stats = create_rounds_hash
    erb :'users/show'
  elsif logged_in? && !any_rounds?
    erb :'users/show'
  else
    redirect '/'
  end
end

get '/users/:id/edit' do
  if logged_in?
    @current_user
    erb :"users/edit"
  else
    redirect '/'
  end
end

post '/users/:id' do
  @user = User.find(params[:id])
  if @user.update(params[:user])
    redirect "/users/#{@user.id}/stats"
  else
    erb :"users/edit"
  end
end
