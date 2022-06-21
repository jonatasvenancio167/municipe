class MunicipesController < ApplicationController

  def index
    @filter = Municipe.joins(:address).ransack(params[:q])
    @object = @filter.result(distinct: true)
  end

  def new
    @municipe = Municipe.new
  end

  def create
    @municipe = Municipe.new(object_params)

    respond_to do |format|
      if @municipe.save
        format.html { redirect_to object_url(@municipe), notice: I18n.t("municipe.municipe_was_successfully_created") }
        format.json { render :show, status: :created, location: @municipe }

        respond_with @municipe, location: { action: 'index' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @municipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    puts "address --->#{params[:city]}"
    if @municipe.update(object_params)

      # @object.image.attach(params[@object.class.name.underscore][:image]) if object_params.has_key?(:image)
      # @object.bw_image.attach(params[@object.class.name.underscore][:bw_image]) if object_params.has_key?(:bw_image)

      respond_to @municipe, location: { action: 'index' }
    else
      respond_with @municipe
    end
  end

  private
  
  def object_params
    params.require(:municipe).permit(:full_name, :cpf, :cns, :email, :birth_date, :telephone, :status, :address_id, { addresses_attributes: [:cep, :public_place, :complement, :neighborhood, :city, :uf, :ibge_code] })
  end
end
