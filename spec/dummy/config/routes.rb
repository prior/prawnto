Rails.application.routes.draw do
  get "/default_render" => "test#default_render"
  root :to => "test#default_render"
end
