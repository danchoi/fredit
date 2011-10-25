Rails.application.routes.draw do
  get "/fredit" => "fredit#index"
  post "/fredit/update" => "fredit#update"
end

