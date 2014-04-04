get '/' do
  # Look in app/views/index.erb
  if logged_in?
    redirect '/deck'
  else
    erb :index
  end
end
