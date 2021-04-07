Rails.application.routes.draw do
  get 'cube/show'
  get 'cube/setup'
	post 'cube/solve'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	root to: 'cube#setup'
end
