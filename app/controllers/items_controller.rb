class ItemsController < ApplicationController

  def index
    @items = Item.all
    # render plain: @items.map { |i| "#{i.name}: #{i.price}"  }.join("\n")
  end

  def  create
    @item = Item.create(name: params[:name],
                description: params[:description],
                price: params[:price],
                weight: params[:weight],
                real: params[:real])
    render plain: "Item #{@item.id} created"
  end

  def show
    unless (@item = Item.where(id: params[:id]).first)
      render plain: "Page not found", status: 404
    end

  end

  def new

  end

  def update

  end

  def edit

  end

  def destroy

  end

end
