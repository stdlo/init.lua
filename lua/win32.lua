if vim.fn.has("win32") == 1 then
    vim.opt.shell = "powershell"
    -- vim.let.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    -- vim.let.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    -- vim.let.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    -- vim.opt.shellquote = ""
    -- vim.opt.shellxquote = ""

    vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    vim.o.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.o.shellquote = ''
    vim.o.shellxquote = ''

        --     let &shell = has('win32') ? 'powershell' : 'pwsh'
        -- let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
        -- let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        -- let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        -- set shellquote= shellxquote=
end
