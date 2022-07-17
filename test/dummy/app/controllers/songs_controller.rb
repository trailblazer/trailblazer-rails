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

      #:block
      def create
        _ctx = run Song::Operation::Create do |ctx|
          # success!
          return redirect_to song_path(ctx[:model].id) # don't forget the return.
        end

        # failure
        @form = _ctx[:"contract.default"]

        render
      end
      #:block end
    end
  end # A

  #@ block with kwargs
  module C
    class SongsController < ApplicationController
      Song = A::SongsController::Song

      #:block-kwargs
      def create
        _ctx = run Song::Operation::Create do |ctx, model:,**|
          return redirect_to song_path(model.id) # see how model is available?
        end

        # failure
        @form = _ctx[:"contract.default"]

        render
      end
      #:block-kwargs end
    end
  end # c

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

  #@ invoke manually, no #run helper.
  module B
      Song = A::SongsController::Song
    #:manual
    class SongsController < ApplicationController
      def create
        result = Song::Operation::Create.(params: params) # manual invocation.
        #~meths

        if result.success?
          redirect_to song_path(result[:model].id)
        else # failure
          @form = result[:"contract.default"]

          render
        end
        #~meths end
      end
    end
    #:manual end
  end # B
end
