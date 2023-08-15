# frozen_string_literal: true

require "dry/transaction/operation"

module Projects
  class Update
    include Dry::Transaction::Operation

    def call(params)
      if params[:instance].update(params[:input])
        Success(params[:instance])
      else
        Failure(params[:instance])
      end
    end
  end
end
