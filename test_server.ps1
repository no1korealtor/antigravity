$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8081/")
$listener.Start()
Write-Host "Started"
while ($listener.IsListening) {
    $context = $listener.GetContext()
    $response = $context.Response
    $html = Get-Content 'd:\부동산업무\antigravity\index.html' -Raw -Encoding UTF8
    $css = Get-Content 'd:\부동산업무\antigravity\index.css' -Raw -Encoding UTF8
    $html = $html -replace '<link rel="stylesheet" href="index.css">', "<style>$css</style>"
    $buffer = [System.Text.Encoding]::UTF8.GetBytes($html)
    $response.ContentLength64 = $buffer.Length
    $response.OutputStream.Write($buffer, 0, $buffer.Length)
    $response.OutputStream.Close()
}
