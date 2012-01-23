Rails.application.routes.draw do
  get "/default_render" => "test#default_render"
  get "/dsl_render" => "test#dsl_render"
  get "/complex" => "test#complex"
  
  root :to => "test#default_render"
end
