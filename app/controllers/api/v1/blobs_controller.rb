module Api
  module V1
    class BlobsController < ApplicationController
      def url
        blob = ActiveStorage::Blob.find_signed(params[:id])
        render json: { url: blob.url }
      end
    end    
  end
end
