class DurationsController < ApplicationController
  before_filter :authenticate_user!

  def create
    durable_id   = params[:duration][:durable_id]
    durable_type = params[:duration][:durable_type]
    durable      = durable_type.constantize.find(durable_id)
    AddingADuration
      .new(current_user, durable)
      .call(
        success: ->{ redirect_to :back, notice: 'Duration added successfully' },
        failure: ->{ redirect_to :back, alert: 'Could not add duration' },
      )

  end

  def update
    duration = Duration.find(params[:id])
    UpdatingAResource
      .new(current_user, duration)
      .with(duration_params)
      .call(
        success: ->{ respond_to { |format| format.json { head :ok                   } } },
        failure: ->{ respond_to { |format| format.json { respond_with_bip(duration) } } },
      )
  end

  def destroy
    resource = Duration.find(params[:id])
    DestroyingAResource
      .new(current_user, resource)
      .call(
        success: ->{ respond_to { |format| format.html { redirect_to :back } } },
        failure: ->{ respond_to { |format| format.html { redirect_to :back } } },
      )
  end


  private

    def duration_params
      params.require(:duration).permit(:starts_at, :ends_at, :quantifier)
    end

end
