class ItemsController < ApplicationController

  def index
    @items = Item.all
    # render plain: @items.map { |i| "#{i.name}: #{i.price}"  }.join("\n")
  end

  def show
    unless (@item = Item.where(id: params[:id]).first)
      render plain: "Page not found", status: 404
    end
  end

  def new
    @item = Item.new
  end

  def  create
    # @item = Item.create(name: params[:name],
    #                     description: params[:description],
    #                     price: params[:price],
    #                     weight: params[:weight],
    #                     real: params[:real])
    # render plain: "Item #{@item.id} created"
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item
    else
      render "new"
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to @item
    else
      render 'edit'
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to item_path
  end

  private
    def item_params
      params.require("item").permit(:price, :description, :weight, :name)
    end

end
