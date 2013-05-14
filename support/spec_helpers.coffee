# a number of jasmine-jquery helpers / extensions
# it totally used to do this natively, but now doesn't...



class_mixer = ttm.require('lib/class_mixer')

class RegexpSpecFilter
  initialize: (@regexp)->
  forSpec: (spec)->
    spec.getFullName().toLowerCase().match @regexp

class_mixer RegexpSpecFilter

override_spec_filter_with = RegexpSpecFilter.build(/calc/)
override_spec_filter_with = false

if override_spec_filter_with
  env = jasmine.getEnv()
  env.specFilter = (spec)->
    override_spec_filter_with.forSpec spec


jasmine.getFixtures().findContainer = ->
  $(document.body).find("##{@containerId}")

jasmine.getFixtures().getContainer = ->
  cont = @findContainer()
  if cont.length == 0
    @createContainer_("")
    cont = @findContainer()
  cont

window.f = (html="")->
  cont = jasmine.getFixtures().getContainer();
  if html.length > 0
    cont.html(html)
  cont


beforeEach ->
  @addMatchers(
    toBeInstanceOf: (type)->
      @message = ->
        if @actual == undefined
          "Expected undefined to be an instance of #{type.name}"
        else
          "Expected #{@actual.constructor.name}(#{jasmine.pp @actual}) to be an instance of #{type.name}"

      @actual && @actual instanceof type

    toBeAnEqualExpressionTo: (other)->

      @message = ->
        "Expected #{@actual}.isEqual(#{jasmine.pp other}) to be true"
      @actual && other && ttm.require('lib/math/expression_equality').isEqual(@actual, other)
  )


