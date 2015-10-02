# 0.1.4

* Treat `:js` requests as non-document, too.
* `Controller#form` now returns the form object and not the operation.
* In `Controller`, `#form`, `#present`, `#run` and `#respond` now all have the same API: `run(constant, options)`. If you want to pass a custom params hash, use `run Comment::Create, params: {..}`.

# 0.1.3

* `Operation::contract` works properly with `Operation::ActiveModel` mixed in.

# 0.1.2

* First version running with Trailblazer 1.0.0.