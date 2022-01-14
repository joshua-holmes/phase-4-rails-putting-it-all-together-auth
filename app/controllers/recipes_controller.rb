class RecipesController < ApplicationController

    def index
        if session.include? :user_id
            render json: Recipe.all, status: :created
        else
            render json: { errors: ["Not Authorized"] }, status: :unauthorized
        end
    end

    def create
        if session.include? :user_id
            recipe = User.find(session[:user_id]).recipes.create! recipe_params
            render json: recipe, status: :created
        else
            render json: { errors: ["Not Authorized"] }, status: :unauthorized
        end
    end

    private

    def recipe_params
        params.permit :title, :instructions, :minutes_to_complete
    end

end
