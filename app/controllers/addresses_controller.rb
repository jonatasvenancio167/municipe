class AddressesController < ApplicationController

  def index;  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(object_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to object_url(@address), notice: I18n.t("address.address_was_successfully_created") }
        format.json { render :show, status: :created, location: @address }

        respond_with @address, location: { action: 'index' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    puts "address --->#{params[:city]}"
    if @address.update(object_params)

      # @object.image.attach(params[@object.class.name.underscore][:image]) if object_params.has_key?(:image)
      # @object.bw_image.attach(params[@object.class.name.underscore][:bw_image]) if object_params.has_key?(:bw_image)

      respond_to @address, location: { action: 'index' }
    else
      respond_with @address
    end
  end

    
    private

    def address_params
      params.require(:address).permit(:cep, :public_place, :complement, :neighborhood, :city, :uf, :ibge_code, :municipe_id)
    end
end
