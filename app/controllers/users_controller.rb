class UsersController < ApplicationController
    def create
        if user_params[:password] == user_params[:password_confirmation]
            user = User.create(user_params)
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { errors: "Unprocessable entity" }, status: 422
        end
    end

    def show
        user = User.find_by(id: session[:user_id])
        if user
            render json: user, status: :ok
        else
            render json: {errors: "Unauthorized"}, status: 401
        end
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
