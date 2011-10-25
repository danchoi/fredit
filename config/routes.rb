Rails.application.routes.draw do
  get 'fredit(/:file)' => "fredit#show", :as => :fredit
  put 'fredit' => "fredit#update"
  post 'fredit' => "fredit#create"
end

