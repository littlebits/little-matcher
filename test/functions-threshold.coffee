M = require('../lib/index')



describe 'threshold functions', ->

  it '$cross', ->
    test = M(a:$cross:50)
    eq test(a:10), false # initial is always false!
    eq test(a:60), true
    eq test(a:40), true
    eq test(a:50), false # becuase *not* OrEqual semantic!
    eq test(a:51), true
    eq test(a:48), false # hysteresis size is 48-50
    eq test(a:47), true # triggers because beyond hysteresis zone

  it '$crossGreaterThan:x', ->
    test = M(a:$crossGreaterThan:50)
    eq test(a:10), false
    eq test(a:50), false
    eq test(a:60), true
    eq test(a:48), false
    eq test(a:60), false
    eq test(a:47), false
    eq test(a:60), true

  it '$crossGreaterThanOrEqual:x', ->
    test = M(a:$crossGreaterThanOrEqual:50)
    eq test(a:10), false
    eq test(a:50), true
    eq test(a:60), false
    eq test(a:49), false
    eq test(a:60), false
    eq test(a:48), false
    eq test(a:60), true

  it '$crossLessThan:x', ->
    test = M(a:$crossLessThan:50)
    eq test(a:10), true

    eq test(a:50), false
    eq test(a:49), false

    eq test(a:52), false
    eq test(a:49), false

    eq test(a:53), false
    eq test(a:49), true

  it '$crossLessThanOrEqual:x', ->
    test = M(a:$crossLessThanOrEqual:50)
    eq test(a:10), true

    eq test(a:50), false
    eq test(a:49), false

    eq test(a:51), false
    eq test(a:49), false

    eq test(a:52), false
    eq test(a:49), true
