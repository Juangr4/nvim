return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    spec = {
      mode = { 'n' },
      { '<leader>f', group = ' [F]iles' },
      { '<leader>s', group = ' [S]earch' },
      { '<leader>w', group = ' [W]indow' },
      { '<leader>t', group = ' [T]ab Keymaps' },
      { '<leader>g', group = ' [G]it' },
      { '<leader>d', group = ' [D]iagnostics' },
      { '<leader>b', group = ' [B]uffers' },
      { '<leader>l', group = ' Uti[l]s' },
      { '<leader>c', group = ' [C]ode' },
      { '<leader>q', group = ' [Q]uit' },
    },
  },
}
