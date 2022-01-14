class UsersController < ApplicationController

    def create
        user = User.create! user_params
        unless user.password == user.password_confirmation
            raise ActiveRecord::RecordInvalid
        end
        session[:user_id] ||= user.id
        render json: user, status: :created
    end

    def show
        if session.include? :user_id
            user = User.find session[:user_id]
            render json: user, status: :created
        else
            render json: { error: "Not Authorized" }, status: :unauthorized
        end
    end

    def method_name
        
    end

    private

    def user_params
        params.permit :username, :password, :password_confirmation, :image_url, :bio
    end

end
