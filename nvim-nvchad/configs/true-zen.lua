local present, truZen = pcall(require, "true-zen")

if not present then
  return
end

local options = {
  ui = {
    top = {
      showtabline = 0
    },
    left = {
      number = false
    }
  },
  mode = {
    atraxis = {
      left_mapping = 3,
      right_mapping = 3,
      top_padding = 1,
      bottom_padding = 0,
      auto_padding = false
    }
  }
}

truZen.setup(options)
