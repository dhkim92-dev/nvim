local function insert_package_header()
    local file = vim.api.nvim_buf_get_name(0)
    if file == "" then return end
    if not file:match("%.kt$") and not file:match("%.java$") then
        return
    end

    print("[DEBUG] insert_package_header called for: " .. file)

    -- 이미 내용이 있는 버퍼는 건너뜀
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    if #lines > 0 and not (lines[1] == "") then
        print("[DEBUG] buffer not empty, skipping")
        return
    end

    -- src/main/java 또는 src/main/kotlin 기준으로 package 계산
    local src_java = file:find("/src/main/java")
    local src_kotlin = file:find("/src/main/kotlin")
    local package_path = ""

    if src_java then
        package_path = file:sub(src_java + #"/src/main/java" + 1) -- +1: "/" 다음부터
    elseif src_kotlin then
        package_path = file:sub(src_kotlin + #"/src/main/kotlin" + 1)
    else
        print("[DEBUG] src/main not found, skipping package insert")
        return
    end

    -- 파일명 제거, 경로 -> dot notation
    package_path = package_path:gsub("/[^/]+$", "")
    package_path = package_path:gsub("/", ".")
    print("[DEBUG] computed package: " .. package_path)

    -- 파일명 기반 클래스 생성
    local filename = vim.fn.fnamemodify(file, ":t:r")
    local ext = file:match("%.([^.]+)$")
    local insert_lines = {}

    if ext == "kt" then
        table.insert(insert_lines, "package " .. package_path)
        table.insert(insert_lines, "")
        table.insert(insert_lines, "class " .. filename .. " {")
        table.insert(insert_lines, "}")
    elseif ext == "java" then
        table.insert(insert_lines, "package " .. package_path .. ";")
        table.insert(insert_lines, "")
        table.insert(insert_lines, "public class " .. filename .. " {")
        table.insert(insert_lines, "}")
    end

    vim.api.nvim_buf_set_lines(0, 0, 0, false, insert_lines)
    print("[DEBUG] package and class inserted")
end

-- 이벤트 등록: BufNewFile, BufWritePost, BufReadPost
vim.api.nvim_create_autocmd({"BufNewFile", "BufWritePost", "BufReadPost"}, {
    pattern = {"*.kt", "*.java"},
    callback = function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        if #lines == 0 or (#lines == 1 and lines[1] == "") then
            -- vim.schedule로 지연 실행: NvimTree 등에서 열린 파일에도 적용
            vim.schedule(insert_package_header)
        end
    end
})

print("[DEBUG] autopackage.lua loaded")

