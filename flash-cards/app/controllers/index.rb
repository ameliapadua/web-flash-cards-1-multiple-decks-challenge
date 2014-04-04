get '/' do
  if logged_in?
    redirect '/deck'
  else
    erb :index
  end
end
