class Client::ProductsController < ApplicationController
  def index
    client_params = {
                      search: params[:search],
                      sort_by: params[:sort_by],
                      sort_order: params[:sort_order]
                      }

    response = Unirest.get(
                            "http://localhost:3000/api/products",
                            parameters: client_params
                            )
    @products = response.body
    render 'index.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    client_params = {
                    name: params[:name],
                    price: params[:price],
                    description: params[:description],
                    image_url: params[:image_url]
                    }
    response = Unirest.post("http://localhost:3000/api/products",
                            parameters: client_params
                            )
    product = response.body
    flash[:success] = "Successfully Created Product"
    redirect_to "/client/products/#{product["id"]}"
  end

  def show
    product_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/products/#{product_id}")
    @product = response.body
    render 'show.html.erb'
  end

  def edit
    product_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/products/#{product_id}")
    @product = response.body
    render 'edit.html.erb'
  end

  def update
    client_params = {
                      name: params[:name],
                      price: params[:price],
                      description: params[:description],
                      image_url: params[:image_url]
                      }
    response = Unirest.patch(
                            "http://localhost:3000/api/products/#{params[:id]}",
                            parameters: client_params
                            )
    product = response.body
    flash[:success] = "Successfully Updated Product"
    redirect_to "client/products/#{product["id"]}"
  end

  def destroy
    product_id = params[:id]
    response = Unirest.delete(
                              "http://localhost:3000/api/products/#{ product_id}"
                              )
    flash[:success] = "Succesfully Deleted Product"
    redirect_to "/"
  end
end
