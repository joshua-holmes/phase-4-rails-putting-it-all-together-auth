class SessionsController < ApplicationController

    def create
        user = User.find_by username: params[:username]
        if user&.authenticate params[:password]
            session[:user_id] ||= user.id
            render json: user
        else
            render json: { errors: user&.errors&.full_messages || ["Not Authorized"] }, status: :unauthorized
        end
    end

    def destroy
        if session.include? :user_id
            session.delete :user_id
            render head: :no_content, status: :no_content
        else
            render json: { errors: ["Not Authorized"] }, status: :unauthorized
        end
    end

end
