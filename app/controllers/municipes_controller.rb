class MunicipesController < ApplicationController
  before_action :set_municipe, only: %i[ show edit update ]

  def index
    @municipe = Municipe.all
    @municipe = @municipe.filter_by_cpf(params[:search_municipe][:cpf]) if params[:search_municipe]

    paginate
  end

  def new
    @municipe = Municipe.new
    @municipe.build_address
  end

  def create
    @municipe = Municipe.new(municipe_params)

    respond_to do |format|
      if @municipe.save

        MunicipeMailer.with(user: @municipe).welcome_email.deliver_now!
        SendSms.new(@municipe).call

        format.html { redirect_to municipe_url(@municipe), notice: t('notice.registration_created_successfully') }
        format.json { render :show, status: :created, location: @municipe }
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
