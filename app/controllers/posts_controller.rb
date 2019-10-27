class PostsController < ApplicationController
  include Spa

  private
    # Устанавливаем модель для консёрна
    def set_model
      @model = Post.joins(:user, :topic).order(:created_at)
    end
    
    # Указываем поля, по которым можно производить фильтрацию 
    def filter_fields
      [:theme_id, :topic_id]
    end

    # Определяем поля, которые допустимы при сабмите формы
    def resource_params
      # Топик нам нужен для того, чтобы устанавливать его заголовок, как дефолтный заголовок для постов
      topic = Topic.find(params[:post][:topic_id])
      title = params[:post][:title]

      params.require(:post).permit(:content, :title, :topic_id)
      .merge({
        theme_id: topic.theme_id,
        user_id: current_user.id,
        title: title.present? ? title : "Re: #{topic.title}"
      })
    end
end