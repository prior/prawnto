Rails.application.routes.draw do
  get "/default_render" => "test#default_render"
  get "/dsl_render" => "test#dsl_render"
  get "/instance_var_test" => "test#instance_var_test"
  get "/yield_block_in_helper_test" => "test#yield_block_in_helper_test"
  
  root :to => "test#default_render"
end
