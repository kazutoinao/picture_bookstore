class Public::AddressesController < ApplicationController
    def  index
         @address=Address.new
         @addresses=current_customer.addresses
    end

    def  create
        @address=Address.new(address_params)
    if  @address.save!(address_params)
        redirect_to addresses_path(@address)
    end

    end

    def  edit
      @address=Address.find(params[:id])
    end

    def  update
      @address=Address.find(params[:id])
    if @address.update(address_params)
        redirect_to addresses_path(@address)
    else
       @address=Address.find(params[:id])
       render :edit
    end
    end



    def  destroy
    address=Address.find(params[:id])
    if address.customer_id == current_customer.id
    address.destroy
    redirect_to addresses_path
    end
    end

    private
    def address_params
        params.require(:address).permit(:postal_code, :address, :name)
    end
end