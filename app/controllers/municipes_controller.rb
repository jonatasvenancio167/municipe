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

  def edit
  end

  def show
  end

  def update
    respond_to do |format|
      if @municipe.update(municipe_params)

        MunicipeMailer.with(user: @municipe).welcome_email.deliver_now!
        SendSms.new(@municipe).call

        format.html { redirect_to municipe_url(@municipe), notice: t('notice.registration_updated_successfully') }
        format.json { render :show, status: :ok, location: @municipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @municipe.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def paginate
    @municipe = Municipe.limit(5)
    @municipe.page(1).per(20).size
    @municipe.page(1).per(20).total_count
  end

  def set_municipe
    @municipe = Municipe.find(params[:id])
  end

  def municipe_params
    params.require(:municipe).permit(
      :full_name, :cpf, :cns, :email, :birth_date, :telephone, :image,
      :status, { address_attributes: [:cep, :public_place, :complement, :neighborhood, :city, :uf,
      :ibge_code] }
    )
  end
end
