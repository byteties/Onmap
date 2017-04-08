Rails.application.routes.draw do
	root 'infomaps#index'

	get 'infomaps/index' ,to: 'infomaps#index' , as: 'infomaps_index'
	get 'infomaps/point',to:'infomaps#point',as:'infomaps_point'
	get 'infomaps/test' ,to: 'infomaps#test' , as: 'infomaps_test'

	get 'storages/getjson',to: 'storages#getjson', as: 'storages_getjson'

	get 'places/index',to: 'places#index', as: 'places_index'
	get 'places/findplace',to: 'places#findplace', as: 'places_findplace'
end
