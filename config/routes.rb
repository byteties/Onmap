Rails.application.routes.draw do
	root 'infomaps#test'

	get 'infomaps/index' ,to: 'infomaps#index' , as: 'infomaps_index'
	get 'infomaps/test' ,to: 'infomaps#test' , as: 'infomaps_test'
end
