module Web
  module Controllers
    module Api
      class CustomersController < Web::Controllers::ApplicationController
        BASE_FIELDS = %i[id name document_number email phone search_param]

        def index
          render json: Application::Customer::CustomerApplication.new.find_all,
            each_serializer: ::Serializers::Domain::Customer::CustomerSerializer
        end

        def show
          customer = if CPF.valid?(customer_params[:search_param])
            Application::Customer::CustomerApplication.new.find_by_document_number(customer_params[:search_param])
          else
            Application::Customer::CustomerApplication.new.find_by_id(customer_params[:search_param])
          end

          render json: customer, include: :vehicles, serializer: ::Serializers::Domain::Customer::CustomerSerializer
        end

        def create
          customer = Application::Customer::CustomerApplication.new.create_customer(
            Application::Customer::Commands::CreateCustomerCommand.new(customer: customer_params)
          )

          render json: customer, status: :created, serializer: ::Serializers::Domain::Customer::CustomerSerializer
        end

        def update
          command = Application::Customer::Commands::UpdateCustomerCommand.new(customer_attributes: customer_params)
          customer = Application::Customer::CustomerApplication.new.update_customer(command)

          render json: customer, serializer: ::Serializers::Domain::Customer::CustomerSerializer
        end

        def destroy
          command = Application::Customer::Commands::DeleteCustomerCommand.new(customer_id: customer_params[:id])

          Application::Customer::CustomerApplication.new.delete_customer(command)

          head :ok
        end

        private

        def customer_params
          params.permit(BASE_FIELDS)
        end
      end
    end
  end
end
