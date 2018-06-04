class Client::CartedProductsController < ApplicationController

  def index
    response = Unirest.get(
                            "http://localhost:3000/api/carted_products"
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

  def destroy
    carted_product_id = params[:id]
    response = Unirest.delete("http://localhost:3000/api/carted_products/#{carted_product_id}")
    redirect_to "/client/carted_products"
  end
end
