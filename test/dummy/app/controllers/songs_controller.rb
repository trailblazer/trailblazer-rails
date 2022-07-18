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

  #@ {#run} with variables
  module D
    class Song
      module Operation
        class Create < A::SongsController::Song::Operation::Create
          fail :add_user # run after {#contract}.

          def add_user(ctx, current_user:, session: nil, **)
            ctx[:"contract.default"] = %{#{ctx[:"contract.default"]}>>>#{current_user}>>>#{session}>>>}
          end
        end
      end
    end


    #:runtime-variables
    class SongsController < ApplicationController
      #~meths
      def current_user; 1;  end
      #~meths end
      def create
                                          # vvvvvvvvvvvvvvvvvvvvvvvvvv
        _ctx = run Song::Operation::Create, current_user: current_user do |ctx, model:, **|
          return redirect_to song_path(model.id)
        end

        @form = _ctx[:"contract.default"]

        render
      end
    end
    #:runtime-variables end
  end # D

  #@ {#run} with {#_run_options}
  module E
    class Song
      module Operation
        class Create < D::Song::Operation::Create
        end
      end
    end

    #:run-options
    class SongsController < ApplicationController
      private def _run_options(options)
        options.merge(
          current_user: current_user
        )
      end
      #~body
      #~meths
      def current_user; 1;  end
      #~meths end
      #:run-options-create
      def create
        _ctx = run Song::Operation::Create do |ctx, model:, **|
          return redirect_to song_path(model.id)
        end

        @form = _ctx[:"contract.default"]

        render
      end
      #:run-options-create end

      #@ we can pass options via #run and via #_run_options
      def patch
        _ctx = run Song::Operation::Create, session: 2 do |ctx, model:, **|
          return redirect_to song_path(model.id)
        end

        @form = _ctx[:"contract.default"]

        render :create
      end

      #@ we can pass options via #run and via #_run_options, and run options win.
      def put
        _ctx = run Song::Operation::Create, session: 2, current_user: 3 do |ctx, model:, **|
          return redirect_to song_path(model.id)
        end

        @form = _ctx[:"contract.default"]

        render :create
      end
      #~body end
    end
    #:run-options end
  end # E
end
