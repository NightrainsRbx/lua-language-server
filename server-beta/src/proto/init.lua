local proto   = require 'proto.proto'
local util    = require 'utility'
local cap     = require 'proto.capability'
local pub     = require 'pub'
local task    = require 'task'

proto.on('initialize', function (params)
    --log.debug(util.dump(params))
    return {
        capabilities = cap.initer,
    }
end)

proto.on('initialized', function (params)
    return true
end)

proto.on('exit', function ()
    log.info('Server exited.')
    os.exit(true)
end)

proto.on('shutdown', function ()
    log.info('Server shutdown.')
    return true
end)

proto.on('textDocument/hover', function ()
    return {
        contents = {
            value = 'Hello loli!',
            kind  = 'markdown',
        }
    }
end)

proto.on('textDocument/didOpen', function (params)
    local doc   = params.textDocument
    local uri   = doc.uri
    local text  = doc.text
    local state = pub.task('compile', text)
end)

proto.on('textDocument/didClose', function (params)
end)

proto.on('textDocument/didChange', function (params)
    local doc    = params.textDocument
    local change = params.contentChanges
    local uri    = doc.uri
    local text   = change[1].text
    local state  = pub.task('compile', text)
end)

return proto