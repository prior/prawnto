Rails.application.routes.draw do
  get "/default_render" => "test#default_render"
  get "/dsl_render" => "test#dsl_render"
  
  root :to => "test#default_render"
end
