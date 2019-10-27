class TopicsController < ApplicationController
  include Spa

  private
    def set_model
      @model = Topic.joins(:theme, :user).order("topics.updated_at DESC")
    end

    def filter_fields
      [:theme_id]
    end

    def redirect_options
      {
        create: {
          redirect_to_url: topic_path(@resource)
        },
        update: {
          redirect_to_url: topic_path(@resource)
        }
      }
    end

    def resource_params
      params.require(:topic).permit(:title, :content, :theme_id)
      .merge({
        user_id: current_user.id
      })
    end
end