Rails.application.routes.draw do
  get "/simple_render" => "test#simple_render"
  root :to => "test#simple_render"
end
