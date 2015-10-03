# 0.1.5

* Treat all requests as `params` requests unless the operation has a representer mixed in. If you don't want that, you can override using `is_document: false`. This appears to be the smoothest solution for all. Thanks to @Scharrels for discussion.
* In `Controller#form`, the options argument is now passed into `form.prepopulate!(options)`. This allows to use arbitrary options and the `options[:params]` for prepopulation. Thanks @sauy7 for discussion.

# 0.1.4

* Treat `:js` requests as non-document, too.
* `Controller#form` now returns the form object and not the operation.
* In `Controller`, `#form`, `#present`, `#run` and `#respond` now all have the same API: `run(constant, options)`. If you want to pass a custom params hash, use `run Comment::Create, params: {..}`.

# 0.1.3

* `Operation::contract` works properly with `Operation::ActiveModel` mixed in.

# 0.1.2

* First version running with Trailblazer 1.0.0.