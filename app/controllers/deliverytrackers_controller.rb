class DeliverytrackersController < ApplicationController
  def index
    #matching_deliverytrackers = Deliverytracker.all
    matching_deliverytrackers = Deliverytracker.where({:user_id => session.fetch(:user_id)})
    @list_of_deliverytrackers = matching_deliverytrackers.order({ :created_at => :desc })
    @waiting_deliverytrackers = matching_deliverytrackers.where({:status=>"waiting_in"})
    @received_deliverytrackers = matching_deliverytrackers.where({:status=>"Received"})
    render({ :template => "deliverytrackers/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_deliverytrackers = Deliverytracker.where({ :id => the_id })

    @the_deliverytracker = matching_deliverytrackers.at(0)

    render({ :template => "deliverytrackers/show.html.erb" })
  end

  def create
    the_deliverytracker = Deliverytracker.new
    the_deliverytracker.content = params.fetch("query_content")
    the_deliverytracker.arrivedate = params.fetch("query_arrivedate")
    the_deliverytracker.details = params.fetch("query_details")
    the_deliverytracker.user_id = session.fetch(:user_id)
    the_deliverytracker.status = "waiting_in"
    
    if the_deliverytracker.valid?
      the_deliverytracker.save

      redirect_to("/deliverytrackers", { :notice => "Added to list."})
    else
      redirect_to("/deliverytrackers", { :alert => the_deliverytracker.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_deliverytracker = Deliverytracker.where({ :id => the_id }).at(0)
    the_deliverytracker.status = params.fetch("query_status")
    the_deliverytracker.user_id = session.fetch(:user_id)
    
    if the_deliverytracker.valid?
      the_deliverytracker.save
      redirect_to("/deliverytrackers", { :notice => "Deliverytracker updated successfully."} )
      
    else
      redirect_to("/deliverytrackers", { :alert => the_deliverytracker.errors.full_messages.to_sentence })
      
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_deliverytracker = Deliverytracker.where({ :id => the_id }).at(0)

    the_deliverytracker.destroy

    redirect_to("/deliverytrackers", { :notice => "Deliverytracker deleted successfully."} )
  end
end
