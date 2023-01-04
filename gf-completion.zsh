compdef _gf gf

function _gf {
    local options
    options=$(gf -list)

    _arguments "1: :($options)"
}
