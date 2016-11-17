Rails.application.routes.draw do
	root 'infomaps#index'

	get 'infomaps/index' ,to: 'infomaps#index' , as: 'infomaps_index'
	get 'infomaps/draw' ,to: 'infomaps#draw' , as: 'infomaps_draw'
	get 'infomaps/test' ,to: 'infomaps#test' , as: 'infomaps_test'
end
