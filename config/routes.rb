Rails.application.routes.draw do
  get 'fredit/revision' => "fredit#revision"
  get 'fredit' => "fredit#show"
  put 'fredit' => "fredit#update"
  post 'fredit' => "fredit#create"
end

