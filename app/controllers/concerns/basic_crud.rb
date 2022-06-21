module BasicCrud
  extend ActiveSupport::Concern 

  included do
    before_action :set_model
    before_action :set_object, only: [:show, :edit, :update]
  end

  def index
    @object = @model.all
  end

  def new
    @object = @model.new
  end

  def create
    @object = @model.new(object_params)

    respond_to do |format|
      if @object.save
        format.html { redirect_to object_url(@object), notice: I18n.t("municipe.municipe_was_successfully_created") }
        format.json { render :show, status: :created, location: @object }

        respond_with @object, location: { action: 'index' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @object.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @object.update(object_params)

      attach_data_from_csv if object_params.has_key?(:file)

      # @object.image.attach(params[@object.class.name.underscore][:image]) if object_params.has_key?(:image)
      # @object.bw_image.attach(params[@object.class.name.underscore][:bw_image]) if object_params.has_key?(:bw_image)

      respond_to @object, location: { action: 'index' }
    else
      respond_with @object
    end
  end

  private

  def set_model
    @model = controller_name.classify.constantize
    # authorize @model
  end

  def set_object
    @object = @model.find(params[:id])
    # authorize @object
  end
end