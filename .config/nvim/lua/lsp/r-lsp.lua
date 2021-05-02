--require'lspconfig'.r_language_server.setup{on_attach=custom_attach}
 require('lspconfig').r_language_server.setup {
     handlers = {
       ["textDocument/publishDiagnostics"] = vim.lsp.with(
         vim.lsp.diagnostic.on_publish_diagnostics, {
           underline = true,
	   signs = true,
	   update_in_insert = true,
           -- Disable virtual_text
           virtual_text = false,
         }
       ),
     }
   }

