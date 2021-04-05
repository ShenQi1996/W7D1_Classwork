class UsersController < ApplicationController

    def new
        @user = User.new
        # debugger
        render :new        
    end

    def create
        @user = User.new(user_params)
        # debugger
        if @user.save
            render json: @user
            # debugger
        else
            render "Please try again"
        end
    end

    private

    def user_params
        # debugger
        params.require(:user).permit(:user_name, :password)
    end

end