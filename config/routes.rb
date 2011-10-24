Rails.application.routes.draw do
  get "/front_edit" => "front_edit#index"
  post "/front_edit/update" => "front_edit#update"
end

