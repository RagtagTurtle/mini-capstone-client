class Client::CartedProductsController < ApplicationController

  def index
    client_params = {
                      carted_products_id: params[:id],
                      product_id: params[:product_id],
                      quantity: params[:quantity]
                      }
    response = Unirest.get(
                            "http://localhost:3000/api/carted_products",
                            parameters: client_params
                            )
    @carted_products = response.body
    render 'index.html.erb'
  end

  def create
    client_params = {
                      product_id: params[:product_id],
                      quantity: params[:quantity]
                      }
    response = Unirest.post(
                            "http://localhost:3000/api/carted_products",
                            parameters: client_params
                            )
    @carted_product = response.body
    flash[:success] = "Successfully added products to cart"
    redirect_to "/client/carted_products"
  end

  def show
    response = Unirest.get("http://localhost:3000/api/carted_products/#{:id}")
    @carted_product = response.body
    render 'show.html.erb'
  end
end
