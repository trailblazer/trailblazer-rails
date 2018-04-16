# 1.0.8

* Fixed Circular dependency detected in rails 5.2

# 1.0.7

* Fixed typo error in use_loader config flag

# 1.0.6 (revoked)

* Introduce use_loader config flag

# 1.0.5

* Hook trailblazer application_controller initializer to finisher_hook

# 1.0.4

* Make `Railtie::extend_application_controller!` overwriteable via a module.

# 1.0.3

* Return the computed application controller constant from `Railtie::extend_application_controller!` to make `compat` code simpler.

# 1.0.2

* Allow configuring `ApplicationController` constant via `config.trailblazer.application_controller`.

# 1.0.1

* Allow using this gem without `cells,` by loading cells support only when the `cells` gem got detected. Thanks to @promisedlandt.

# 1.0.0

* Runs only with >= Trailblazer 2.0.0.
* Removed `Controller#form`, `#present` and `#respond`. The latter is now [replaced with `Endpoint`](https://github.com/trailblazer/trailblazer-endpoint/). The only operation trigger is `Controller#run`.
* Added support for explicit `render cell(Artist::Cell::Index, model)`.
* Autoloading got replaced with explicit requires.

# 0.4.0

* Better engines support.
* Fix `Responder#errors` by simply removing it and letting `Operation#errors` return the contract errors.

# 0.3.2

* Make it work with Rails 3.x, again.

# 0.3.1

* Fix loading of `reform-rails`.

# 0.3.0

* Require `reform-rails` as a static dependency. This simplifies the user's setup significantly.
* Run the `Railtie` after `reform.form_extensions` and allow reform-rails to do its setup work, then load concepts.

# 0.2.4

* Require `trailblazer-loader-0.0.7`.
* Fix sorting, model files are now always required first.
* Manually include `Operation::Controller` in `ApplicationController` for every reload.

# 0.2.3

* Bump to `trailblazer-loader` 0.0.4.

# 0.2.2

* Remove cells loading code, this happens via trailblazer-loader now.
* We now load the concept's model file if it exists.

# 0.2.1

* Require `trailblazer-loader`.

# 0.2.0

* Use `trailblazer-loader` for loading operations and associated files, now. Note that `operations.rb` now is `operation.rb` (hence the minor bump).
* The `Operation::Controller` module is not included into `ApplicationController` automatically.
* Added `Trailblazer::Test::Integration`.

# 0.1.6

* Fix `Controller#run`, which now returns the operation instance instead of the `Else` object.

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
