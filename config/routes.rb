Rails.application.routes.draw do
	root 'infomaps#index'

	get 'infomaps/index' ,to: 'infomaps#index' , as: 'infomaps_index'
	get 'infomaps/point',to:'infomaps#point',as:'infomaps_point'
	get 'infomaps/test' ,to: 'infomaps#test' , as: 'infomaps_test'
	get 'infomaps/testmap' ,to: 'infomaps#testmap' , as: 'infomaps_testmap'
	get 'infomaps/testcontrol' ,to: 'infomaps#testcontrol' , as: 'infomaps_testcontrol'

	get 'storages/getjson',to: 'storages#getjson', as: 'storages_getjson'

	get 'places/index',to: 'places#index', as: 'places_index'
	get 'places/findplace',to: 'places#findplace', as: 'places_findplace'
	get 'places/test',to: 'places#test', as: 'places_test'
end
