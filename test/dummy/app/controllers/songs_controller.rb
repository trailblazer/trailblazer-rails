class SongsController < ApplicationController
  def new
    run Song::Operation::New
  end

  module A
    class SongsController < ApplicationController
      module Song
        module Operation
          class New < Trailblazer::Operation
            step :contract

            def contract(ctx, params:, **)
              ctx[:model] = Struct.new(:id).new(1)
              ctx[:"contract.default"] = "I'm a form!"
              params[:success] # allow to test both outcomes.
            end
          end

          class Create < New
          end
        end
      end

      #:ctx
      def new
        ctx = run Song::Operation::New

        @form = ctx[:"contract.default"]

        render
      end
      #:ctx end

      def create
        _ctx = run Song::Operation::Create do |ctx|
          # success!
          return redirect_to song_path(ctx[:model].id) # don't forget the return.
        end

        # failure
        @form = _ctx[:"contract.default"]

        render
      end
    end
  end # A

  def show
    run Song::Operation::Show
  end

  def create
    run Song::Operation::Create do
      return redirect_to song_path(@model.id)
    end

    render :new
  end

  def new_with_result
    run Song::Operation::New

    @class = @model.class
  end

  def with_variables
    run Params::Operation::WithVariables, controller_name: self.class.to_s

    render html: %{<h1>#{@model.inspect}</h1>}.html_safe
  end
end
