class AvailableProductsController < ApplicationController

  respond_to :html, :json

  before_action :set_colors_sizes, only: :index
  before_action :valid_params?,    only: [ :create, :update ]

  def index
  end

  def list
    render json: AvailableProduct.includes(:product,:color,:size).all.order('products.name'), include: [ 'product', 'color', 'size' ], status: :ok
  end

  def show
    render json: AvailableProduct.includes(:product,:color,:size).find(params[:id].to_i), include: [ 'product', 'color', 'size' ], status: :ok
  end

  def create
    product = Product.create(name: params[:product_name], description: params[:product_descr])

    AvailableProduct.create(
      product: product,
      color:   Color.find(params[:color_id].to_i),
      size:    Size.find(params[:size_id].to_i),
      qtd:     params[:qtd].to_i
    )

    render json: { message: 'Gravado com sucesso' }, status: :ok
  end

  def update
    ava_prod = AvailableProduct.find(params[:available_product_id].to_i)

    ava_prod.product.name        = params[:product_name]
    ava_prod.product.description = params[:product_descr]
    ava_prod.product.save

    ava_prod.color = Color.find(params[:color_id].to_i)
    ava_prod.size  = Size.find(params[:size_id].to_i)

    ava_prod.qtd = params[:qtd]

    ava_prod.save

    render json: { message: 'Atualizado com sucesso' }, status: :ok
  end

  private

  def valid_params?
    if params[:product_name].blank? or params[:product_name].length < 3 or params[:product_name].length > 100
      render_error('Preencha corretamente o campo Nome do Produto',:bad_request)
    elsif params[:product_descr].blank?
      render_error('Preencha corretamente o campo Descrição do Produto',:bad_request)
    elsif params[:color_id].blank?
      render_error('Escolha a cor do produto.',:bad_request)
    elsif params[:size_id].blank?
      render_error('Escolha o tamanho do produto.',:bad_request)
    elsif params[:qtd].blank? or (not params[:qtd].to_i >= 0)
      render_error('Quantidade inválida.',:bad_request)
    end
  end

  def render_error(msg,status)
    render json: { message: msg }, status: status
  end

  def set_colors_sizes
    @colors = Color.all.order(:name)
    @sizes  = Size.all.order(:name)
  end

end
