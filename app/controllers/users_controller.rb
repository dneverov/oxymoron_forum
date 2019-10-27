class UsersController < ApplicationController
  include Spa

  def touch
    current_user.touch if current_user
    render json: {}
  end

  def rate
    if current_user.votes.include?(params[:id].to_i)
      return render json: {msg: "Вы уже влияли на репутацию пользователя"}, status: 422
    end

    current_user.votes.push(params[:id].to_i)
    current_user.save

    set_resource
    if params[:positive]
      @resource.increment!(:rating)
    else
      @resource.decrement!(:rating)
    end

    render json: {rating: @resource.rating}
  end

  def metrics
    result = current_user.attributes.slice("posts_count", "rating") if current_user
    render json: result || {}
  end

  def ban
    authorize @resource
    @resource.update(banned: true)
    render json: {msg: "Пользователь был забанен"}
  end

  def unban
    authorize @resource, :ban?
    @resource.update(banned: false)
    render json: {msg: "Пользователь был разбанен"}
  end

  private
    def set_model
      @model = User
    end
end