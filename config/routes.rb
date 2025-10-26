class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

BonsaiErp::Application.routes.draw do
  resources :item_accountings
  draw :api
  draw :app

  # `draw` 内で実行時分岐は書けない.
  root to: "home#index"

  # Chart of accounts
  resources :accounts

end
