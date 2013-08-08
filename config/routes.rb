Routine::Application.routes.draw do
  resources :users
  resources :muscle_groups do
    member do
      get :ajax_exercises
    end
  end

  resources :workouts do
    member do
      put :complete
    end
  end

  resources :exercises do
    collection do
      get :ajax_search
    end
  end

  resources :workout_sets
  resources :user_sessions

  get "login" => "user_sessions#new"
  get "logout" => "user_sessions#destroy"

  root :to => "workouts#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
