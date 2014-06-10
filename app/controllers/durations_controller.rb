class DurationsController < ApplicationController
  before_filter :authenticate_user!

  def create
    durable_id   = params[:duration][:durable_id]
    durable_type = params[:duration][:durable_type]
    adder        = current_user
    durable      = durable_type.constantize.find(durable_id)
    create_duration = AddingADuration.new(adder, durable)
    create_duration.command(self)
    create_duration.execute
  end
  def create_failure
    redirect_to :back, alert: 'Could not add duration'
  end
  def create_success
    redirect_to :back, notice: 'Duration added successfully'
  end


  def update
    duration = Duration.find(params[:id])
    updating_a_duration = UpdatingADuration.new(current_user, duration)
    updating_a_duration.command(self)
    updating_a_duration.execute(duration_params)
  end
  def update_failure(duration)
    respond_to do |format|
      format.json { respond_with_bip(duration) }
    end
  end
  def update_success(duration)
    respond_to do |format|
      format.json { head :ok }
    end
  end

  private

    def duration_params
      params.require(:duration).permit(:starts_at, :ends_at)
    end


end
