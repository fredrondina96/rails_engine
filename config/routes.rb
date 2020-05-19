Rails.application.routes.draw do
  namespace :api do
   namespace :v1 do
     resources :merchants, except: [:new, :edit] do
      resources :items, only: [:index]
     end

     resources :items, except: [:new, :edit]
     get '/items/:item_id/merchant', to: 'merchants#show'
   end
 end
end
