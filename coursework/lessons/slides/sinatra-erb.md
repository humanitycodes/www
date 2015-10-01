## Serving an HTML file

Instead of just serving text, it's useful to

get '/' do
  erb :home
end

get '/about' do
  erb :about
end

views/home.erb
views/about.erb
