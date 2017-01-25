Rails.application.routes.draw do
	root 'infomaps#test'

	get 'infomaps/index' ,to: 'infomaps#index' , as: 'infomaps_index'
	post 'infomaps/circle' ,to: 'infomaps#circle' ,as: 'infomaps_circle'
	get 'infomaps/point',to:'infomaps#point',as:'infomaps_point'
	get 'infomaps/draw' ,to: 'infomaps#draw' , as: 'infomaps_draw'
	get 'infomaps/test' ,to: 'infomaps#test' , as: 'infomaps_test'
	get 'infomaps/testajax',to: 'infomaps#testajax', as: 'infomaps_testajax'

end
