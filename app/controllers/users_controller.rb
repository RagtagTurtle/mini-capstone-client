class UsersController < ApplicationController
  def new
    render 'new.html.erb'
  end

  def create
    client_params = {
                      name: params[:name],
                      email: params[:email],
                      password: params[:password],
                      password_confirmation: params[:password_confirmation]
                      }

    response = Unirest.post(
                            "http://localhost:3000/users",
                            parameters: client_params
                            )
    
    if response.code == 200
      session[:user_id] = response.body["id"]
      flash[:success] = 'Successfully created account!'
      redirect_to '/'
    else
      flash[:warning] = 'Invalid email or password!'
      redirect_to '/signup'
    end
  end
end
