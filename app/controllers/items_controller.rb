class ItemsController < ApplicationController

  # before actions is like decorators in Django
  # can create is_admin filter for instance
  before_action :find_item, only: [:edit, :update, :destroy, :upvote]
  before_action :check_if_admin, only: [:edit]

  def index
    @items = Item.all
  end

  def hot
    @items =Item.where("votes_count > 10")
    puts @items
    render "index"
  end

  def show
    unless (@item = Item.where(id: params[:id]).first)
      render_404
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
    # @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to @item
    else
      render 'edit'
    end
  end

  def edit
    # @item = Item.find(params[:id])
  end

  def destroy
    # @item = Item.find(params[:id])
    @item.destroy
    redirect_to '/items'
  end

  def upvote
    @item.increment!(:votes_count)
    redirect_to action: :index
  end


  private
    def item_params
      params.require("item").permit(:price, :description, :weight, :name)
    end

    def find_item
      @item = Item.where(id: params[:id]).first
      unless @item
        render_404
      end
    end


end
