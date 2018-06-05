class Client::ProductsController < ApplicationController
  def index
    client_params = {
                      search: params[:search],
                      sort_by: params[:sort_by],
                      sort_order: params[:sort_order],
                      category: params[:category]
                      }

    response = Unirest.get(
                            "http://localhost:3000/api/products",
                            parameters: client_params
                            )
    @products = response.body
    render 'index.html.erb'
  end

  def new
    @product = {}
    render 'new.html.erb'
  end

  def create
    @product = {
                    'name' => params[:name],
                    'price' => params[:price],
                    'description' => params[:description],
                    'supplier_id' => params[:supplier_id]
                    }
    response = Unirest.post("http://localhost:3000/api/products",
                            parameters: @product
                            )
    
    if response.code == 200
      flash[:success] = "Successfully Created Product"
      redirect_to "/client/products/"
    elsif response.code == 401
      flash[:warning] = "You are not an authorized to make products, mudafucka"
      redirect_to "/"
    else 
      @errors = response.body["errors"]
      render 'new.html.erb'
    end
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
    @product = {
                      'id' => params[:id],
                      'name' => params[:name],
                      'price' => params[:price],
                      'description' => params[:description],
                      'supplier_id' => params[:supplier_id],
                      'supplier' => {'id' => params[:supplier_id]}
                      }
    response = Unirest.patch(
                            "http://localhost:3000/api/products/#{params[:id]}",
                            parameters: @product
                            )
    if response.code == 200
      flash[:success] = "Successfully Updated Product"
      redirect_to "/client/products/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not authorized to update products, mudafucka"
      redirect_to "/"
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end
  end

  def destroy
    product_id = params[:id]
    response = Unirest.delete(
                              "http://localhost:3000/api/products/#{ product_id}"
                              )
    if response.code == 200
      flash[:success] = "Succesfully Deleted Product"
      redirect_to "/"
    else
      flash[:warning] = "You aren not authorized to delete products, mudafucka"
      redirect_to "/"
    end
  end
end
