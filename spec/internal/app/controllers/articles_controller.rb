class ArticlesController < ActionController::Base
  before_action :load_ransack_search, only: :index

  def index
    @articles = @ransack_search.result
    render plain: 'index'
  end
end
